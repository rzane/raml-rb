require 'raml/root'

describe Raml::Root do

  describe '#resources' do
    subject { Raml::Root.new.resources }
    it { is_expected.to be_kind_of Array }
  end

  describe '#documentation' do
    subject { Raml::Root.new.documentation }
    it { is_expected.to be_kind_of Array }
  end

  describe '#uri' do
    let(:root) { Raml::Root.new }
    before { root.base_uri = 'http://example.com' }
    subject { root.uri }
    it { is_expected.to eq('http://example.com') }
  end

  describe '#title' do
    let(:root) { Raml::Root.new }
    before { root.title = 'My RAML' }
    subject { root.title }
    it { is_expected.to eq('My RAML') }
  end

  describe '#version' do
    let(:root) { Raml::Root.new }
    before { root.version = '1.0' }
    subject { root.version }
    it { is_expected.to eq('1.0') }
  end

end
