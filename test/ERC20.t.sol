// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "yield-utils-v2/token/IERC20Metadata.sol";

contract ERC20Test is Test {
    /// @dev Address of the SimpleStore contract.
    IERC20Metadata public erc20;

    /// @dev Setup the testing environment.
    function setUp() public {
        address simpleERC20 = HuffDeployer.config().with_args(abi.encode(uint8(0x12))).deploy("SimpleERC20");
        erc20 = IERC20Metadata(simpleERC20);
    }

    function testDecimals() public {
        assertEq(erc20.decimals(),uint8(0x12));
    }

    // function testSymbol() public {
    //     erc20.symbol();
    // }

    function testTotalSupply() public {
        erc20.totalSupply();
    }
}
