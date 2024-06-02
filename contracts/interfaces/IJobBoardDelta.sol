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








}

