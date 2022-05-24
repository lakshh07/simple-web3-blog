const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Blog", function () {
  it("Should create a post", async function () {
    const Blog = await ethers.getContractFactory("Blog");
    const blog = await Blog.deploy("My Blog");
    await blog.deployed();
    await blog.createPost("My first post", "12345");

    const posts = await blog.fetchPosts();
    expect(posts[0].title).to.equal("My first post");
  });
  it("Should edit a post", async function () {
    const Blog = await ethers.getContractFactory("Blog");
    const blog = await Blog.deploy("My Blog");
    await blog.deployed();
    await blog.createPost("My second post", "12345");

    await blog.updatePost(1, "My updated post", "56789", true);

    const posts = await blog.fetchPosts();
    expect(posts[0].title).to.equal("My updated post");
  });
  it("Should add update the name", async function () {
    const Blog = await ethers.getContractFactory("Blog");
    const blog = await Blog.deploy("My Blog");
    await blog.deployed();

    expect(await blog.name()).to.equal("My Blog");
    await blog.updateName("My New Blog");
    expect(await blog.name()).to.equal("My New Blog");
  });
});
