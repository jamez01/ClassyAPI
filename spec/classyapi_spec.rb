require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class MyStocks
  attr_reader :my_brokerage_account
  def initialize
    @my_brokerage_account = "32423423"
  end
  def list_stock(stock_symbol)
    { :symbol => stock_symbol, :price => 31.39 }
  end

  def buy_stock(stock_symbol,amount)
    { :symbol => stock_symbol, :amount => amount }
  end

end


@mystocks = MyStocks.new
ClassyAPI::API.export(@mystocks)
#use ClassyAPI::API

describe "Classyapi" do
  def app
    ClassyAPI::API
  end
  it "should respond to /my_brokerage_account" do
    get '/my_brokerage_account'
    last_response.should be_ok
    last_response.body.should == "32423423".to_json
  end

  it "should take posts to /list_stock" do
    mystocks = MyStocks.new
    post '/list_stock', {:stock_symbol=>"nyc"}
    last_response.should be_ok
    last_response.body.should == mystocks.list_stock('nyc').to_json
  end

  it "should take posts with multiple paramaters to /buy_stock" do
    post '/buy_stock', {:stock_symbol => "nyc", :amount=>"100"}
    last_response.should be_ok
    last_response.body.should == {:symbol => "nyc", :amount=>100}.to_json
  end
  it "should respond to /buy_stock/nyc/100" do
    get '/buy_stock/nyc/100'
    last_response.should be_ok
    last_response.body.should == {:symbol => "nyc", :amount=>100}.to_json
  end
  it "should 404 on /whatfile" do
    get '/whatfile'
    last_response.body.should == {"status" => 404, "reason" => "Not found"}.to_json
  end
end
