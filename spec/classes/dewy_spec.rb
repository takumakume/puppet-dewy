require 'spec_helper'

describe 'dewy' do
  describe 'compile' do
    it { VCR.use_cassette('dewy_latest') { should compile } }
    it { VCR.use_cassette('dewy_latest') { should compile.with_all_deps } }
    it { VCR.use_cassette('dewy_latest') { should contain_class('dewy') } }
  end

  describe 'supporting operating systems validation' do
    context 'on RedHat has been supported' do
      it { VCR.use_cassette('dewy_latest') { should compile } }
    end

    context 'on Debian has been supported' do
      let(:facts) do
        { :osfamily => 'Debian' }
      end

      it { VCR.use_cassette('dewy_latest') { should compile } }
    end
  end
end
