#!/bin/bash

# Download and extract Apache Tomcat
cd /tmp
#wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.74/bin/apache-tomcat-9.0.74-deployer.tar.gz
tar -xzvf apache-tomcat-9.0.74-deployer.tar.gz

# Move the extracted directory to /opt and rename it to tomcat
mv apache-tomcat-9.0.74-deployer /opt/tomcat9

# Create a tomcat user and group
groupadd tomcat
useradd -s /bin/nologin -g tomcat -d /opt/tomcat9 tomcat

# Set the appropriate permissions
cd /opt/tomcat9
chgrp -R tomcat conf
chmod g+rwx conf
chmod g+r conf/*
chown -R tomcat logs/ temp/ webapps/ work/

# Install Tomcat as a service
cat > /etc/systemd/system/tomcat.service <<EOF
[Unit]
Description=Apache Tomcat Web Application Container
After=syslog.target network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk
Environment=CATALINA_PID=/opt/tomcat9/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat9
Environment=CATALINA_BASE=/opt/tomcat9
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'

ExecStart=/opt/tomcat9/bin/startup.sh
ExecStop=/opt/tomcat9/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Reload the systemd daemon
systemctl daemon-reload

# Start and enable the Tomcat service
systemctl start tomcat
systemctl enable tomcat

echo "Tomcat has been successfully installed as a service."
