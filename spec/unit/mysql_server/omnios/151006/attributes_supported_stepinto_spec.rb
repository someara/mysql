require 'spec_helper'

describe 'mysql_test::mysql_service_attributes on omnios-151006' do

  before do
    stub_command("/opt/mysql56/bin/mysql -u root -e 'show databases;'").and_return(true)
  end

  let(:omnios_151006_default_stepinto_run) do
    ChefSpec::Runner.new(
      :step_into => 'mysql_service',
      :platform => 'omnios',
      :version => '151006'
      ) do |node|
      node.set['mysql']['service_name'] = 'omnios_151006_default_stepinto'
      node.set['mysql']['version'] = '5.6'
      node.set['mysql']['port'] = '3308'
      node.set['mysql']['data_dir'] = '/data'
    end.converge('mysql_test::mysql_service_attributes')
  end

  let(:my_cnf_5_6_content_omnios_151006) do
    '[client]
port                           = 3308

[mysqld_safe]
socket                         = /tmp/mysql.sock

[mysqld]
user                           = mysql
pid-file                       = /var/run/mysql/mysql.pid
socket                         = /tmp/mysql.sock
port                           = 3308
datadir                        = /data
lc-messages-dir                = /opt/mysql56/share
sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES

[mysql]
!includedir /opt/mysql56/etc/mysql/conf.d
'
  end

  # context 'when using default parameters' do
  #   it 'creates mysql_service[omnios_151006_default_stepinto]' do
  #     expect(omnios_151006_default_stepinto_run).to create_mysql_service('omnios_151006_default_stepinto')
  #   end

  #   it 'steps into mysql_service and installs the package' do
  #     expect(omnios_151006_default_stepinto_run).to install_package('database/mysql-56')
  #   end

  #   it 'steps into mysql_service and creates the include directory' do
  #     expect(omnios_151006_default_stepinto_run).to create_directory('/opt/mysql56/etc/mysql/conf.d').with(
  #       :owner => 'mysql',
  #       :group => 'mysql',
  #       :mode => '0750',
  #       :recursive => true
  #       )
  #   end

  #   it 'steps into mysql_service and creates the run directory' do
  #     expect(omnios_151006_default_stepinto_run).to create_directory('/var/run/mysql').with(
  #       :owner => 'mysql',
  #       :group => 'mysql',
  #       :mode => '0755',
  #       :recursive => true
  #       )
  #   end

  #   it 'steps into mysql_service and creates the data directory' do
  #     expect(omnios_151006_default_stepinto_run).to create_directory('/data').with(
  #       :owner => 'mysql',
  #       :group => 'mysql',
  #       :mode => '0750',
  #       :recursive => true
  #       )
  #   end

  #   it 'steps into mysql_service and creates the data directory data subdirectory' do
  #     expect(omnios_151006_default_stepinto_run).to create_directory('/data/data').with(
  #       :owner => 'mysql',
  #       :group => 'mysql',
  #       :mode => '0750',
  #       :recursive => true
  #       )
  #   end

  #   it 'steps into mysql_service and creates the data directory data/mysql' do
  #     expect(omnios_151006_default_stepinto_run).to create_directory('/data/data/mysql').with(
  #       :owner => 'mysql',
  #       :group => 'mysql',
  #       :mode => '0750',
  #       :recursive => true
  #       )
  #   end

  #   it 'steps into mysql_service and creates the data directory data/test' do
  #     expect(omnios_151006_default_stepinto_run).to create_directory('/data/data/test').with(
  #       :owner => 'mysql',
  #       :group => 'mysql',
  #       :mode => '0750',
  #       :recursive => true
  #       )
  #   end

  #   it 'steps into mysql_service and creates my.conf' do
  #     expect(omnios_151006_default_stepinto_run).to create_template('/opt/mysql56/my.cnf').with(
  #       :owner => 'mysql',
  #       :group => 'mysql',
  #       :mode => '0600'
  #     )
  #   end

  #   it 'steps into mysql_service and creates my.conf' do
  #     expect(omnios_151006_default_stepinto_run).to render_file('/opt/mysql56/my.cnf').with_content(my_cnf_5_6_content_omnios_151006)
  #   end

  #   it 'steps into mysql_service and creates a bash resource' do
  #     expect(omnios_151006_default_stepinto_run).to_not run_bash('move mysql data to datadir')
  #   end

  #   it 'steps into mysql_service and initializes the mysql database' do
  #     expect(omnios_151006_default_stepinto_run).to run_execute('initialize mysql database').with(
  #       :command => '/opt/mysql56/scripts/mysql_install_db --basedir=/opt/mysql56 --user=mysql'
  #       )
  #   end

  #   it 'steps into mysql_service and creates my.conf' do
  #     expect(omnios_151006_default_stepinto_run).to create_template('/lib/svc/method/mysqld').with(
  #       :owner => 'root',
  #       :mode => '0555'
  #       )
  #   end

  #   it 'steps into mysql_service and creates /tmp/mysql.xml' do
  #     expect(omnios_151006_default_stepinto_run).to create_template('/tmp/mysql.xml').with(
  #       :owner => 'root',
  #       :mode => '0644'
  #       )
  #   end

  #   it 'steps into mysql_service and imports the mysql service manifest' do
  #     expect(omnios_151006_default_stepinto_run).to_not run_execute('import mysql manifest').with(
  #       :command => 'svccfg import /tmp/mysql.xml'
  #       )
  #   end

  #   it 'steps into mysql_service and manages the mysql service' do
  #     expect(omnios_151006_default_stepinto_run).to start_service('mysql')
  #     expect(omnios_151006_default_stepinto_run).to enable_service('mysql')
  #   end

  #   it 'steps into mysql_service and waits for mysql to start' do
  #     expect(omnios_151006_default_stepinto_run).to run_execute('wait for mysql').with(
  #       :command => 'until [ -S /tmp/mysql.sock ] ; do sleep 1 ; done',
  #       :timeout => 10
  #       )
  #   end

  #   it 'steps into mysql_service and assigns root password' do
  #     expect(omnios_151006_default_stepinto_run).to run_execute('assign-root-password').with(
  #       :command => '/opt/mysql56/bin/mysqladmin -u root password ilikerandompasswords'
  #       )
  #   end

  #   it 'steps into mysql_service and creates /etc/mysql_grants.sql' do
  #     expect(omnios_151006_default_stepinto_run).to create_template('/etc/mysql_grants.sql').with(
  #       :owner => 'root',
  #       :group => 'root',
  #       :mode => '0600'
  #       )
  #   end

  #   it 'steps into mysql_service and installs grants' do
  #     expect(omnios_151006_default_stepinto_run).to_not run_execute('install-grants').with(
  #       :command => '/opt/mysql56/bin/mysql -u root -pilikerandompasswords < /etc/mysql_grants.sql'
  #       )
  #   end
  # end
end
