require File.join(File.dirname(__FILE__) ,  'spec_helper')


describe Microstation do

  context "#root" do

    subject { Microstation.root}

    it { should be_instance_of Pathname}
    it "to_s" do
      subject.to_s.should == Pathname.getwd.to_s
    end
    
  end
end

