// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

struct Job {
    uint256 id; 
    string cid; 
    uint256 postedDate; 
    uint256 expiredDate; 
    bool available; 
    address owner; 
}

struct Reward {
    address erc20; 
    uint256 totalReward; 
    uint256 individualReward; 
    uint256 distributed; 
}

struct Applicant {
    uint256 id; 
    string resumeCid; 
    uint256 chainId;
    address rewardAddress; 
    bool referral; 
}

enum Duration {ONE_WEEK, TWO_WEEKS, ONE_MONTH}

interface IJobBoardDelta { 


    function getJobIds() view external returns (uint256 [] memory _ids);

    function getJob(uint256 _jobId) view external returns (Job memory _job);

    function makeJobUnavailable(uint256 _jobId) external returns (Job memory _job);

    function postJob(string memory _cid, Duration _duration) payable external returns (Job memory _job);

    function hasReward(uint256 _jobId) view external returns (bool _hasReward);

    function getPrice(Duration _duration)  view external returns (uint256 _price);

    function getPaymentErc20() view external returns (address _paymentErc20);

    function getJobReward(uint256 _jobId) view external returns (Reward memory _reward);

    function getApplicant(uint256 _applicantId) view external returns (Applicant memory _applicant);

    function applyForJob(uint256 _jobId, string memory _resumeCid, uint256 _rewardChainId, address _rewardAddress, bool _isReferral) external returns (uint256 _applicantCount);

    function getApplicantIds(uint256 _jobId) view external returns (uint256 [] memory _jobIds);

    function approveRewards(uint256 _jobId, uint256 [] memory _applicantIds) external returns (uint256 _rewardedCount);

    function addReward(uint256 _jobId, address _erc20, uint256 _rewardAmount, uint256 _amountPerApplicant) payable external returns (Reward memory _reward);

    function getOwnerJobIds() view external returns (uint256 [] memory _jobIds);

}

