// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract StudentReg{
    // 1. Enum Grade: A, B, C, D, F
    enum Grade {A, B, C, D, F }
    
    // 2. Struct Student: name, age, grade (enum)
    struct Student{

        string name;
        uint age;
        Grade grade;
    }

    
    // 3. Mapping: studentId (uint) => Student
    mapping (uint => Student) public students;
    // 4. Array: store all student IDs
    uint[] public studentIds;
    // 5. Function: addStudent(uint _id, string memory _name, uint _age, Grade _grade)
    function addStudent(uint _id, string memory _name, uint _age, Grade _grade) public {

        studentIds.push(_id);
        students[_id] = Student(_name, _age, _grade);
    }
    // 6. Function: getStudent(uint _id) returns details
    function getStudent (uint _id) public view returns(string memory, uint, Grade) {
        return (students[_id].name, students[_id].age, students[_id].grade);
    }
    // 7. Function: updateGrade(uint _id, Grade _newGrade)
    function updateGrade(uint _id, Grade _new_grade) public {


        students[_id].grade = _new_grade;
    }
    // 8. Function: getTotalStudents() returns length of array
    function Get_total_Students() public view returns(uint){

        return studentIds.length;
    }
    // 9. Function: getAllIds() returns the array
     function getAllIds() public view returns (uint[] memory) {
        return studentIds;}
}

