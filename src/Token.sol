// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20TemporaryApproval.sol";

contract MyToken is ERC20, ERC20TemporaryApproval {
    constructor() ERC20("MyToken", "MTK") ERC20TemporaryApproval() {}

    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }

    // Override functions to fix inheritance conflicts
    function allowance(
        address owner,
        address spender
    )
        public
        view
        virtual
        override(ERC20, ERC20TemporaryApproval)
        returns (uint256)
    {
        return ERC20TemporaryApproval.allowance(owner, spender);
    }

    function _spendAllowance(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual override(ERC20, ERC20TemporaryApproval) {
        ERC20TemporaryApproval._spendAllowance(owner, spender, amount);
    }
}
