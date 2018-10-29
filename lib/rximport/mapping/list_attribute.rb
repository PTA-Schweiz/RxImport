module Rximport
  module Mapping

    # Maps multiple columns into one attribute. The result will be either an
    # Array with each value or a hash where the corresponding column titles
    # will be used as keys.
    #
    class ListAttribute < Attribute

      # @param [String | Number] column_or_index_range Identifies the location of the
      #   values in the given hash or array when applying mapping
      # @param [Symbol] attr_key The new key for this attribute
      # @param [Hash] options Additional options for the mapping (for example converter)
      #
      # Options:
      #   converter:  A method name to convert the value in the cell to the target type
      #   skip_blank: whet(default is true)
      #   type:       :array or :hash
      def initialize(column_or_index_range, attr_key, options = {})
        super nil, attr_key, options
        @column_or_index_range = column_or_index_range
      end

      # Apply this mapping by reading the value from source and writing it to the target.
      # Conversion will be applied if converter is specified.
      #
      # @param [Row] source
      # @param [Hash] target
      # @param [Object] mapper_obj The instance of the Mapper object to call the converter on
      def apply_mapping(source, target, mapper_obj)
        type = options.fetch(:type, :array)
        case type
          when :array
            target[attr_key] = to_array(source, mapper_obj)
          when :hash
            target[attr_key] = to_hash(source, mapper_obj)
          else
            raise "Unknown type #{type} for list_attribute"
        end
      end

      private

      def to_array(source, mapper_obj)
        result = []
        @column_or_index_range.each do |index|
          source_value = source[index.to_s]
          result << convert_value(source_value, mapper_obj) unless value_blank?(source_value)
        end
        result
      end

      def to_hash(source, mapper_obj)
        result = {}
        @column_or_index_range.each do |index|
          source_value = source[index.to_s]
          begin
            key = source.column_by_name(index.to_s).title
          rescue Exception => e
            raise "Could not find title for column index #{index}"
          end

          result[key] = convert_value(source_value, mapper_obj) unless value_blank?(source_value)
        end
        result
      end

    end
  end
end