module Rximport
  module Mapping

    # Describes a mapping for an Attribute that will map a cell value
    # to a value in the hash.
    class Attribute

      attr_reader :attr_key
      attr_reader :options

      # @param [String | Number] column_or_index Identifies the location of the
      #   value in the given hash or array when applying mapping
      # @param [Symbol] attr_key The new key for this attribute
      # @param [Hash] options Additional options for the mapping (for example converter)
      def initialize(column_or_index, attr_key, options = {})
        @column_or_index = column_or_index
        @attr_key = attr_key
        @options = options
      end

      # Apply this mapping by reading the value from source and writing it to the target.
      # Conversion will be applied if converter is specified.
      #
      # @param [Array | Hash] source
      # @param [Hash] target
      # @param [Object] mapper_obj The instance of the Mapper object to call the converter on
      def apply_mapping(source, target, mapper_obj)
        target[attr_key] = convert_value(source[@column_or_index], mapper_obj)
      end

      def value_blank?(val)
        val.nil? || val == ''
      end

      protected

      def convert_value(val, mapper_obj)
        if converter = options.fetch(:converter, false)
          mapper_obj.send(converter, val, @column_or_index, @attr_key)
        else
          val
        end
      end

    end
  end
end