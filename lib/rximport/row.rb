module Rximport
  class Row
    attr_accessor :cells
    attr_accessor :columns

    def initialize(columns, simple_row)
      self.cells = simple_row
      self.columns = columns
    end

    def [](key)
      cells[key]
    end

    def column_by_name(name)
      self.columns.find { |c| c.name == name }
    end

    def blank?
      cells.nil? || cells.count.zero?
    end
  end
end