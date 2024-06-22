pragma solidity ^0.8.16;

contract ManualToken {


    /////////////
    ///Errors////
    ////////////

    error ManualToken__OnlyOwnerCanMintTheTokens();
    error ManualToken__NotEnoughbalance();


    //Is used to store the total supply of the token. It is defined as public and can be queried by anyone.
    uint256 public s_tokenSupply ;

    // This address will be responsible for controlling minting and token circulation. 
    address private s_owner; 
    
    //To track token balances efficiently: we are using mapping to store the balance corresponding to each address
    mapping (address => uint) public s_balances;

    constructor(uint256 initialSupply){
        s_owner=msg.sender;

        //Minting the initial supply of tokens to the issuer provides them with an initial allocation for distribution.
        mint(msg.sender,initialSupply );       
    }


    //////////////////////////////////
    //Public and External Functions/// 
    /////////////////////////////////

    /**
     * 
     * @param recipient Address that will get the tokens
     * @param amount Amounts of token needs to be minted
     */
    function mint(address recipient,uint256 amount) public {
        
        //Performing check to verify that Owner is minting tokens
        if(msg.sender==s_owner){
            
            //Updating the balance of the recipient
            s_balances[recipient]+=amount;

            //Updating the total supply, since we have minted new tokens,we also need to update the total amount of tokens issued,
            s_tokenSupply+=amount;
        }else{
            revert ManualToken__OnlyOwnerCanMintTheTokens();

        }
       
    } 

    //A function used to query the balance corresponding to an address
    function balanceOf(address account) public view returns(uint256){
        return s_balances[account];
    }

    /**
     * 
     * @param recipient Address that is receiving the tokens
     * @param amount Amount of tokens being transferred
     * @dev  Transfer function that allows users to transfer tokens
     */
    function transfer(address recipient, uint256 amount) public returns(bool){
        require(amount<=s_balances[msg.sender],"Not Enough Balance");
        s_balances[msg.sender]-=amount;
        s_balances[recipient]+=amount;
        //To provide a clear signal to the calling function or external user that the transfer operation completed without any errors or exceptions, 
        //we need to return a boolean value of true.
        return true;
    } 

    function burn(uint256 amountToBurn) public {
        require(s_balances[msg.sender] >= amountToBurn, "Insufficient balance");
        s_balances[msg.sender]-=amountToBurn;
        s_tokenSupply-=amountToBurn;
    }

    /////////////////////
    //Getter Functions///
    ////////////////////

    function getOwner() public returns(address){
        return s_owner;
    }
}
