FROM phusion/baseimage:latest

MAINTAINER Joshua Delsman <j@srv.im>

EXPOSE 8000

ADD splunk-6.1.3-220630-linux-2.6-amd64.deb /splunk.deb
ADD splunkd.sh /etc/service/splunkd/run
ADD splunkweb.sh /etc/service/splunkweb/run

VOLUME ["/opt/splunk/var"]

RUN dpkg -i splunk.deb \
  && rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh /splunk.deb
