module Rximport
  module Mapping
    module Converters
      FALSEY_VALUES = [false, 0, "0", "f", "F", "false", "FALSE", "off", "OFF", nil]

      # Convert any non nil or empty or other falsey value to true
      # False values:
      #   false, 0, "0", "f", "F", "false", "FALSE", "off", "OFF", nil
      def value_to_bool(value, _column=nil, _attr_key=nil)
        FALSEY_VALUES.include? value
      end

      # Tries to convert the value to a Numeric by calling
      # +to_f+ if the value is a string.
      def to_numeric(value, _column=nil, _attr_key=nil)
        return nil if blank_value? value
        case value
        when String
          value.to_f
        when Numeric
          value
        end
      end

      # Removes leading whitespaces and whitespaces at the end of the string.
      def strip_string(value, _column=nil, _attr_key=nil)
        value.is_a? String ? value.strip : value
      end

      private

      # Checks if a value is blank. Returns true if
      #   * value is nil
      #   * value is a String AND empty
      #
      # This will NOT check for emptyness of Lists
      def blank_value?(val)
        val.nil? || (val.respond_to?(:empty?) && val.empty?)
      end
    end
  end
end
