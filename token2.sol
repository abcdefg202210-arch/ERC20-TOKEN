// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//可增发 + 可销毁 + 管理员权限（实用业务版）

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// 带管理员权限、可增发/销毁的ERC20
contract ManageableERC20 is ERC20, Ownable {
    // 构造函数
    constructor() ERC20("ManageableToken", "MGT") Ownable(msg.sender) {
        // 初始发行 1000万代币
        _mint(msg.sender, 10_000_000 * 10 ** decimals());
    }


    // 只有管理员可以增发代币
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    // 任何人都可以销毁自己的代币
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    // 管理员可以销毁指定用户的代币（合规场景使用）
    function burnFrom(address account, uint256 amount) external onlyOwner {
        _burn(account, amount);
    }
}
