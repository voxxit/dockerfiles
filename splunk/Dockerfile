FROM debian:stable

MAINTAINER Joshua Delsman <j@srv.im>

EXPOSE 10000 10089 514

VOLUME ["/var/splunk"]

ADD splunk-6.1.3.deb /splunk-6.1.3.deb
ADD splunkd.sh /etc/service/splunkd/run
ADD splunkweb.sh /etc/service/splunkweb/run

# check file integrity
RUN echo 'MD5(/splunk-6.1.3.deb)= 61228984bc89d4c778962c4c400ccc52' | md5sum -c && \
# install splunk
  dpkg -i /splunk-6.1.3.deb && \
# remove ssh & splunk installation binary
  rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh /splunk-6.1.3.deb && \
# change to the splunk bin directory
  cd /opt/splunk/bin && \
# change the default splunkweb port
  ./splunk --accept-license set web-port 10000 && \
# change the default splunkd port
  ./splunk set splunkd-port 10089 && \
# change the data store
  ./splunk set datastore-dir /var/splunk && \
# Add TCP port 514 as a syslog source
  ./splunk add tcp 514 -sourcetype syslog
