// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract VotingSystem {
    address public admin;

    struct Voter {
        bool authorized;
        bool voted;
        uint voteIndex;
    }

    struct Proposal {
        string name;
        uint voteCount;
    }

    mapping(address => Voter) public voters;
    Proposal[] public proposals;

    uint public totalVotes;

    constructor(string[] memory proposalNames) {
        admin = msg.sender;
        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin");
        _;
    }

    function authorize(address _voter) public onlyAdmin {
        voters[_voter].authorized = true;
    }

    function vote(uint _proposalIndex) public {
        Voter storage sender = voters[msg.sender];
        require(sender.authorized, "Not authorized to vote");
        require(!sender.voted, "Already voted");

        sender.voted = true;
        sender.voteIndex = _proposalIndex;

        proposals[_proposalIndex].voteCount += 1;
        totalVotes += 1;
    }

    function getProposalCount() public view returns (uint) {
        return proposals.length;
    }

    function getProposal(uint _index) public view returns (string memory name, uint voteCount) {
        Proposal storage proposal = proposals[_index];
        return (proposal.name, proposal.voteCount);
    }

    function winningProposal() public view returns (uint winningIndex, string memory winnerName) {
        uint winningVoteCount = 0;
        for (uint i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > winningVoteCount) {
                winningVoteCount = proposals[i].voteCount;
                winningIndex = i;
            }
        }
        winnerName = proposals[winningIndex].name;
    }
}
