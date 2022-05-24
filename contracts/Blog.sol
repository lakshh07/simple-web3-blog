//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Blog {
    string public name;
    address public owner;

    using Counters for Counters.Counter;
    Counters.Counter private _postIds;

    struct Post {
        uint256 id;
        string title;
        string content;
        bool published;
    }

    mapping(uint256 => Post) private idToPost;
    mapping(string => Post) private hashToPost;

    event PostCreated(uint256 id, string title, string hash);
    event PostUpdated(uint256 id, string title, string hash, bool published);

    constructor(string memory _name) {
        console.log("Deploying Blog with name: ", _name);
        name = _name;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function updateName(string memory _name) public {
        name = _name;
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }

    function fetchPost(string memory _hash) public view returns (Post memory) {
        return hashToPost[_hash];
    }

    function createPost(string memory _title, string memory _hash)
        public
        onlyOwner
    {
        _postIds.increment();
        uint256 postId = _postIds.current();
        Post storage post = idToPost[postId];
        post.id = postId;
        post.title = _title;
        post.published = true;
        post.content = _hash;
        hashToPost[_hash] = post;

        emit PostCreated(postId, _title, _hash);
    }

    function updatePost(
        uint256 _postId,
        string memory _title,
        string memory _hash,
        bool _published
    ) public onlyOwner {
        Post storage post = idToPost[_postId];
        post.title = _title;
        post.content = _hash;
        post.published = _published;
        idToPost[_postId] = post;
        hashToPost[_hash] = post;

        emit PostUpdated(post.id, _title, _hash, _published);
    }

    function fetchPosts() public view returns (Post[] memory) {
        uint256 itemCount = _postIds.current();

        Post[] memory posts = new Post[](itemCount);
        for (uint256 i = 0; i < itemCount; i++) {
            uint256 currentId = i + 1;
            Post storage currentItem = idToPost[currentId];
            posts[i] = currentItem;
        }
        return posts;
    }
}
