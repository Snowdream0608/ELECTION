pragma solidity ^0.5.0; 

contract Election {

  //每人（账号）只能投一票很容易实现，只需要使用一个mapping 来记录每个地址的投票信息
  mapping(address => bool) public voters;

  //候选人及得票数
  struct Candidate {
    uint id;
    string name;  // 候选人的名字
    uint voteCount;
  }

  //候选人总数
  uint public candidatesCount;

  //通过id作为key访问映射candidates来取候选人
  mapping(uint => Candidate) public candidates;

  function addCandidate (string memory _name) private {
      candidatesCount ++;
      candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
  }

  constructor () public {
        addCandidate("Tiny 熊");
        addCandidate("Big 熊");
  }

  // voted event
  event votedEvent (
      uint indexed _candidateId
  );

  function vote (uint _candidateId) public {
      require(!voters[msg.sender]);
      require(_candidateId > 0 && _candidateId <= candidatesCount);

      voters[msg.sender] = true;
      candidates[_candidateId].voteCount ++;
      emit votedEvent(_candidateId);
  }
  




}