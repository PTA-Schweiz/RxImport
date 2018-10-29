require 'sku'
RSpec.describe Rximport::Parser do
  let(:parser_config) { {sheet_index: 0, has_titles: true} }
  let(:parser) { Rximport::Parser.new File.open("spec/fixtures/demodata.xlsx", parser_config) }

  describe 'rows' do
    subject { parser.rows }

    it { is_expected.to be_a Enumerable }

    it 'returns a row with columns specification' do
      expect(subject.first).to be_a Rximport::Row
    end
  end

  describe 'columns' do

    subject { parser.columns[0] }
    it { is_expected.to be_a Rximport::Column }

    it 'sets the title of the column' do
      expect(subject.title).to eq('SKU')
    end
  end

  describe 'mapping' do
    let(:mapping) { Sku.new }

    subject { parser.mapped_rows(mapping) }

    it 'returns mapped rows' do
      expect(subject.first).to be_a Hash
    end
  end

end