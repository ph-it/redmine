#!/bin/sh

MONGREL_STATUS=""
ERROR=0

. /opt/bitnami/scripts/setenv.sh


start_mongrel() {
    cd /opt/bitnami/apps/redmine-1.1.2
    mongrel_rails cluster::start --clean
    ERROR=$?
}

stop_mongrel() {
    cd /opt/bitnami/apps/redmine-1.1.2
    mongrel_rails cluster::stop
    ERROR=$?
}

status_mongrel() {
    cd /opt/bitnami/apps/redmine-1.1.2
    mongrel_rails cluster::status > scripts/ctl.tmp
    
    egrep "found" scripts/ctl.tmp > /dev/null
    RUNNING=$?
    if [ $RUNNING -eq 0 ]; then
	egrep "missing" scripts/ctl.tmp > /dev/null
	RUNNING=$?
	if [ $RUNNING -eq 1 ]; then
	    MONGREL_STATUS="redmine already running"
	else
	    MONGREL_STATUS="redmine not running"
	fi
    else
	MONGREL_STATUS="redmine not running"
    fi
    rm scripts/ctl.tmp
}


if [ "x$1" = "xstart" ]; then
    start_mongrel

elif [ "x$1" = "xstop" ]; then
    stop_mongrel

elif [ "x$1" = "xstatus" ]; then
    status_mongrel
    echo "$MONGREL_STATUS"
fi


exit $ERROR
