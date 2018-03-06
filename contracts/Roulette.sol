pragma solidity ^0.4.18;

contract Roulette {

    uint public basePrice;
    uint public playersTop;

    bool state;
    uint public memberOfList;

    struct player {
        string name;
        address adr; // person direction
        uint pos; // mount
    }
    /*Maps*/
    mapping (uint => player) public playerlist;
    /* Events*/
    event InitialData (uint basePrice, uint playersTop, uint memberOfList);
    event MessageData (string msg,uint time, bool state);
    event WinnerData (string msg, address adr);

    /* Constructor */
    function Roulette() public {                //  uint _basePrice, uint _playersTop
      basePrice = 1 * 1000000000000000000;      // _basePrice;
      playersTop =  3;                          //  _playersTop;
      memberOfList = 0;
      state = true;
      InitialData(basePrice,playersTop,memberOfList);
      MessageData('Juego Creado',block.timestamp,state);
    }

    /* functions of help*/
    function addPlayerToList(string _name, address _address) private {
        memberOfList += 1;
        playerlist[memberOfList].pos = memberOfList;
        playerlist[memberOfList].adr = _address;
        playerlist[memberOfList].name = _name;
    }

    function rafflingAndfinishing() private {
      // elect winner
      uint winer = (block.timestamp % playersTop) + 1;
      // reward the winner
      playerlist[winer].adr.transfer(this.balance);
      state = false;

      WinnerData('Ganador es: ',playerlist[winer].adr);
      MessageData('Juego terminado',block.timestamp,state);
    }

    function Balance() public view returns(uint) {
      uint bal = msg.sender.balance;
  		return bal;
  	}

    /*Mains functions*/
     function participate(string _name) public payable {
      if(state == true){
        // add player to list
        addPlayerToList( _name, msg.sender);
        if(memberOfList>=playersTop){
          //finish the play
          rafflingAndfinishing();

        }
        InitialData(basePrice,playersTop,memberOfList);
      }else{
        MessageData('Juego ya terminado',block.timestamp,state);
        revert();
      }
    }


}
