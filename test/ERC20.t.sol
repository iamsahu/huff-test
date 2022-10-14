// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "yield-utils-v2/token/IERC20Metadata.sol";

interface IERC20M is IERC20Metadata {
    function mint(address, uint256) external;
}

contract ERC20Test is Test {
    /// @dev Address of the SimpleStore contract.
    IERC20M public erc20;

    address constant dummyAddress =
        address(0x65cD9a349aE1A934C0Bb2c8fa78c978F8d6D2a8e);
    address constant dummyAddress2 =
        address(0x373ffDeE1c2edCB1d06332E1dbbf5D639adf50C6);

    /// @dev Setup the testing environment.
    function setUp() public {
        address simpleERC20 = HuffDeployer
            .config()
            .with_args(abi.encode(uint8(18)))
            .deploy("SimpleERC20");
        erc20 = IERC20M(simpleERC20);
    }

    function testDecimals() public {
        assertEq(erc20.decimals(), uint8(18));
    }

    // function testSymbol() public {
    //     erc20.symbol();
    // }

    function testTotalSupply() public {
        erc20.totalSupply();
    }

    function testBalanceOf() public {
        erc20.balanceOf(address(this));
    }

    function testMint() public {
        erc20.mint(address(this), uint256(1e18));
        assertEq(erc20.totalSupply(), uint256(1e18));
        assertEq(erc20.balanceOf(address(this)), uint256(1e18));
    }

    function testTransfer() public {
        erc20.mint(address(this), uint256(1e18));
        assertEq(erc20.totalSupply(), uint256(1e18));
        assertEq(erc20.balanceOf(address(this)), uint256(1e18));
        erc20.transfer(dummyAddress, uint256(100));
        assertEq(erc20.balanceOf(dummyAddress), uint256(100));
        assertEq(erc20.balanceOf(address(this)), uint256(1e18) - uint256(100));
    }

    function testAllowance() public {
        assertEq(erc20.allowance(address(this), dummyAddress), 0);
        erc20.approve(dummyAddress, uint256(1));
        assertEq(erc20.allowance(address(this), dummyAddress), 1);
    }

    function testTransferFrom() public {
        erc20.mint(dummyAddress, uint256(1e18));
        vm.prank(dummyAddress);
        erc20.approve(address(this), uint256(1000));
        erc20.transferFrom(dummyAddress, dummyAddress2, uint256(100));
        assertEq(erc20.balanceOf(dummyAddress), uint256(1e18) - uint256(100));
        assertEq(erc20.balanceOf(dummyAddress2), uint256(100));
        assertEq(
            erc20.allowance(dummyAddress, address(this)),
            uint256(1000) - uint256(100)
        );
    }
}
