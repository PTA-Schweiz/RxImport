module Rximport
  module Mapping
    class Base
      include Converters

      class << self
        attr_accessor :mappings
        attr_accessor :model_class

        # list with all defined mappings
        def mappings
          @mappings ||= []
        end

        def map_to_model(model_class)
          @model_class = model_class
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

        if self.class.model_class
          self.class.model_class.new target
        else
          target
        end

      end

    end
  end
end