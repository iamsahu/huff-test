// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract SimpleStoreTest is Test {
    /// @dev Address of the SimpleStore contract.
    SimpleStore public simpleStore;

    /// @dev Setup the testing environment.
    function setUp() public {
        simpleStore = SimpleStore(HuffDeployer.deploy("SimpleStore"));
    }

    /// @dev Ensure that you can set and get the value.
    function testSetAndGetValue(uint256 value) public {
        simpleStore.setValue(value);
        console.log(value);
        console.log(simpleStore.getValue());
        assertEq(value, simpleStore.getValue());
    }

    function testSumHuff() public {
        assertEq(3, simpleStore.getSum(1, 2));
    }

    function testSumSolidity() public {
        assertEq(3, sum(1,2));
    }

    function sum(uint256 a,uint256 b) internal returns(uint256){
        return a+b;
    }
}

interface SimpleStore {
    function setValue(uint256) external;

    function getValue() external returns (uint256);

    function getSum(uint256, uint256) external returns (uint256);
}
