pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

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
