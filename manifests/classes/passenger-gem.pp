class rvm::passenger-gem {
  rvm_gem {
    "passenger":
      ruby_version => $ruby_version,
      ensure => $version,
      rvm_prefix => $rvm_prefix,
  }
}