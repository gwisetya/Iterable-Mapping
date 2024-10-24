// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

import {IterableMapping} from "./IterableMapping.sol";

contract TestIterableMapping {
    using IterableMapping for IterableMapping.Map; 

    IterableMapping.Map private map;

    modifier initTest(){
        map.set(address(0), 0);
        map.set(address(1), 100);
        map.set(address(2), 200);
        map.set(address(3), 300);
        _;
    }

    function testUpdate() public initTest{
        map.set(address(2),300);
        assert(map.values[address(2)] == 300);
    }

    function testIterableMap() public initTest{
        for(uint256 i = 0; i< map.keys.length -1; i++){
            address _keys = map.keys[i];
            assert(map.values[_keys] == i*100);
        }
    }

    function testRemove() public initTest{
        map.remove(address(1));
        assert(map.getKeyAtIndexOf(0)== address(0));
        assert(map.getKeyAtIndexOf(1)== address(3));
        assert(map.getKeyAtIndexOf(2)== address(2));
        assert(map.getSize() == 3);
    }
}