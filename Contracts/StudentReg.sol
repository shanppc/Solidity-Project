// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract StudentReg{
    
//Fixed and Dynamic Arr. 
    uint[3] public num;
    uint[] public values;

    //Dynamic array to store struct data. ya struct ky data ko store kry ga.
   Student[] public students;

// Struct aiksay zayda datatypes ko store create kar sakta ha-
// Struct multiple datatype ko create kar sakta ha.
   struct Student{
    uint id;
    string name;
    uint8 age;
  }

 
 // ya function student ko register karta ha. student ko id khud ba khud deta ha jab us ka nam or age enter kary to.
  function addStudent(string memory _name,uint8 _age) external {
   students.push (Student({
        id: students.length,
        name: _name,
        age: _age
    }));

  }

   // stduent ko find karo us ki id say. 
  function getStudent(uint8 _id) public view returns(uint, string memory, uint8){
      require(_id>0 && _id<= students.length, "Invalid Id");
      return (students[_id].id, students[_id].name, students[_id].age);

  }

  // Total Students jo registered ha vo kitny ha? is function ki help sy hum ya dekh satky ha
  function totalStudents() public view returns(uint){
    uint TotalStudents = students.length;
    return TotalStudents-= 1;
  }



}
