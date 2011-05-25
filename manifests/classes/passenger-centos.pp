class rvm::passenger::apache::centos {

  # Dependencies
  if ! defined(Package["httpd"]) { package { "httpd": ensure => installed } }
  if ! defined(Package["httpd-devel"]) { package { "httpd-devel":  ensure => installed } }
  
  exec {
    'passenger-install-apache2-module':
        command => "${binpath}rvm ${ruby_version} exec passenger-install-apache2-module -a",
        creates => "${gempath}/passenger-${version}/ext/apache2/mod_passenger.so",
        logoutput => 'on_failure',
        require => [Rvm_gem['passenger'], Package['httpd','httpd-devel','mod_ssl']];
  }
  
  file {
    '/etc/httpd/passenger.load':
      content => "LoadModule passenger_module ${gempath}/passenger-${version}/ext/apache2/mod_passenger.so",
      ensure => file,
      require => Exec['passenger-install-apache2-module'];
  }
  
}
  