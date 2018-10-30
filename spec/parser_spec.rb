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

  describe 'offsets' do
    let(:mapping) { DesktopAndNotebookPlatforms.new }
    let(:parser_config) { { sheet: 2,
                            has_titles: true,
                            title_index: 0,
                            date_start_index: 5 }}
    subject { Rximport::Parser.new File.open("spec/fixtures/demodata.xlsx"), parser_config }

    it 'sets titles from correct index' do
      expect(subject.titles).to include 'Atribute DE 1'
    end

    context 'remote files' do
      let(:remote_file_url) { 'https://s3.eu-central-1.amazonaws.com/stage-hpgo-media/test-files/DaaSV3_Pricelist.xlsx' }

      subject { described_class.new(remote_file_url, remote: true) }

      it 'is possible to read from remote files' do
        subject.rows.count
        expect {
          subject.sheet
        }.not_to raise_error
      end
    end

  end

end