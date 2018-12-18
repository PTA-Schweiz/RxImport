RSpec.describe Rximport::Mapping::Converters do

  class Converter
    extend Rximport::Mapping::Converters
  end

  let(:converter) { Converter }

  describe 'strip_string' do
    subject { converter.strip_string(val) }

    context 'providing a string' do
      let(:val) { '  Test ' }
      it { is_expected.to eq 'Test' }
    end

    context 'providing nil' do
      let(:val) { nil }
      it { is_expected.to be_nil }
    end

    context 'providing numeric' do
      let(:val) { 12.3 }
      it { is_expected.to be val }
    end
  end

  describe 'value_to_bool' do
    FALSEY_VALUES = [false, 0, "0", "f", "F", "false", "FALSE", "off", "OFF", "", nil]
    TRUTHY_VALUES = ["some", 1, -1]

    FALSEY_VALUES.each do |val|
      it "is expect to return false for #{val.inspect}" do
        expect(converter.value_to_bool(val)).to be_falsey
      end
    end


    TRUTHY_VALUES.each do |val|
      it "is expect to return true for #{val.inspect}" do
        expect(converter.value_to_bool(val)).to be_truthy
      end
    end

  end

  describe 'to_numeric' do
    describe 'strip_string' do
      subject { converter.to_numeric(val) }

      context 'providing a string' do
        let(:val) { '  12.3 ' }
        it { is_expected.to eq 12.3 }
      end

      context 'providing nil' do
        let(:val) { nil }
        it { is_expected.to be_nil }
      end

      context 'providing numeric' do
        let(:val) { 12.3 }
        it { is_expected.to be val }
      end

      context 'other value' do
        let(:val) { "test" }
        it { is_expected.to be nil }
      end
    end
  end
end
