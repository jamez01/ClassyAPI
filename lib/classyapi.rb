#       classyapi.rb
#
#       Copyright 2011 james paterni <james@ruby-code.com> & Ian Morgan <ian@ruby-code.com>
#
#       This program is free software; you can redistribute it and/or modify
#       it under the terms of the GNU General Public License as published by
#       the Free Software Foundation; either version 2 of the License, or
#       (at your option) any later version.
#
#       This program is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#       GNU General Public License for more details.
#
#       You should have received a copy of the GNU General Public License
#       along with this program; if not, write to the Free Software
#       Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#       MA 02110-1301, USA.

  require 'sinatra'
  require './lib/classyapi/deeper.rb'
  require 'json'
  require 'yaml'
module ClassyAPI
  class API < Sinatra::Base
    @@options = {:base_path => '/', :render => lambda{|out| out.to_json } }
    @object_store = Array.new
    enable :static, :session
    set :root, File.dirname(__FILE__)
    
    get '/' do
      "Welcome to ClassyAPI"
    end
    
    def self.export(obj)
      obj.extend(Deeper)
      (obj.deeper.methods_without_parameters - Object.methods).each { |meth|
        get "/#{meth.to_s}/?" do
          @@options[:render].call(obj.send(meth))
        end
      }
      obj.deeper.methods_with_parameters.each { |meth,parms|
        next if Object.respond_to?(meth)
        get "/#{meth.to_s}/:#{parms.map { |x| x = x[1] }.join("/") }/?" do
          @@options[:render].call(obj.send(meth.to_s,params.map{ |x| x=x[1] } ))
        end
      }

    end
    
    not_found do
      json_status 404, "Not found"
    end

    error do
      json_status 500, env['sinatra.error'].message
    end
    
    helpers do
      def json_status(code, reason)
        status code
        {
          :status => code,
          :reason => reason
        }.to_json
      end
    end
  end
end
