// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

library IterableMapping{
    struct Map{
        address[] keys;
        mapping(address => uint256) values; 
        mapping(address => uint256) indexOf; 
        mapping(address => bool) inserted; 
    }

    function getValue(Map storage map, address _key) public view returns(uint256){
        return map.values[_key]; 
    }

    function getKeyAtIndexOf(Map storage map, uint256 _index) public view returns(address){
        return map.keys[_index]; 
    }

    function getSize(Map storage map) public view returns(uint256){
        return map.keys.length;
    }

    function set(Map storage map, address _key, uint256 _value) public{
        if(map.inserted[_key]){
            map.values[_key] = _value; 
        }
        else{
            map.inserted[_key] = true; 
            map.values[_key] = _value; 
            map.keys.push(_key);
            map.indexOf[_key] = map.keys.length - 1;
        }
    }

    function remove(Map storage map, address _key) public {
        require(map.inserted[_key]); 

        delete map.inserted[_key];
        delete map.values[_key];

        uint256 index = map.indexOf[_key];
        address lastKey = map.keys[map.keys.length - 1];

        map.indexOf[lastKey] = index;
        delete map.indexOf[_key];

        map.keys[index] = lastKey;
        map.keys.pop();
    }  
}