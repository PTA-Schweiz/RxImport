class Sku < Rximport::Mapping::Base
  SUCCESSOR_NIL_VALUES = ['---', 'No replacement', nil, ' ']

  # map_attribute 'I', :family
  # map_attribute 'J', :pl
  # map_attribute 'A', :series
  map_attribute 'A', :pn
  map_attribute 'B', :platform_name, :strip_string
  map_attribute 'C', :long_description
  map_attribute 'D', :street_price, :convert_street_price
  map_attribute 'I', :predecessor, :convert_predecessor
  map_attribute 'J', :successor, :convert_successor

  map_hash %i[K L M N O P Q R S T U V], :specs


  def convert_predecessor(value, _column, _attr_key)
    value == 'New' ? nil : value
  end

  def convert_successor(value, _column, _attr_key)
    SUCCESSOR_NIL_VALUES.include?(value) ? nil : value
  end

  def convert_street_price(value, _column, _attr_key)
    return nil unless value.is_a? Numeric
    value
  end
end