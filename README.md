# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.ts
```



# Degenstore
A create on ERC20 token and deploy it on the Avalanche network for Degen Gaming. The smart contract should have the following functionality. Minting new tokens, Transferring tokens, Redeeming tokens, Checking token balance, Burning tokens


# Description
create a ERC20 token and deploy it on the Avalanche network for Degen Gaming. The smart contract should have the following functionality:

1.Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
2.Transferring tokens: Players should be able to transfer their tokens to others.
3.Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
4.Checking token balance: Players should be able to check their token balance at any time.
5.Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.


# Getting Started
# Executing program
To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.


Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., degenstore.sol). Copy and paste the following code into the file:



// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenStore is ERC20, Ownable {
    uint256 totalItem = 1;

    struct GameStore {
        string name;
        uint256 price;
    }

    mapping(uint256 => GameStore) gamestore;


    constructor() ERC20("Degen", "DGN")Ownable(msg.sender) {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount * 1e18);
    }

    function setStoreItem(string memory _Itemname, uint256 _price) external onlyOwner{
        require(_price > 0, "Invalid Price");

        GameStore storage gm = gamestore[totalItem];
        gm.name = _Itemname;
        gm.price = _price * 1e18;

        totalItem++;
    }

    function transferToken(address to, uint256 amount) external returns(bool){
        uint256 _amount = amount * 1e18;
        require(_amount <= balanceOf(msg.sender), "Error: Not Emough Degen Token");
        return transfer(to, _amount);
    }

    function redeemToken(uint256 item) external {
        require(totalItem > 0, "No Item for Redeem, Contact Admin!!!");
        require(item < totalItem, "Item Not Available!!");

        uint256 price = gamestore[item].price;
        require(price <= balanceOf(msg.sender), "Error: Not Enough Degen Token");
        _transfer(msg.sender, address(this), price);
    }

    function getAllItemsFromGameStore() public view returns(GameStore[] memory){
       GameStore[] memory items = new GameStore[](totalItem);
        for (uint256 i = 1; i <= totalItem; i++) {
            items[i - 1] = gamestore[i];
        }
        return items;
    }

    function checkStoreBalance() public view returns (uint256) {
        return balanceOf(address(this));
    }

    function withdrawStoreBalance()external onlyOwner{
        _transfer(address(this), msg.sender, balanceOf(address(this)));
    }

    function getItemPrice(uint256 item) external view returns(uint256){
        return gamestore[item].price;
    }

    function burn(uint256 amount) external {
         uint256 _amount = amount * 1e18;
          require(_amount <= balanceOf(msg.sender), "Error: Not Enough Degen Token to Burn");
        _burn(msg.sender, _amount);
    }

}





To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.20" (or another compatible version), and then click on the "Compile gedenstore.sol" button.


Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "gendenstore" contract from the dropdown menu, and then click on the "Deploy" button.


Once the contract is deployed, you can interact with it by 
1.Minting new tokens: before you can mint the token you have to chnage the address to the owner then enter the adress to want to mint to 
2.Transferring tokens: you can tranfer tokens to anybody you like 
3.Redeeming tokens: you will use the token mint to you to get anything you want 
4.Checking token balance: then you can also check your balance of your token
5.Burning tokens: yiu can nurn your token also 
