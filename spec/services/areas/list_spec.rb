require 'rails_helper'

module Areas
  RSpec.describe List, type: :service do
    let(:path) { "#{Rails.root}/data/areas/*.json" }
    let(:filenames) { instance_double(Array) }
    let(:file_path) { instance_double(String) }
    let(:areas) { instance_double(String) }

    subject { described_class.call }

    before do
      allow(Dir).to receive(:glob).with(path).and_return(filenames)
      allow(filenames).to receive(:first).and_return(file_path)
      allow(File).to receive(:read).with(file_path).and_return(areas)
    end

    it 'returns parsed json' do
      expect(JSON).to receive(:parse).with(areas)
      subject
    end
  end
end
