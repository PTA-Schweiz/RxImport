module Rximport

  # Represents a column in the excel sheet
  class Column
    attr_accessor :index
    attr_accessor :title
    attr_accessor :name

    def initialize(index, title, name)
      @index = index
      @title = title
      @name = name
    end
  end
end