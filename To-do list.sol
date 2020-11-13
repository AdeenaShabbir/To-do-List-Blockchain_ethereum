pragma solidity ^0.6.0;

contract Ownable {
    address payable private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor () internal {
        _owner = msg.sender;
        emit OwnershipTransferred(address(0), _owner);
    }

    function owner() public view returns (address payable) {
        return _owner;
    }

    modifier onlyOwner() {
        require(_owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }

   
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }
 
}


contract TodoList is Ownable{
    
    uint public count=0;
    
    struct Task{
        uint id;
        string mytask; 
        bool check;
    }
    

    mapping(uint => Task) tasks;
    
    event TaskCreated(
    uint id,
    string content,
    bool check
    );
    
    event TaskCompleted(
    uint id,
    bool check
    );
  
    function createTasks (string memory _mytask) public onlyOwner{
        count++;
        tasks[count] = Task(count, _mytask, false);
        emit TaskCreated(count, _mytask, false);
    }
    
    function checkoffTasks (uint _id) public onlyOwner{
        Task memory currenttask = tasks[_id];
        currenttask.check = !currenttask.check;
        tasks[_id] = currenttask;
        emit TaskCompleted(_id, currenttask.check);
    } 
    
}

