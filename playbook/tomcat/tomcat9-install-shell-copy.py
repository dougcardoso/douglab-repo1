import paramiko

# Set the local path to the script to copy
local_path = "/opt/dev/playbook/tomcat/tomcat9-instalation.sh"

# Set the remote paths where the script will be copied
remote_paths = [
    "server2.douglab:/opt/tomcat9/tomcat9-instalation.sh",
    "server3.douglab:/opt/tomcat9/tomcat9-instalation.sh"
]

# Set up the SSH connections to the remote hosts
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

# Loop through the remote paths and copy the script to each host
for remote_path in remote_paths:
    host, path = remote_path.split(":")
    ssh.connect(hostname=host, username="ansible")
    sftp = ssh.open_sftp()
    sftp.put(local_path, path)
    sftp.close()
    ssh.close()
