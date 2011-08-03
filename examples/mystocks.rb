#!/usr/bin/env ruby
# Simple script export two methods, one of which requires a paramater.
# Usage: ruby mystocks.rb
# then use your brower to visit http://localhost:4567/list_stock/nyc and http://localhost:4567/my_brokerage_account
require 'sinatra'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'classyapi'))

class MyStocks
  attr_reader :my_brokerage_account
  def initialize
    @my_brokerage_account = "32423423"
  end
  def list_stock(stock_symbol)
    { :symbol => stock_symbol, :price => 31.39 }
  end

  def buy_stock(stock_symbol,ammount)
    { :symbol => stock_symbol, :ammount => ammount }
  end

end

@mystocks = MyStocks.new
ClassyAPI::API.export(@mystocks)
use ClassyAPI::API
