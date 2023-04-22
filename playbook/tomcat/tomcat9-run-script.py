import paramiko

# Set the SSH commands to run on each remote host
ssh_commands = [
    "sh /opt/tomcat/tomcat9-instalation.sh",
    "sh /opt/tomcat/tomcat9-instalation.sh"
]

# Set up the SSH connections to the remote hosts
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
hosts = ["server2.douglab", "server3.douglab"]
user = "ansible"

for host, command in zip(hosts, ssh_commands):
    ssh.connect(hostname=host, username=user)
    stdin, stdout, stderr = ssh.exec_command(command)
    output = stdout.read().decode('utf-8')
    error = stderr.read().decode('utf-8')
    print("Output for {}:".format(host), output)
    print("Error for {}:".format(host), error)
    ssh.close()
