pragma solidity ^0.4.11;

/**
 * The ERC722 contract
 */
contract ERC722 {
    // return total species
    function totalSpecies() public view returns(uint256 _supply);

    function allowance(address _owner, address _spender, uint256 _species) public view returns(uint _allowance);

    // query quota of certain species
    function totalSupplyOf(uint256 _species) public view returns(uint256 _supply);
    // user balance of certain species
    function balanceOf(address _who, uint256 _species) public view returns(uint256 _value);
    // transfer certain species to another
    function transfer(address _to, uint256 _species, uint256 _value) public returns(bool _ok);

    function transferFrom(address _from, address _to, uint256 _species, uint _value) public returns(bool _ok);

    function approve(address _spender, uint256 _species, uint256 _value) public returns(bool _ok);
    
    // create new species with its total quota
    function createSpecies(uint256 _quota, address _owner) public returns(bool _ok);

    event Transfer(address indexed from, address indexed to, uint256 species, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 species, uint256 value);
    event NewSpecies(uint256 _speices, uint256 _supply, address _owner);

    // Optinal
    //function name()  public returns(string _name);
    //// Optinal
    //function symbol()  public returns(string _symbol);
    //// Optinal
    //function speciesName()  public returns(string _name);
    //// Optinal
    //function speciesSymbol()  public returns(string _symbol); 
}
