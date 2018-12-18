module Rximport
  class Row
    attr_accessor :cells
    attr_accessor :columns
    attr_accessor :row_index
    attr_accessor :sheet_name

    def initialize(columns, simple_row, row_index, sheet_name)
      self.cells = simple_row
      self.columns = columns
      self.row_index = row_index
      self.sheet_name = sheet_name
    end

    def [](key)
      cells[key]
    end

    def column_by_name(name)
      columns.find { |c| c.name == name }
    end

    def blank?
      cells.nil? || cells.count.zero?
    end
  end
end