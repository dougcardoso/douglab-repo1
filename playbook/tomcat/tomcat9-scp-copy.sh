#!/bin/bash

# Download and extract Apache Tomcat
cd /var/lib/awx/projects/dev/tomcat/
scp /var/lib/awx/projects/dev/tomcat/tomcat9-instalation.sh ansible@server2.douglab:/opt/tomcat9/
scp /var/lib/awx/projects/dev/tomcat/tomcat9-instalation.sh ansible@server3.douglab:/opt/tomcat9/
