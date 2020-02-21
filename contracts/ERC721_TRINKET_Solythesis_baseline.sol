pragma solidity ^0.5.0;
library Address {
function isContract (address addr) internal view returns (bool) {
uint256 size;
assembly {
size := extcodesize(addr)
}

{
return size > 0;
}

}

}
contract Ownable {
address public owner;
constructor () public {
owner = msg.sender;
}

function setOwner (address _owner) onlyOwner public {
owner = _owner;
}

function getOwner () public view returns (address) {
{
return owner;
}

}

modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
}
library SafeMath {
function mul (uint256 a, uint256 b) internal pure returns (uint256 c) {
if (a == 0) {
{
return 0;
}

}

c = a * b;
assert(c / a == b);
{
return c;
}

}

function div (uint256 a, uint256 b) internal pure returns (uint256) {
{
return a / b;
}

}

function sub (uint256 a, uint256 b) internal pure returns (uint256) {
assert(b <= a);
{
return a - b;
}

}

function add (uint256 a, uint256 b) internal pure returns (uint256 c) {
c = a + b;
assert(c >= a);
{
return c;
}

}

}
library Strings {
function strConcat (string memory _a, string memory _b, string memory _c, string memory _d, string memory _e) internal pure returns (string memory) {
bytes memory _ba = bytes(_a);
bytes memory _bb = bytes(_b);
bytes memory _bc = bytes(_c);
bytes memory _bd = bytes(_d);
bytes memory _be = bytes(_e);
string memory abcde = new string(_ba.length + _bb.length + _bc.length + _bd.length + _be.length);
bytes memory babcde = bytes(abcde);
uint k = 0;
for (uint i = 0; i < _ba.length; i ++) babcde[k ++] = _ba[i];
for (uint i = 0; i < _bb.length; i ++) babcde[k ++] = _bb[i];
for (uint i = 0; i < _bc.length; i ++) babcde[k ++] = _bc[i];
for (uint i = 0; i < _bd.length; i ++) babcde[k ++] = _bd[i];
for (uint i = 0; i < _be.length; i ++) babcde[k ++] = _be[i];
{
return string(babcde);
}

}

function strConcat (string memory _a, string memory _b, string memory _c, string memory _d) internal pure returns (string memory) {
{
return strConcat(_a, _b, _c, _d, "");
}

}

function strConcat (string memory _a, string memory _b, string memory _c) internal pure returns (string memory) {
{
return strConcat(_a, _b, _c, "", "");
}

}

function strConcat (string memory _a, string memory _b) internal pure returns (string memory) {
{
return strConcat(_a, _b, "", "", "");
}

}

function uint2str (uint _i) internal pure returns (string memory _uintAsString) {
if (_i == 0) {
{
return "0";
}

}

uint j = _i;
uint len;
while (j != 0) {
            len++;
            j /= 10;
        }
bytes memory bstr = new bytes(len);
uint k = len - 1;
while (_i != 0) {
            bstr[k--] = byte(uint8(48 + _i % 10));
            _i /= 10;
        }
{
return string(bstr);
}

}

}
interface IERC165 {
function supportsInterface (bytes4 _interfaceId) external view returns (bool);
}
contract IERC721Receiver {
bytes4 internal constant ERC721_RECEIVED = 0x150b7a02;
function onERC721Received (
        address _operator,
        address _from,
        uint256 _tokenId,
        bytes memory _data
    ) public returns(bytes4);
}
contract IERC721Holder is IERC721Receiver {
function onERC721Received (address, address, uint256, bytes memory) public returns(bytes4) {
{
return ERC721_RECEIVED;
}

}

}
contract IERC721 is IERC165 {
event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
uint256[] internal _allTokens;
function balanceOf (address owner) public view returns (uint256 balance);
function ownerOf (uint256 tokenId) public view returns (address owner);
function approve (address to, uint256 tokenId) public;
function getApproved (uint256 tokenId) public view returns (address operator);
function setApprovalForAll (address operator, bool _approved) public;
function isApprovedForAll (address owner, address operator) public view returns (bool);
function transferFrom (address from, address to, uint256 tokenId) public;
function safeTransferFrom (address from, address to, uint256 tokenId) public;
function safeTransferFrom (address from, address to, uint256 tokenId, bytes memory data) public;
}
contract IERC721Enumerable is IERC721 {
function totalSupply () public view returns (uint256);
function tokenOfOwnerByIndex (
        address _owner,
        uint256 _index
    ) public view returns (uint256 _tokenId);
function tokenByIndex (uint256 _index) public view returns (uint256);
}
contract IERC721Metadata is IERC721 {
function name () external view returns (string memory _name);
function symbol () external view returns (string memory _symbol);
function tokenURI (uint256 _tokenId) public view returns (string memory);
}
contract SupportsInterfaceWithLookup is IERC165 {
bytes4 public constant InterfaceId_ERC165 = 0x01ffc9a7;
mapping (bytes4=>bool) internal supportedInterfaces;
constructor () public {
_registerInterface(InterfaceId_ERC165);
}

function supportsInterface (bytes4 _interfaceId) external view returns (bool) {
{
return supportedInterfaces[_interfaceId];
}

}

function _registerInterface (bytes4 _interfaceId) internal {
require(_interfaceId != 0xffffffff);
supportedInterfaces[_interfaceId] = true;
}

}
contract Delegate {
function mint (address _sender, address _to) public returns (bool);
function approve (address _sender, address _to, uint256 _tokenId) public returns (bool);
function setApprovalForAll (address _sender, address _operator, bool _approved) public returns (bool);
function transferFrom (address _sender, address _from, address _to, uint256 _tokenId) public returns (bool);
function safeTransferFrom (address _sender, address _from, address _to, uint256 _tokenId) public returns (bool);
function safeTransferFrom (address _sender, address _from, address _to, uint256 _tokenId, bytes memory _data) public returns (bool);
}
contract ERC165 is IERC165 {
bytes4 private constant _InterfaceId_ERC165 = 0x01ffc9a7;
mapping (bytes4=>bool) private _supportedInterfaces;
constructor () internal {
_registerInterface(_InterfaceId_ERC165);
}

function supportsInterface (bytes4 interfaceId) external view returns (bool) {
{
return _supportedInterfaces[interfaceId];
}

}

function _registerInterface (bytes4 interfaceId) internal {
require(interfaceId != 0xffffffff);
_supportedInterfaces[interfaceId] = true;
}

}
contract ERC721 is ERC165, IERC721 {
uint256 depth_0;
mapping (address=>bool) a_checker_3;
address[] a_store_4;
uint256 sum_tokenCount;
mapping (uint256=>bool) a_checker_7;
uint256[] a_store_8;
mapping (address=>bool) b_checker_5;
address[] b_store_6;
mapping (address=>uint256) sum_ownersToken;
mapping (address=>bool) a_checker_9;
address[] a_store_10;
using SafeMath for uint256;
using Address for address;
bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;
mapping (uint256=>address) internal _tokenOwner;
mapping (uint256=>address) internal _tokenApprovals;
mapping (address=>uint256) internal _ownedTokensCount;
mapping (address=>mapping (address=>bool)) private _operatorApprovals;
bytes4 private constant _InterfaceId_ERC721 = 0x80ac58cd;
constructor () public {
_registerInterface(_InterfaceId_ERC721);
}

function balanceOf (address owner) public view returns (uint256) {
require(owner != address(0));
{
return _ownedTokensCount[owner];
}

}

function ownerOf (uint256 tokenId) public view returns (address) {
address owner = _tokenOwner[tokenId];
require(owner != address(0));
{
return owner;
}

}

function approve (address to, uint256 tokenId) public {
address owner = ownerOf(tokenId);
require(to != owner);
require(msg.sender == owner || isApprovedForAll(owner, msg.sender));
_tokenApprovals[tokenId] = to;
emit Approval(owner, to, tokenId);
}

function getApproved (uint256 tokenId) public view returns (address) {
require(_exists(tokenId));
{
return _tokenApprovals[tokenId];
}

}

function setApprovalForAll (address to, bool approved) public {
require(to != msg.sender);
_operatorApprovals[msg.sender][to] = approved;
emit ApprovalForAll(msg.sender, to, approved);
}

function isApprovedForAll (
        address owner,
        address operator
    ) public view returns (bool) {
{
return _operatorApprovals[owner][operator];
}

}

function transferFrom (
        address from,
        address to,
        uint256 tokenId
    ) public {
depth_0 += 1;
require(_isApprovedOrOwner(msg.sender, tokenId));
require(to != address(0));
_clearApproval(from, tokenId);
_removeTokenFrom(from, tokenId);
_addTokenTo(to, tokenId);
emit Transfer(from, to, tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_2 = 0; index_2 < a_store_4.length; index_2 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_2]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_2]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_3 = 0; index_3 < b_store_6.length; index_3 += 1) {
sum_ownersToken[b_store_6[index_3]] = 0;
}

for (uint256 index_4 = 0; index_4 < a_store_8.length; index_4 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_4]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_4]]] >= 1);
}

}

for (uint256 index_7 = 0; index_7 < a_store_10.length; index_7 += 1) {
assert(_ownedTokensCount[a_store_10[index_7]] == sum_ownersToken[a_store_10[index_7]]);
}

}

}

function safeTransferFrom (
        address from,
        address to,
        uint256 tokenId
    ) public {
depth_0 += 1;
safeTransferFrom(from, to, tokenId, "");
depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_8 = 0; index_8 < a_store_4.length; index_8 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_8]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_8]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_9 = 0; index_9 < b_store_6.length; index_9 += 1) {
sum_ownersToken[b_store_6[index_9]] = 0;
}

for (uint256 index_10 = 0; index_10 < a_store_8.length; index_10 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_10]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_10]]] >= 1);
}

}

for (uint256 index_13 = 0; index_13 < a_store_10.length; index_13 += 1) {
assert(_ownedTokensCount[a_store_10[index_13]] == sum_ownersToken[a_store_10[index_13]]);
}

}

}

function safeTransferFrom (
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) public {
depth_0 += 1;
transferFrom(from, to, tokenId);
require(_checkAndCallSafeTransfer(from, to, tokenId, _data));
depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_14 = 0; index_14 < a_store_4.length; index_14 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_14]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_14]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_15 = 0; index_15 < b_store_6.length; index_15 += 1) {
sum_ownersToken[b_store_6[index_15]] = 0;
}

for (uint256 index_16 = 0; index_16 < a_store_8.length; index_16 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_16]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_16]]] >= 1);
}

}

for (uint256 index_19 = 0; index_19 < a_store_10.length; index_19 += 1) {
assert(_ownedTokensCount[a_store_10[index_19]] == sum_ownersToken[a_store_10[index_19]]);
}

}

}

function _exists (uint256 tokenId) internal view returns (bool) {
address owner = _tokenOwner[tokenId];
{
return owner != address(0);
}

}

function _isApprovedOrOwner (
        address spender,
        uint256 tokenId
    ) internal view returns (bool) {
address owner = ownerOf(tokenId);
{
return (
        spender == owner ||
        getApproved(tokenId) == spender ||
        isApprovedForAll(owner, spender)
        );
}

}

function _mint (address to, uint256 tokenId) internal {
require(to != address(0));
_addTokenTo(to, tokenId);
emit Transfer(address(0), to, tokenId);
}

function _burn (address owner, uint256 tokenId) internal {
_clearApproval(owner, tokenId);
_removeTokenFrom(owner, tokenId);
emit Transfer(owner, address(0), tokenId);
}

function _clearApproval (address owner, uint256 tokenId) internal {
require(ownerOf(tokenId) == owner);
if (_tokenApprovals[tokenId] != address(0)) {
_tokenApprovals[tokenId] = address(0);
}

}

function _addTokenTo (address to, uint256 tokenId) internal {
require(_tokenOwner[tokenId] == address(0));
_tokenOwner[tokenId] = to;if (! a_checker_7[tokenId]) {
a_store_8.push(tokenId);
a_checker_7[tokenId] = true;
}
if (! b_checker_5[_tokenOwner[tokenId]]) {
b_store_6.push(_tokenOwner[tokenId]);
b_checker_5[_tokenOwner[tokenId]] = true;
}

_ownedTokensCount[to] = _ownedTokensCount[to].add(1);if (! a_checker_3[to]) {
a_store_4.push(to);
a_checker_3[to] = true;
}
if (! a_checker_9[to]) {
a_store_10.push(to);
a_checker_9[to] = true;
}

}

function _removeTokenFrom (address from, uint256 tokenId) internal {
require(ownerOf(tokenId) == from);
_ownedTokensCount[from] = _ownedTokensCount[from].sub(1);if (! a_checker_3[from]) {
a_store_4.push(from);
a_checker_3[from] = true;
}
if (! a_checker_9[from]) {
a_store_10.push(from);
a_checker_9[from] = true;
}

_tokenOwner[tokenId] = address(0);if (! a_checker_7[tokenId]) {
a_store_8.push(tokenId);
a_checker_7[tokenId] = true;
}
if (! b_checker_5[_tokenOwner[tokenId]]) {
b_store_6.push(_tokenOwner[tokenId]);
b_checker_5[_tokenOwner[tokenId]] = true;
}

}

function _checkAndCallSafeTransfer (
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) internal returns (bool) {
if (! to.isContract()) {
{
return true;
}

}

bytes4 retval = IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, _data);
{
return (retval == _ERC721_RECEIVED);
}

}

}
contract ERC721Enumerable is ERC165, ERC721, IERC721Enumerable {
mapping (address=>uint256[]) private _ownedTokens;
mapping (uint256=>uint256) private _ownedTokensIndex;
mapping (uint256=>uint256) private _allTokensIndex;
bytes4 private constant _InterfaceId_ERC721Enumerable = 0x780e9d63;
constructor () public {
_registerInterface(_InterfaceId_ERC721Enumerable);
}

function tokenOfOwnerByIndex (
        address owner,
        uint256 index
    ) public view returns (uint256) {
require(index < balanceOf(owner));
{
return _ownedTokens[owner][index];
}

}

function totalSupply () public view returns (uint256) {
{
return _allTokens.length;
}

}

function tokenByIndex (uint256 index) public view returns (uint256) {
require(index < totalSupply());
{
return _allTokens[index];
}

}

function _addTokenTo (address to, uint256 tokenId) internal {
super._addTokenTo(to, tokenId);
uint256 length = _ownedTokens[to].length;
_ownedTokens[to].push(tokenId);
_ownedTokensIndex[tokenId] = length;
}

function _removeTokenFrom (address from, uint256 tokenId) internal {
super._removeTokenFrom(from, tokenId);
uint256 tokenIndex = _ownedTokensIndex[tokenId];
uint256 lastTokenIndex = _ownedTokens[from].length.sub(1);
uint256 lastToken = _ownedTokens[from][lastTokenIndex];
_ownedTokens[from][tokenIndex] = lastToken;
_ownedTokens[from].length --;
_ownedTokensIndex[tokenId] = 0;
_ownedTokensIndex[lastToken] = tokenIndex;
}

function _mint (address to, uint256 tokenId) internal {
super._mint(to, tokenId);
_allTokensIndex[tokenId] = _allTokens.length;
_allTokens.push(tokenId);
}

function _burn (address owner, uint256 tokenId) internal {
super._burn(owner, tokenId);
uint256 tokenIndex = _allTokensIndex[tokenId];
uint256 lastTokenIndex = _allTokens.length.sub(1);
uint256 lastToken = _allTokens[lastTokenIndex];
_allTokens[tokenIndex] = lastToken;
_allTokens[lastTokenIndex] = 0;
_allTokens.length --;
_allTokensIndex[tokenId] = 0;
_allTokensIndex[lastToken] = tokenIndex;
}

}
contract ERC721Metadata is ERC165, ERC721, IERC721Metadata {
string internal _name;
string internal _symbol;
mapping (uint256=>string) private _tokenURIs;
bytes4 private constant InterfaceId_ERC721Metadata = 0x5b5e139f;
constructor (string memory name, string memory symbol) public {
_name = name;
_symbol = symbol;
_registerInterface(InterfaceId_ERC721Metadata);
}

function name () external view returns (string memory) {
{
return _name;
}

}

function symbol () external view returns (string memory) {
{
return _symbol;
}

}

function tokenURI (uint256 tokenId) public view returns (string memory) {
require(_exists(tokenId));
{
return _tokenURIs[tokenId];
}

}

function _setTokenURI (uint256 tokenId, string memory uri) internal {
require(_exists(tokenId));
_tokenURIs[tokenId] = uri;
}

function _burn (address owner, uint256 tokenId) internal {
super._burn(owner, tokenId);
if (bytes(_tokenURIs[tokenId]).length != 0) {
delete _tokenURIs[tokenId];
}

}

}
contract ERC721Full is ERC721, ERC721Enumerable, ERC721Metadata {
constructor (string memory name, string memory symbol) ERC721Metadata(name, symbol) public {
}

}
contract Collectables is ERC721Full("GU Collectable", "TRINKET"), Ownable {
using Strings for string;
mapping (uint32=>address) public delegates;
uint32[] public collectables;
uint public delegateCount;
constructor () public {
}

event DelegateAdded(address indexed delegate, uint32 indexed delegateID);
function addDelegate (address delegate) onlyOwner public {
uint32 delegateID = uint32(delegateCount ++);
require(delegates[delegateID] == address(0), "delegate is already set for collectable type");
delegates[delegateID] = delegate;
emit DelegateAdded(delegate, delegateID);
}

function mint_d (uint32 delegateID, address to) public returns (uint) {
depth_0 += 1;
Delegate delegate = getDelegate(delegateID);
require(delegate.mint(msg.sender, to), "delegate could not mint token");
uint id = collectables.push(delegateID) - 1;
super._mint(to, id);
{
depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_20 = 0; index_20 < a_store_4.length; index_20 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_20]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_20]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_21 = 0; index_21 < b_store_6.length; index_21 += 1) {
sum_ownersToken[b_store_6[index_21]] = 0;
}

for (uint256 index_22 = 0; index_22 < a_store_8.length; index_22 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_22]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_22]]] >= 1);
}

}

for (uint256 index_26 = 0; index_26 < a_store_10.length; index_26 += 1) {
assert(_ownedTokensCount[a_store_10[index_26]] == sum_ownersToken[a_store_10[index_26]]);
}

}

return id;
}

depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_27 = 0; index_27 < a_store_4.length; index_27 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_27]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_27]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_28 = 0; index_28 < b_store_6.length; index_28 += 1) {
sum_ownersToken[b_store_6[index_28]] = 0;
}

for (uint256 index_29 = 0; index_29 < a_store_8.length; index_29 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_29]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_29]]] >= 1);
}

}

for (uint256 index_31 = 0; index_31 < a_store_10.length; index_31 += 1) {
assert(_ownedTokensCount[a_store_10[index_31]] == sum_ownersToken[a_store_10[index_31]]);
}

}

}

function mint (address to, uint256 id) public returns (uint) {
depth_0 += 1;
super._mint(to, id);
{
depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_32 = 0; index_32 < a_store_4.length; index_32 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_32]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_32]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_33 = 0; index_33 < b_store_6.length; index_33 += 1) {
sum_ownersToken[b_store_6[index_33]] = 0;
}

for (uint256 index_34 = 0; index_34 < a_store_8.length; index_34 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_34]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_34]]] >= 1);
}

}

for (uint256 index_38 = 0; index_38 < a_store_10.length; index_38 += 1) {
assert(_ownedTokensCount[a_store_10[index_38]] == sum_ownersToken[a_store_10[index_38]]);
}

}

return id;
}

depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_39 = 0; index_39 < a_store_4.length; index_39 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_39]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_39]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_40 = 0; index_40 < b_store_6.length; index_40 += 1) {
sum_ownersToken[b_store_6[index_40]] = 0;
}

for (uint256 index_41 = 0; index_41 < a_store_8.length; index_41 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_41]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_41]]] >= 1);
}

}

for (uint256 index_43 = 0; index_43 < a_store_10.length; index_43 += 1) {
assert(_ownedTokensCount[a_store_10[index_43]] == sum_ownersToken[a_store_10[index_43]]);
}

}

}

function transferFrom (address from, address to, uint256 tokenId) public {
depth_0 += 1;
super.transferFrom(from, to, tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_44 = 0; index_44 < a_store_4.length; index_44 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_44]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_44]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_45 = 0; index_45 < b_store_6.length; index_45 += 1) {
sum_ownersToken[b_store_6[index_45]] = 0;
}

for (uint256 index_46 = 0; index_46 < a_store_8.length; index_46 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_46]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_46]]] >= 1);
}

}

for (uint256 index_49 = 0; index_49 < a_store_10.length; index_49 += 1) {
assert(_ownedTokensCount[a_store_10[index_49]] == sum_ownersToken[a_store_10[index_49]]);
}

}

}

function approve (address to, uint256 tokenId) public {
Delegate delegate = getTokenDelegate(tokenId);
require(delegate.approve(msg.sender, to, tokenId), "could not approve token");
super.approve(to, tokenId);
}

function safeTransferFrom (address from, address to, uint256 tokenId, bytes memory data) public {
depth_0 += 1;
Delegate delegate = getTokenDelegate(tokenId);
require(delegate.safeTransferFrom(msg.sender, from, to, tokenId, data), "could not safe transfer token");
super.safeTransferFrom(from, to, tokenId, data);
depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_50 = 0; index_50 < a_store_4.length; index_50 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_50]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_50]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_51 = 0; index_51 < b_store_6.length; index_51 += 1) {
sum_ownersToken[b_store_6[index_51]] = 0;
}

for (uint256 index_52 = 0; index_52 < a_store_8.length; index_52 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_52]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_52]]] >= 1);
}

}

for (uint256 index_56 = 0; index_56 < a_store_10.length; index_56 += 1) {
assert(_ownedTokensCount[a_store_10[index_56]] == sum_ownersToken[a_store_10[index_56]]);
}

}

}

function safeTransferFrom (address from, address to, uint256 tokenId) public {
depth_0 += 1;
Delegate delegate = getTokenDelegate(tokenId);
require(delegate.safeTransferFrom(msg.sender, from, to, tokenId), "could not safe transfer token");
super.safeTransferFrom(from, to, tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_57 = 0; index_57 < a_store_4.length; index_57 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_57]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_57]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_58 = 0; index_58 < b_store_6.length; index_58 += 1) {
sum_ownersToken[b_store_6[index_58]] = 0;
}

for (uint256 index_59 = 0; index_59 < a_store_8.length; index_59 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_59]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_59]]] >= 1);
}

}

for (uint256 index_63 = 0; index_63 < a_store_10.length; index_63 += 1) {
assert(_ownedTokensCount[a_store_10[index_63]] == sum_ownersToken[a_store_10[index_63]]);
}

}

}

function getTokenDelegate (uint id) public view returns (Delegate) {
address d = delegates[collectables[id]];
require(d != address(0), "invalid delegate");
{
return Delegate(d);
}

}

function getDelegate (uint32 id) public view returns (Delegate) {
address d = delegates[id];
require(d != address(0), "invalid delegate");
{
return Delegate(d);
}

}

string public constant tokenMetadataBaseURI = "https://api.godsunchained.com/collectable/";
function tokenURI (uint256 _tokenId) public view returns (string memory) {
require(_exists(_tokenId), "token doesn't exist");
{
return Strings.strConcat(
            tokenMetadataBaseURI,
            Strings.uint2str(_tokenId)
        );
}

}

}
