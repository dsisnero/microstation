require_relative 'spec_helper'


describe Microstation::App do
  
  it "should allow you to " do
    app = Microstation::App.new
    app.ole_object.class.should == WIN32OLE
    end

end
