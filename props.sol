pragma solidity ^0.4.21;

import "./erc722.sol";

contract Props is ERC722 {

    address owner;
    uint256 propsIndex;
    mapping(uint256 => uint256) propsQuota;
    mapping(uint256 => string) propsSymbol;

    mapping(address => mapping(uint256 => uint256)) balances;
    mapping(address => mapping(address => mapping(uint256 => uint256))) approved;


    constructor() public {
        owner = msg.sender;
        propsIndex = 0;
    }

    function totalSpecies() public view returns(uint256 _supply) {
        return propsIndex;
    }

    function totalSupplyOf(uint256 _species) public view returns(uint256 _supply) {
        return propsQuota[_species];
    }

    function createSpecies(uint256 _quota,string _symbol, address _owner) public returns(bool _ok) {
        require(msg.sender == owner);
        if (_owner == address(0)) {
            _owner = msg.sender;
        }
        propsIndex++;
        propsQuota[propsIndex] = _quota;
        propsSymbol[propsIndex] = _symbol;
        balances[_owner][propsIndex] = _quota;

        emit NewSpecies(propsIndex, _quota, _symbol, _owner);
        return true;
    }

    function transfer(address _to, uint256 _species, uint256 _value) public returns(bool _ok) {
        _transfer(msg.sender, _to, _species, _value);
        return true;
    }

    function balanceOf(address _who, uint256 _species) public view returns(uint256 _value) {
        if (_who == address(0)) {
            _who = msg.sender;
        }
        return balances[_who][_species];
    }

    function approve(address _spender, uint256 _species, uint256 _value) public returns(bool _ok) {
        approved[msg.sender][_spender][_species] = _value;
        emit Approval(msg.sender, _spender, _species, _value);
        return true;
    }

    function allowance(address _owner, address _spender, uint256 _species) public view returns(uint256 _allowance) {
        return approved[_owner][_spender][_species];
    }

    function transferFrom(address _from, address _to, uint256 _species, uint256 _value) public returns(bool _ok) {
        uint256 allow = approved[_from][msg.sender][_species];
        require(balances[_from][_species] >= _value && allow >= _value);
        approved[_from][msg.sender][_species] -= _value;
        _transfer(_from, _to, _species, _value);
        return true;
    }

    function _transfer(address _from, address _to, uint256 _species, uint256 _value) internal {
        require(_from != _to);
        require(balances[_from][_species] >= _value);
        uint256 newVal = balances[_to][_species] + _value;
        require (newVal >= balances[_to][_species] && newVal >= _value);
        
        balances[_from][_species] = balances[_from][_species] - _value;
        balances[_to][_species] = newVal;
        emit Transfer(_from, _to, _species, _value);
    }

    function speciesSymbol(uint256 _species)  public view returns(string _symbol){
        return propsSymbol[_species];
    }
}