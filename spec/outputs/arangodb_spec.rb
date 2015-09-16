require_relative '../spec_helper'
require "logstash/plugin"
require "logstash/json"

describe LogStash::Outputs::ArangoDB do

  let(:config) do
    { "username" => "logstash", "password" => "logstash" }
  end

  describe "registration" do

    let(:output) { LogStash::Plugin.lookup("output", "arangodb").new(config) }

    it "should register" do
      expect { output.register }.to_not raise_error
    end

    it "should teardown" do
      output.register
      expect { output.teardown }.to_not raise_error
    end
  end

  describe "#save" do

    subject     { LogStash::Outputs::ArangoDB.new(config) }
    let(:event) { LogStash::Event.new({"message" => "dummy"}) }

    before(:each) do
      subject.register
    end


    it "should buffer the event to be flushed" do
      expect(subject).to receive(:buffer_receive)
      subject.receive(event)
    end

  end

end
