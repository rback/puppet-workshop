puppet-workshop
===============

    vagrant up app
    curl -O download.reaktor.fi/devopskoulu/example-servlet-trunk-SNAPSHOT.war
    vagrant ssh app
    sudo -s /opt/example-servlet/bin/deploy_with_tomcat_manager.sh /vagrant/example-servlet-trunk-SNAPSHOT.war
