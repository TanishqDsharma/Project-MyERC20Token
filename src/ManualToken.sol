pragma solidity ^0.8.16;

contract ManualToken {


    /////////////
    ///Errors////
    ////////////

    error ManualToken__OnlyOwnerCanMintTheTokens();


    //Is used to store the total supply of the token. It is defined as public and can be queried by anyone.
    uint256 public s_tokenSupply ;

    // This address will be responsible for controlling minting and token circulation. 
    address private s_owner; 
    
    //To track token balances efficiently: we are using mapping to store the balance corresponding to each address
    mapping (address => uint) public s_balances;

    constructor(){
        s_owner=msg.sender;
    }


    //////////////////////////////////
    //Public and External Functions/// 
    /////////////////////////////////

    /**
     * 
     * @param recipient Address that will mint the tokens
     * @param amount Amounts of token needs to be minted
     */
    function mint(address recipient,uint256 amount) public {
        
        //Performing check to verify that Owner is minting tokens
        if(msg.sender==s_owner){
            revert ManualToken__OnlyOwnerCanMintTheTokens();
        }
        //Updating the balance of the recipient
        s_balances[recipient]+=amount;

        //Updating the total supply
        s_tokenSupply+=amount;
    } 

}