require 'spec_helper'

describe Github do
  it "has a VERSION" do
    Github::VERSION.should_not be_nil
  end
end
