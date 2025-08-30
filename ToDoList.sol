// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ToDo{

struct Task {
    string content;
    bool completed;

}
mapping(address=>Task[]) public tasks;


event TaskCreated(address indexed user, uint taskId, string content);
event TaskCompleted(address indexed user, uint taskId);
event TaskDeleted(address indexeduser, uint taskid);
event TaskUpdated(address indexed user, uint taskId, string content);
         function addTask(string memory _content) public {
        require(bytes(_content).length > 0, "Task cannot be empty");

        tasks[msg.sender].push(Task({
            content: _content,
            completed: false
        }));

        emit TaskCreated(msg.sender, tasks[msg.sender].length - 1 , _content);
 }


function getTask(uint _taskid) public view returns(string memory, bool) {
    require(_taskid < tasks[msg.sender].length, "Invalid task ID");

    Task storage task = tasks[msg.sender][_taskid];
    return (task.content, task.completed);
}


 function completeTask(uint _taskid) public {
require(_taskid < tasks[msg.sender].length, "invaild Task ID");
 Task storage task = tasks[msg.sender][_taskid];

    if (task.completed) {
        revert("Task already completed");
    }

    task.completed = true;
emit TaskCompleted(msg.sender, _taskid);
 }

 function getTaskCount() public view returns (uint) {
    return tasks[msg.sender].length;
}

function checkInvariant() public view {
    assert(tasks[msg.sender].length >= 0); // always true
}

function deleteTask(uint _taskid) public {
   require(_taskid < tasks[msg.sender].length, "Invalid task ID");
   uint lastindex = tasks[msg.sender].length -1;

// if not the last index than replace with last

if(_taskid!=lastindex){
tasks[msg.sender][_taskid] = tasks[msg.sender][lastindex];

}
tasks[msg.sender].pop();
emit TaskDeleted(msg.sender, _taskid);
}

function updatetask(uint _taskid, string memory _newcontent) public{
require(_taskid<tasks[msg.sender].length, "invaild Task ID");
require(bytes(_newcontent).length > 0, "Task cannot be empty");
    Task storage task = tasks[msg.sender][_taskid];
    task.content = _newcontent;


emit TaskUpdated(msg.sender, _taskid, _newcontent);
}

function getAllTasks() public view returns (string[] memory, bool[] memory) {
    uint count = tasks[msg.sender].length;

    string[] memory contents = new string[](count);
    bool[] memory statuses = new bool[](count);

    for (uint i = 0; i < count; i++) {
        Task storage task = tasks[msg.sender][i];
        contents[i] = task.content;
        statuses[i] = task.completed;
    }

    return (contents, statuses);
}

}