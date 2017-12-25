require "spec_helper"
require "serverspec"

package = "opentsdb"
service = "opentsdb"
# process = "tsdb"
config  = "/etc/opentsdb/opentsdb.conf"
log_config = "/etc/opentsdb/logback.xml"
# user    = "opentsdb"
# group   = "opentsdb"
ports   = [4242]
log_dir = "/var/log/opentsdb"
cache_dir = "/tmp/opentsdb"

case os[:family]
when "freebsd"
  config     = "/usr/local/etc/opentsdb/opentsdb.conf"
  log_config = "/usr/local/etc/opentsdb/logback.xml"
end

describe file(log_dir) do
  it { should be_directory }
  it { should be_mode 755 }
end

describe file(cache_dir) do
  it { should be_directory }
  it { should be_mode 750 }
end

describe file(config) do
  it { should be_file }
  its(:content) { should match Regexp.escape("tsd.network.bind = 0.0.0.0") }
  its(:content) { should match Regexp.escape("tsd.network.port = 4242") }
  its(:content) { should match Regexp.escape("tsd.http.staticroot = /usr/local/share/opentsdb/static") }
  its(:content) { should match Regexp.escape("tsd.http.cachedir = /tmp/opentsdb") }
  its(:content) { should match Regexp.escape("tsd.storage.hbase.zk_quorum = localhost") }
end

describe file(log_config) do
  it { should be_file }
  its(:content) { should match Regexp.escape("<file>/var/log/opentsdb/opentsdb.log</file>") }
end

describe package(package) do
  it { should be_installed }
end

describe service(service) do
  it { should be_running }
  it { should be_enabled }
end

ports.each do |p|
  describe port(p) do
    it { should be_listening }
  end
end
