require 'spec_helper'

describe 'dewy' do
  describe 'compile' do
    it { should compile }
    it { should compile.with_all_deps }
    it { should contain_class('dewy') }
  end

  describe 'supporting operating systems validation' do
    context 'on RedHat has been supported' do
      it { should compile }
    end

    context 'on Debian has been supported' do
      let(:facts) do
        { :osfamily => 'Debian' }
      end

      it { should compile }
    end
  end
end
