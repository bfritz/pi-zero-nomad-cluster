require 'serverspec'

# Required by serverspec
set :backend, :exec


describe package('dnsmasq') do
  it { should be_installed }
end

describe file('/etc/dnsmasq.conf') do
    it { should be_file }
    it { should be_mode 640 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its(:content) { should match /^conf-dir=.*conf$/ }
end

describe file('/etc/dnsmasq.d/nodes.conf') do
    it { should be_file }
    it { should be_mode 640 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its(:content) { should match /^interface=usb\*/ }
    its(:content) { should match /^bind-dynamic/ }      # the USB gadget interfaces will come and go
    its(:content) { should match /^dhcp-range=/ }
end
