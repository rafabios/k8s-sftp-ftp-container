from emberstack/sftp:build-4.0.23

COPY run-vsftpd.sh /usr/sbin/run-vsftpd.sh 


RUN apt-get update
RUN apt-get install -y vsftpd db-util
RUN mkdir -p /etc/vsftpd/ &&\
    chmod +x /usr/sbin/run-vsftpd.sh

COPY vsftpd.conf /etc/vsftpd/
COPY vsftpd /etc/pam.d/
COPY vsftpd_virtual /etc/pam.d/

ENTRYPOINT /usr/sbin/run-vsftpd.sh

