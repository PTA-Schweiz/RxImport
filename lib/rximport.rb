require 'logger'

require 'core_ext/object/blank'

require 'rximport/version'
require 'rximport/mapping/converters'
require 'rximport/mapping_error'
require 'rximport/mapping/attribute'
require 'rximport/mapping/list_attribute'
require 'rximport/mapping/base'
require 'rximport/column'
require 'rximport/row'
require 'rximport/parser'

module Rximport
  @logger = ::Logger.new(STDOUT)

  class << self
    attr_accessor :logger
  end

end
