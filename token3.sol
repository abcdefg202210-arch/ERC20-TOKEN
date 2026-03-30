// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//税收 + 通缩型代币（营销 / 生态专用版）
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// 自动税收+通缩 ERC20 代币
contract TaxDeflationERC20 is ERC20, Ownable {
    // 税收比例：2% (2/100)
    uint256 public constant TAX_RATE = 2;
    // 国库地址（接收税收）
    address public treasury;

    constructor(address _treasury) ERC20("DeflationToken", "DFT") Ownable(msg.sender) {
        treasury = _treasury;
        _mint(msg.sender, 1_000_000_000 * 10 ** decimals()); // 10亿总量
    }

    // 重写转账函数，实现自动扣税
    function transfer(address to, uint256 value) public override returns (bool) {
        address sender = _msgSender();
        uint256 tax = (value * TAX_RATE) / 100; // 计算税金
        uint256 sendAmount = value - tax;

        // 1% 销毁，1% 进入国库
        uint256 burnAmount = tax / 2;
        uint256 treasuryAmount = tax - burnAmount;

        _transfer(sender, to, sendAmount);
        _burn(sender, burnAmount);
        _transfer(sender, treasury, treasuryAmount);

        return true;
    }

    // 修改国库地址
    function setTreasury(address _treasury) external onlyOwner {
        treasury = _treasury;
    }
}
