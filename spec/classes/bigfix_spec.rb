require 'spec_helper'

describe 'bigfix', :type => :class do

  let(:facts) { {
      :osfamily  => 'Windows'
  } }
  let(:params) {{
      :package_source  => '',
      :package_version => ''
  }}

  it { should contain_class('bigfix::install') }


  context 'using params defaults' do
    it { should contain_class('bigfix') }
    it { should contain_package('BigFix Enterprise Client').with(
      'ensure'   => 'installed',
      'provider' => 'windows',
      'source'   => '/'
    )}

  end

  context 'installing a custom version' do

    let(:params) { {'package_version' => 'CustomVersion.exe', 'package_source' => 'http://myproxy.com:8080' } }

    it { should contain_package('BigFix Enterprise Client').with(
      'ensure'   => 'installed',
      'provider' => 'windows',
      'source'   => 'http://myproxy.com:8080/CustomVersion.exe'
    )}

  end

  context 'when trying to install on Ubuntu' do
    let(:facts) { {:osfamily => 'Ubuntu'} }
    it do
      expect {
        should contain_class('bigfix')
      }.to raise_error(Puppet::Error, /^This module only works on Windows based systems./)
    end
  end

end
