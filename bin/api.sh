#!/bin/sh
### BEGIN INIT INFO
# Provides:          proc_api
# Required-Restart:
# Required-Stop:
# Short-Description: proc_api
# Description:       proc_api
### END INIT INFO

#source ../configer/.env

service_name=flask_api

#service_dir=${APP_DIR}/ghen_covy
service_pid=api.py

#source ${APP_DIR}/venv/bin/activate


restart() {
    int_check=`ps -ef| grep 'python '${service_pid}'' | egrep -v 'grep' |  wc -l`

    if (( int_check == 0))
    then
        echo "service $service_name is stopped."
    else
        ps -ef| grep 'python '${service_pid}'' | egrep -v 'grep' | awk '{print "kill -9 " $2 }'
        ps -ef| grep 'python '${service_pid}'' | egrep -v 'grep' | awk '{print "kill -9 " $2 }' | sh
        echo "service $service_name is stopped."
    fi
    sleep 2
    echo "service $service_name is starting."
    cd ${service_dir}; python ${service_pid} > /dev/null 2>&1 &
    sleep 3
    int_check=`ps -ef| grep 'python '${service_pid}'' | egrep -v 'grep' |  wc -l`
    if (( int_check == 0))
    then
        echo "service $service_name is stopped."
    else
        echo "service $service_name is running."
    fi
}

stop() {
    echo "service $service_name is stopping.."
    ps -ef| grep 'python '${service_pid}'' | egrep -v 'grep' | awk '{print "kill -9 " $2 }'
    ps -ef| grep 'python '${service_pid}'' | egrep -v 'grep' | awk '{print "kill -9 " $2 }' | sh

    int_check=`ps -ef| grep 'python '${service_pid}'' | egrep -v "grep" |  wc -l`
    if (( int_check == 0))
    then
        echo "service $service_name stopped."
    else
        echo "service $service_name is still running. Plz check manual."
    fi
}

status() {
    int_check=`ps -ef| grep 'python '${service_pid}'' | egrep -v "grep" |  wc -l`
    if (( int_check == 0))
    then
        echo "service $service_name is stopped."
    else
        echo "service $service_name is running."
    fi
}

case "$1" in
    stop)
       stop
       ;;
    restart)
       restart
       ;;
    status)
       status
       ;;
    *)
       echo "Usage: $0 {stop|status|restart}"
esac

exit 0