require 'spec_helper'
require "logstash/plugin"
require "logstash/json"

describe LogStash::Outputs::ArangoDB do

  context "registration" do

    let(:output) { LogStash::Plugin.lookup("output", "arangodb").new() }

    it "should register" do
      expect { output.register }.to_not raise_error
    end

    it "should teardown" do
      output.register
      expect { output.teardown }.to_not raise_error
    end
  end

end
