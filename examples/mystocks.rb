#!/usr/bin/env ruby
# Simple script export two methods, one of which requires a paramater.
# Usage: ruby mystocks.rb
# then use your brower to visit http://localhost:4567/list_stock/nyc and http://localhost:4567/my_brokerage_account

require 'sinatra'
if File.exists?("../lib/classyapi.rb") then
  require '../lib/classyapi.rb'
elsif File.exists?("./lib/classyapi.rb") then
  require './lib/classyapi.rb'
else
  raise LoadError
end
class MyStocks
  attr_reader :my_brokerage_account
  def initialize
    @my_brokerage_account = "32423423"
  end
  def list_stock(stock_symbol)
    { :symbol => stock_symbol, :price => 31.39 }
  end

end

@mystocks = MyStocks.new
ClassyAPI::API.export(@mystocks)
use ClassyAPI::API
