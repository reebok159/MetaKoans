def attribute(arg, &block)
    var_name = arg
    if arg.is_a? (Hash)
      var_name = arg.keys[0]
    end

      define_method :"#{var_name}" do
        unless instance_variable_defined? :"@#{var_name}"
          value = block ? (instance_eval &block) : (arg.is_a?(Hash) ? arg.values[0] : nil)
          instance_variable_set(:"@#{var_name}", value)
        end

        instance_variable_get(:"@#{var_name}")
      end

      define_method :"#{var_name}?" do
        return instance_variable_get(:"@#{var_name}") if instance_variable_defined? :"@#{var_name}"
        false
      end

      define_method :"#{var_name}=" do |value|
        instance_variable_set(:"@#{var_name}", value)
      end
end
