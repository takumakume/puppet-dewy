require 'spec_helper_acceptance'

describe 'dewy' do
  let(:manifest) do
    <<-EOS
      class { '::dewy':
        dir     => '/opt/dewy-testapp',
        command => "server -r linyows/dewy-testapp -a dewy-testapp_linux_amd64.tar.gz -- /opt/dewy-testapp/current/dewy-testapp",
        user    => 'nobody',
        group   => 'nobody',
        require => File['/opt/dewy-testapp/current/dewy-testapp'],
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
end
