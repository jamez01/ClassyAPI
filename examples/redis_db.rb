#!/usr/bin/env ruby
require 'sinatra'
require 'redis'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'classyapi'))


class StockBroker
  R = Redis.new
  def save_holding(stock_symbol, shares)
    R[stock_symbol] = shares
  end
  def get_holding(stock_symbol)
    R[stock_symbol]
  end
end

@stockbroker = StockBroker.new
ClassyAPI::API.export(@stockbroker)
use ClassyAPI::API
