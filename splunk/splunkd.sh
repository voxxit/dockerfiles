#!/bin/sh
chown -R splunk:splunk /opt/splunk/var

exec /sbin/setuser splunk /opt/splunk/bin/splunk start splunkd --nodaemon --accept-license
