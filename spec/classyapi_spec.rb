require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class MyStocks
  attr_reader :my_brokerage_account
  @my_brokerage_account = "32423423"
  
  def list_stock(stock_symbol)
    { :name => stock_symbol, :price => 31.39 }
  end  
end


describe "Classyapi" do
  it "should create" do
    fail "hey buddy, you should probably rename this file and start specing for real"
  end
end
