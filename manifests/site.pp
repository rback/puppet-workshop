node "app.vagrant.local" {
  $tomcat_port = "8080"

  class { "varnish_rhel":
    varnish_data_directory => "/var/lib/varnish",
    varnish_storage_size   => "10M",
    varnish_listen_port    => 80
  }

  varnish_rhel::vcl { "/etc/varnish/default.vcl":
    vcl_content => template("varnish/etc/varnish/default.vcl.erb")
  }

  user { "java":
  	comment => "Java User",
  	home => "/home/java",
  	ensure => present,
  }

  tomcat7_rhel::tomcat_application { "example-servlet":
    application_root => "/opt",
    tomcat_user => "java",
    tomcat_port => $tomcat_port,
    jvm_envs => "-server -Xmx1024m -XX:MaxPermSize=64m -Driak_ip=10.10.10.11 -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false  -Dcom.sun.management.jmxremote.ssl=false",
    tomcat_manager => true,
    tomcat_admin_user => "java",
    tomcat_admin_password => "secretpassword",
    smoke_test_path => "/health-check",
    require => User["java"]
  }
}

node "riak1.vagrant.local", "riak2.vagrant.local", "riak3.vagrant.local" {
  if $::fqdn == "riak1.vagrant.local" {
    class { "riak": riak_control => true}
  } else {
    class { "riak": join_ip => "10.10.10.11" }
  }
}
