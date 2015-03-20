#!/bin/sh
if [ $# -eq 0 ]
then
  JAVA_ARGS="-Xmx1024m -Xms128m"
else
  JAVA_ARGS=$*
fi

exec /usr/bin/java $JAVA_ARGS -jar /usr/lib/unifi/lib/ace.jar start
