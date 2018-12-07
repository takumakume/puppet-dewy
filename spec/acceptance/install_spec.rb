require 'spec_helper_acceptance'

describe 'dewy' do
  let(:manifest) do
    <<-EOS
      class { '::dewy':
        github_token => "token",
      }
    EOS
  end

  it 'works without errors' do
    result = apply_manifest(manifest, acceptable_exit_codes: [0, 2], catch_failures: true)
    expect(result.exit_code).not_to eq 4
    expect(result.exit_code).not_to eq 6
  end

  it 'runs a second time without changes' do
    result = apply_manifest(manifest)
    expect(result.exit_code).to eq 0
  end

  describe file('/usr/bin/dewy') do
    it { is_expected.to be_directory }
    it { is_expected.to be_mode 755 }
    it { is_expected.to be_owned_by 'nobody' }
    it { is_expected.to be_grouped_into 'nobody' }
  end
end
