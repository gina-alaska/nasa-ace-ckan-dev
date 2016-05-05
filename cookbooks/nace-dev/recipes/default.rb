#
# Cookbook Name:: nace-dev
# Recipe:: default
#
# The MIT License (MIT)
#
# Copyright (c) 2016 UAF GINA
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

link '/opt/solr-4.10.4/example/solr/collection1/conf/schema.xml' do
  to '/usr/lib/ckan/default/src/ckan/ckan/config/solr/schema.xml'
  notifies :restart, 'service[solr]', :immediately
end

include_recipe 'postgresql::ruby'

pg_connection_info = { host: '127.0.0.1' }

postgresql_database_user 'ckan_default' do
  connection pg_connection_info
  password 'pass'
  action :create
end

postgresql_database 'ckan_default' do
  connection pg_connection_info
  encoding 'UTF8'
  owner 'ckan_default'
end

directory '/etc/solr/conf' do
  recursive true
end

execute 'init db' do
  command 'ckan db init'
  notifies :create, 'file[init-db]', :immediately 
  retries 1
  retry_delay 5
  not_if { ::File.exist?('/root/initialized-db') }
end

file 'init-db' do
  path '/root/initialized-db'
  action :nothing
  notifies :restart, 'httpd_service[ckan]', :immediately
end

