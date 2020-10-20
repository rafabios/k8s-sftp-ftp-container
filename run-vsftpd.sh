              ######/usr/sbin/run-vsftpd.sh 
#!/bin/bash

# Create home dir and update vsftpd user db:
mkdir -p $FTP_ROOT
mkdir -p /var/run/vsftpd/empty
chown -R ftp:ftp /$FTP_ROOT
echo "${FTP_USER}\n${FTP_PASS}" > /etc/vsftpd/virtual_users.txt
db_load -T -t hash -f /etc/vsftpd/virtual_users.txt /etc/vsftpd/virtual_users.db
# Set passive mode parameters:
echo "local_root=$FTP_ROOT"  >> /etc/vsftpd/vsftpd.conf
if [ "$PASV_ADDRESS" = "REQUIRED" ]; then
	echo "Please insert IPv4 address of your host"
	exit 1
fi
echo "pasv_address=${PASV_ADDRESS}" >> /etc/vsftpd/vsftpd.conf
#echo "listen=YES" >> /etc/vsftpd/vsftpd.conf
#echo "anonymous_enable=NO" /etc/vsftpd/vsftpd.conf 

# Run vsftpd:
nohup vsftpd /etc/vsftpd/vsftpd.conf &  
tini -- dotnet ES.SFTP.Host.dll 
