// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//基础标准 ERC20 代币（最简发行版）

// 导入官方标准ERC20合约
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


// 最简标准ERC20代币
contract BasicERC20 is ERC20 {
    // 构造函数：代币名称、代币符号
    constructor() ERC20("MyBasicToken", "MBT") {
        // 一次性铸造 1亿 代币给部署者（18位小数，标准配置）
        _mint(msg.sender, 100_000_000 * 10 ** decimals());
    }
}
