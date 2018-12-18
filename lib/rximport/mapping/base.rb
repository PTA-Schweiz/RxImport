module Rximport
  module Mapping
    class Base
      class << self
        include Converters

        attr_accessor :mappings

        # list with all defined mappings
        def mappings
          @mappings ||= []
        end

        def map_attribute(column_or_index, attr_key, converter = nil)
          mappings << Rximport::Mapping::Attribute.new(column_or_index, attr_key, converter: converter)
        end

        def map_array(column_or_index_range, attr_key, options = {})
          mappings << Rximport::Mapping::ListAttribute.new(column_or_index_range,
                                                           attr_key,
                                                           options)
        end

        def map_hash(column_or_index_range, attr_key, options = {})
          mappings << Rximport::Mapping::ListAttribute.new(column_or_index_range,
                                                           attr_key,
                                                           options.merge(type: :hash))
        end

        def mapped_columns
          @mappings.map(&:columns)
        end
      end

      def apply(values, target={})
        self.class.mappings.each do |mapping|
          mapping.apply_mapping(values, target, self)
        end
        target
      end

    end
  end
end