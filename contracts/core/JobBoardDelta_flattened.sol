
// File: @openzeppelin/contracts/utils/math/SafeMath.sol


// OpenZeppelin Contracts (last updated v4.9.0) (utils/math/SafeMath.sol)

pragma solidity ^0.8.0;

// CAUTION
// This version of SafeMath should only be used with Solidity 0.8 or later,
// because it relies on the compiler's built in overflow checks.

/**
 * @dev Wrappers over Solidity's arithmetic operations.
 *
 * NOTE: `SafeMath` is generally not needed starting with Solidity 0.8, since the compiler
 * now has built in overflow checking.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}

// File: @openzeppelin/contracts/token/ERC20/IERC20.sol


// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.20;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the value of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the value of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves a `value` amount of tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 value) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets a `value` amount of tokens as the allowance of `spender` over the
     * caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 value) external returns (bool);

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to` using the
     * allowance mechanism. `value` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}

// File: contracts/interfaces/IJobBoardDelta.sol



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


// File: contracts/core/JobBoardDelta.sol



pragma solidity >=0.8.2 <0.9.0;




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