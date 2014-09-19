#!/bin/sh

exec /sbin/setuser splunk /opt/splunk/bin/splunk start splunkweb --nodaemon --accept-license
