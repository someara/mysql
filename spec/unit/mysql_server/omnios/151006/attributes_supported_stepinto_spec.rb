# require 'spec_helper'

# describe 'mysql_test::mysql_service_attributes on omnios-151006' do

#   before do
#     stub_command("/opt/mysql55/bin/mysql -u root -e 'show databases;'").and_return(true)
#   end

#   let(:omnios_151006_attributes_supported_stepinto_run) do
#     ChefSpec::Runner.new(
#       :step_into => 'mysql_service',
#       :platform => 'omnios',
#       :version => '151006',
#       ) do |node|
#       node.set['mysql']['service_name'] = 'omnios_151006_attributes_supported_stepinto'
#       node.set['mysql']['port'] = '3308'
#       node.set['mysql']['version'] = '5.6'
#       node.set['mysql']['data_dir'] = '/data'
#     end.converge('mysql_test::mysql_service_attributes')
#   end

#   let(:my_cnf_content_omnios_151006) do
#     '[client]
# port                           = 3308
# socket                         = /tmp/mysql.sock

# [mysqld_safe]
# socket                         = /tmp/mysql.sock
# nice                           = 0

# [mysqld]
# user                           = mysql
# pid-file                       = /var/run/mysql/mysql.pid
# socket                         = /tmp/mysql.sock
# port                           = 3308
# datadir                        = /data
# tmpdir                         = /tmp
# lc-messages-dir                =

# [mysql]
# !includedir /opt/mysql55/etc/mysql/conf.d'
#   end

#   context 'when using supported custom parameters' do
#     it 'creates mysql_service[omnios_151006_attributes_supported_stepinto]' do
#       expect(omnios_151006_attributes_supported_stepinto_run).to create_mysql_service('omnios_151006_attributes_supported_stepinto')
#     end

#     it 'steps into mysql_service and installs the package' do
#       expect(omnios_151006_attributes_supported_stepinto_run).to install_package('database/mysql-55')
#     end

#     it 'steps into mysql_service and creates the include directory' do
#       expect(omnios_151006_attributes_supported_stepinto_run).to create_directory('/opt/mysql55/etc/mysql/conf.d').with(
#         :owner => 'mysql',
#         :mode => '0750',
#         :recursive => true
#         )
#     end

#     it 'steps into mysql_service and creates the run directory' do
#       expect(omnios_151006_attributes_supported_stepinto_run).to create_directory('/var/run/mysql').with(
#         :owner => 'mysql',
#         :mode => '0755',
#         :recursive => true
#         )
#     end

#     it 'steps into mysql_service and creates the data directory' do
#       expect(omnios_151006_attributes_supported_stepinto_run).to create_directory('/var/lib/mysql').with(
#         :owner => 'mysql',
#         :mode => '0750',
#         :recursive => true
#         )
#     end

#     # FIXME: add render_file
#     it 'steps into mysql_service and creates my.conf' do
#       expect(omnios_151006_attributes_supported_stepinto_run).to create_template('/opt/mysql55/etc/my.cnf').with(
#         :owner => 'mysql',
#         :mode => '0600'
#       )
#     end

#     # it 'steps into mysql_service and creates my.conf' do
#     #   expect(omnios_151006_attributes_supported_stepinto_run).to render_file('/opt/mysql55/etc/my.cnf').with_content(my_cnf_content_omnios_151006)
#     # end

#     it 'steps into mysql_service and creates a bash resource' do
#       expect(omnios_151006_attributes_supported_stepinto_run).to_not run_bash('move mysql data to datadir')
#     end

#     it 'steps into mysql_service and initializes the mysql database' do
#       expect(omnios_151006_attributes_supported_stepinto_run).to run_execute('initialize mysql database').with(
#         :command => '/opt/mysql55/scripts/mysql_install_db --basedir=/opt/mysql55'
#         )
#     end

#     # FIXME: add render_file
#     it 'steps into mysql_service and creates my.conf' do
#       expect(omnios_151006_attributes_supported_stepinto_run).to create_template('/lib/svc/method/mysqld').with(
#         :owner => 'root',
#         :mode => '0555'
#         )
#     end

#     # FIXME: add render_file
#     it 'steps into mysql_service and creates /tmp/mysql.xml' do
#       expect(omnios_151006_attributes_supported_stepinto_run).to create_template('/tmp/mysql.xml').with(
#         :owner => 'root',
#         :mode => '0644'
#         )
#     end

#     it 'steps into mysql_service and imports the mysql service manifest' do
#       expect(omnios_151006_attributes_supported_stepinto_run).to_not run_execute('import mysql manifest').with(
#         :command => 'svccfg import /tmp/mysql.xml'
#         )
#     end

#     it 'steps into mysql_service and manages the mysql service' do
#       expect(omnios_151006_attributes_supported_stepinto_run).to start_service('mysql')
#       expect(omnios_151006_attributes_supported_stepinto_run).to enable_service('mysql')
#     end

#     it 'steps into mysql_service and waits for mysql to start' do
#       expect(omnios_151006_attributes_supported_stepinto_run).to run_execute('wait for mysql').with(
#         :command => 'until [ -S /tmp/mysql.sock ] ; do sleep 1 ; done',
#         :timeout => 10
#         )
#     end

#     it 'steps into mysql_service and assigns root password' do
#       expect(omnios_151006_attributes_supported_stepinto_run).to run_execute('assign-root-password').with(
#         :command => '/opt/mysql55/bin/mysqladmin -u root password ilikerandompasswords'
#         )
#     end

#     # FIXME: add render_file
#     it 'steps into mysql_service and creates /etc/mysql_grants.sql' do
#       expect(omnios_151006_attributes_supported_stepinto_run).to create_template('/etc/mysql_grants.sql').with(
#         :owner => 'root',
#         :group => 'root',
#         :mode => '0600'
#         )
#     end

#     it 'steps into mysql_service and installs grants' do
#       expect(omnios_151006_attributes_supported_stepinto_run).to_not run_execute('install-grants').with(
#         :command => '/opt/mysql55/bin/mysql -u root -pilikerandompasswords < /etc/mysql_grants.sql'
#         )
#     end
#   end
# end
