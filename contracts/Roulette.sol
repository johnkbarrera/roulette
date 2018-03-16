pragma solidity ^0.4.18;

contract Roulette {

    uint public basePrice;
    uint public playersTop;

    bool state;
    uint public memberOfList;

    struct player {
        string name;
        address adr;
        uint pos;
    }
    mapping (uint => player) public playerlist;
    event InitialData (uint basePrice, uint playersTop, uint memberOfList);
    //event MessageData (string msg,uint time, bool state);
    event MessageData (bool state);
    event WinnerData (address adr , string name);

    function Roulette() public {
      basePrice = 1 * 100000000000000000;
      playersTop =  3;
      memberOfList = 0;
      state = true;
      InitialData(basePrice,playersTop,memberOfList);
      MessageData(state);
    }

    /* functions of help*/
    function addPlayerToList(string _name, address _address) private {
        memberOfList += 1;
        playerlist[memberOfList].pos = memberOfList;
        playerlist[memberOfList].adr = _address;
        playerlist[memberOfList].name = _name;
    }

    function rafflingAndfinishing() private {
      uint winer = (block.timestamp % playersTop) + 1;
      playerlist[winer].adr.transfer(this.balance);
      state = false;

      WinnerData(playerlist[winer].adr,playerlist[winer].name);
      MessageData(state);
    }
     function participate(string nameplayer) public payable {
      if(state == true && msg.value == basePrice){
        addPlayerToList(nameplayer, msg.sender);
        if(memberOfList>=playersTop){
          rafflingAndfinishing();
        }
        InitialData(basePrice,playersTop,memberOfList);
      }else{
        MessageData(state);
        revert();
      }
    }


}
