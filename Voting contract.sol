// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting{

    address public owner;
    uint public votingEnd;

    struct proposal{
        string name;
        uint voteCount;
 }

proposal[] public proposals;
mapping ( address => bool) public hasVoted;

constructor(uint _duarationInMinutes){

    owner = msg.sender;
    votingEnd = block.timestamp + (_duarationInMinutes * 1 minutes);
}

event ProposalAdded(string name);
event Voted(address voter, uint ProposalIndex);

function addproposal( string memory _name) public {

require(msg.sender==owner, "only owner can add");
proposals.push(proposal(_name,0));

 emit ProposalAdded(_name);

}

function vote(uint proposalIndex)  public {
    require(block.timestamp < votingEnd, "voting ended");
    require(proposalIndex < proposals.length, "Invalid index");
    require(!hasVoted[msg.sender], "you already voted");

hasVoted[msg.sender] = true;

    proposals[proposalIndex].voteCount++;
    emit Voted(msg.sender, proposalIndex);
}

function GetWinner() public view returns(string memory winnername) {
uint higestVotes;
uint winnerindex;
for ( uint i = 0; i < proposals.length; i++){
    if(proposals[i].voteCount> higestVotes ) {
    higestVotes = proposals[i].voteCount;
    winnerindex = i;
    }
}
winnername = proposals[winnerindex].name;
}
}