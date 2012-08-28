require 'spec_helper'
require 'github'
require 'pp'

describe Github do
  let(:github_config) { File.expand_path("../../support/sample_github.yml", __FILE__) }
  let(:github) { Github::Base.new(config_file: github_config) }

  context "#initialize" do
    it "sets up the config for all the attributes it receives" do
      github.config["repo_user"].should == "ehlertij"
      github.config["repo"].should == "github"
      github.config["username"].should == "ehlertij-test"
      github.config["password"].should == "test123"
    end

    it "generates a correct base_url" do
      github.base_url.should == "https://api.github.com/repos/ehlertij/github"
    end
  end

  context "#pull_requests" do
    it "lists the pull_requests for the repo" do
      pulls = github.pull_requests.list
      pulls.count.should > 0
    end

    it "returns a single pull_request if given an id" do
      pull = github.pull_requests.get(66)
      pull["title"].should == "This is just for testing the API. Do not close or merge this pull."
    end
  end
end
