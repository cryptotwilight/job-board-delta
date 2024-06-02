// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "../interfaces/IJobBoardDelta.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract JobBoardDelta is IJobBoardDelta {

    modifier onlyAdmin() {
        require(msg.sender == admin, "admin only");
        _;
    }

    address constant NATIVE = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    address immutable self; 

    uint256 index;

    address admin; 
    address immutable paymentErc20; 
    uint256 immutable chainId; 

    uint256 [] jobIds;
    mapping(uint256=>Job) jobById; 
    mapping(address=>uint256[]) jobIdByOwner; 
    mapping(uint256=>bool) hasRewardByJobId; 
    mapping(uint256=>Reward) rewardByJobId; 
    mapping(Duration=>uint256) priceByDuration; 
    mapping(uint256=>uint256[]) applicantIdsByJobId; 
    mapping(uint256=>Applicant) applicantById; 
    mapping(uint256=>mapping(uint256=>bool)) isApplicantByApplicantIdByJobId;

    constructor(address _admin, address _paymentErc20, uint256 _chainId) {
        admin = _admin; 
        paymentErc20 = _paymentErc20; 
        self = address(this);
        chainId = _chainId; 
    }

    function getJobIds() view external returns (uint256 [] memory _ids){
        return jobIds;
    }

    function getJob(uint256 _jobId) view external returns (Job memory _job){
        return jobById[_jobId];
    }

    function hasReward(uint256 _jobId) view external returns (bool _hasReward) {
       return hasRewardByJobId[_jobId];
    }

    function makeJobUnavailable(uint256 _jobId) external returns (Job memory _job){
        require(jobById[_jobId].owner == msg.sender, "job owner only");
        jobById[_jobId].available = false; 
        return jobById[_jobId];
    }

    function getPrice(Duration _duration)  view external returns (uint256 _price) {
        return priceByDuration[_duration];
    }

    function getPaymentErc20() view external returns (address _paymentErc20) {
        return paymentErc20; 
    }

    function getJobReward(uint256 _jobId) view external returns (Reward memory _reward) {
        return rewardByJobId[_jobId];
    }

    function getApplicant(uint256 _applicantId) view external returns (Applicant memory _applicant) {
        return applicantById[_applicantId];
    }

    function applyForJob(uint256 _jobId, string memory _resumeCid, uint256 _rewardChainId, address _rewardAddress, bool _isReferral) external returns (uint256 _applicantCount) {
        require(jobById[_jobId].available == true, "job unavailable");
        uint256 applicantId_ = getId();
        applicantById[applicantId_] = Applicant({
                                                    id : applicantId_,
                                                    resumeCid : _resumeCid,
                                                    chainId : _rewardChainId,
                                                    rewardAddress : _rewardAddress,
                                                    referral : _isReferral
                                                });
        applicantIdsByJobId[_jobId].push(applicantId_);
        return applicantIdsByJobId[_jobId].length; 
    }

    function getApplicantIds(uint256 _jobId) view external returns (uint256 [] memory _jobIds) {
        return applicantIdsByJobId[_jobId];
    }

    function approveRewards(uint256 _jobId, uint256 [] memory _applicantIds) external returns (uint256 _rewardedCount) {
         require(jobById[_jobId].owner == msg.sender, "job owner only");

        for(uint256 x = 0; x < _applicantIds.length; x++) {
            uint256 applicantId_ = _applicantIds[x];
             uint256 remaining_ = rewardByJobId[_jobId].totalReward - rewardByJobId[_jobId].distributed; 
            if(isApplicantByApplicantIdByJobId[_jobId][applicantId_] && remaining_ > 0){
                 Applicant memory applicant_ = applicantById[applicantId_];
                 uint256 transferAmount_ = 0; 
                 if(remaining_ >= rewardByJobId[_jobId].individualReward){
                    transferAmount_ = rewardByJobId[_jobId].individualReward;
                 }
                 else {
                     transferAmount_ = remaining_; 
                 }
                 rewardByJobId[_jobId].distributed += transferAmount_;
                 if(applicant_.chainId == chainId) {
                    transferOut(rewardByJobId[_jobId].erc20, transferAmount_, applicant_.rewardAddress);
                 }
                 else { 
                    transferOutCrossChain(rewardByJobId[_jobId].erc20, transferAmount_, applicant_.rewardAddress, applicant_.chainId);
                 }

                _rewardedCount++; 
            }
        }
    }

    function postJob(string memory _cid, Duration _duration) payable external returns (Job memory _job){
        uint256 jobId_ = getId();
        uint256 fee_ = priceByDuration[_duration];

        require(transferIn(paymentErc20, fee_), "payment transfer failed");

        jobIds.push(jobId_);
        jobById[jobId_] = Job({
                                id : jobId_, 
                                cid : _cid,  
                                postedDate : block.timestamp, 
                                expiredDate : getDuration(_duration) + block.timestamp,
                                available : true, 
                                owner : msg.sender
                        });
        jobIdByOwner[msg.sender].push(jobId_);
        return _job; 
    }

    function addReward(uint256 _jobId, address _erc20, uint256 _rewardAmount, uint256 _amountPerApplicant) payable external returns (Reward memory _reward) {
        require(jobById[_jobId].owner == msg.sender, "job owner only");
        require(jobById[_jobId].available == true, "job unavailable");

        require(transferIn(_erc20, _rewardAmount), "reward transfer failed");

        hasRewardByJobId[_jobId] = true; 
        rewardByJobId[_jobId] = Reward({
                                         erc20  : _erc20,
                                         totalReward : _rewardAmount, 
                                         individualReward : _amountPerApplicant,
                                         distributed : 0
                                        });
        return rewardByJobId[_jobId];
    }

    function getOwnerJobIds() view external returns (uint256 [] memory _jobIds) {
        return jobIdByOwner[msg.sender];
    }

    function setPrice(Duration _duration, uint256 _price) external onlyAdmin returns (bool _set) {
        priceByDuration[_duration] = _price; 
        return true; 
    }

    //============================================ INTERNAL ==================================================

    function getId() internal returns (uint256 _id) {
        _id = index++;
        return _id; 
    }

    function getDuration(Duration _duration) pure internal returns (uint256 _seconds) {
        _seconds = 60 * 60 * 24 * 7;
        if(_duration == Duration.ONE_WEEK) {
            return _seconds; 
        }

        if(_duration  == Duration.TWO_WEEKS) {
            return _seconds * 2;
        }

        if(_duration == Duration.ONE_MONTH) {
            return _seconds * 4; 
        }
    }

    function transferIn(address _erc20, uint256 _amount ) internal returns (bool _success) {
        if(_erc20 == NATIVE){
            require(msg.value >= _amount, "insufficient funds transmitted");
            return true; 
        }
        else {
           IERC20 erc20_ = IERC20(_erc20);
           erc20_.transferFrom(msg.sender, self, _amount);
            return true; 
        }
    }

    function transferOut(address _erc20, uint256 _amount , address _destination) internal returns (bool _success) {
        if(_erc20 == NATIVE){
            payable(_destination).transfer(_amount);
            return true; 
        }
        else {
           IERC20 erc20_ = IERC20(_erc20);
           erc20_.transferFrom(self, _destination, _amount);
            return true; 
        }
    }

    function transferOutCrossChain(address _erc20, uint256 _amount , address _destination, uint256 _destinationChain) internal returns (bool _success) {

    }

}