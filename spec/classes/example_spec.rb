require 'spec_helper'

describe 'polipo' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "polipo class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('polipo::params') }
        it { should contain_class('polipo::install').that_comes_before('polipo::config') }
        it { should contain_class('polipo::config') }
        it { should contain_class('polipo::service').that_subscribes_to('polipo::config') }

        it { should contain_service('polipo') }
        it { should contain_package('polipo').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'polipo class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('polipo') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
