module Deeper
    class Deeper
      def initialize(inspecter)
        @inspecter=inspecter
        # return array including class name and namespace
      end
      def class_array
        @inspecter.class.to_s.split("::")
      end
      # return array of method parameters
      def parameters(method_name = "()")
        @inspecter.method(method_name.to_sym).parameters
      end
      def methods
        return_hash = Hash.new
        @inspecter.methods.each{|meth|
          next if meth == 'deeper'.to_sym
          return_hash[meth.to_sym] = parameters(meth)
          return_hash[meth.to_sym] = nil if return_hash[meth.to_sym].empty?
        }
        return return_hash
      end
      def methods_with_parameters
        return_hash = Hash.new
        methods.each{|key,params|
          return_hash[key] = params unless params.nil?
        }
        return return_hash
      end
      def methods_without_parameters
        return_array = Array.new
        methods.each {|key,params|
          return_array << key if params.nil?
        }
        return return_array
      end
      def inspect
        methods
      end
       def to_yaml(x,&b)
        YAML::quick_emit("",{})
      end
    end
  private
  def self.extend_object(mod)
    mod.instance_variable_set("@deeper".to_sym, Deeper.new(mod))
    mod.define_singleton_method(:deeper) { return @deeper }
    #super
  end

  def self.included(mod)
    mod.send :define_method, :deeper do
      @deeper ||= Deeper.new(self)
      return @deeper
    end

  end
end
