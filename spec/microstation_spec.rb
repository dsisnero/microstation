#require File.join(File.dirname(__FILE__) ,  'spec_helper')
require 'spec_helper.rb'


describe Microstation do

  context "#root" do

    subject { Microstation.root}

    it { should be_instance_of Pathname}
    it "to_s" do
      subject.to_s.should == Pathname.getwd.to_s
    end

  end


  describe "#run" do
    it "opens up and yields an app" do
      Microstation.run do |app|
        app.class.should == Microstation::App
      end
    end

    it "can be called with implicit receiver" do
      Microstation.run do
        self.class.should == Microstation::App
      end
    end

  end

end


