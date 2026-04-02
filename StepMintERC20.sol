// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract StepMintERC20 is ERC20 {
    uint256 public step = 1000 ether;
    uint256 public currentRound;

    constructor() ERC20("StepMint", "STEP") {}

    function mintNextRound() external {
        currentRound++;
        _mint(msg.sender, step * currentRound);
    }
}
