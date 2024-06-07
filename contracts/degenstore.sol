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

    mapping(address => mapping (uint256 => uint256)) itemsOwned;


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
        itemsOwned[msg.sender][item]+=1;
        
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

    function getItemsOwned(uint256 item) external view returns (uint256) {
       return itemsOwned[msg.sender][item]; 

    }

}