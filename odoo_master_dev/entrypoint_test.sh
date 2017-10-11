#!/bin/bash

#set -e
#set -v

# set the postgres database host, port, user and password according to the environment
# and pass them as arguments to the odoo process if not present in the config file
: ${HOST:=${DB_PORT_5432_TCP_ADDR:='db'}}
: ${PORT:=${DB_PORT_5432_TCP_PORT:=5432}}
: ${USER:=${DB_ENV_POSTGRES_USER:=${POSTGRES_USER:='odoo'}}}
: ${PASSWORD:=${DB_ENV_POSTGRES_PASSWORD:=${POSTGRES_PASSWORD:='odoo'}}}

#echo ${HOST}
#echo ${PORT}
#echo ${USER}
#echo ${PASSWORD}
#echo ${POSTGRES_USER}
#echo ${POSTGRES_PASSWORD}

ODOO_RC=odoo.conf

DB_ARGS=()
function check_config() {
    param="$1"
    value="$2"
    if ! grep -q -E "^\s*\b${param}\b\s*=" "$ODOO_RC" ; then
        DB_ARGS+=("--${param}")
        DB_ARGS+=("${value}")
   fi;
}

#echo $ODOO_RC

check_config "db_host" "$HOST"
check_config "db_port" "$PORT"
check_config "db_user" "$USER"
check_config "db_password" "$PASSWORD"

#echo ${DB_ARGS[@]}

case "$1" in
    -- | odoo)
        shift
        if [[ "$1" == "scaffold" ]] ; then
            echo /opt/odoo/sources/odoo-bin  "$@"
            exec /opt/odoo/sources/odoo-bin  "$@"
        else
            echo /opt/odoo/sources/odoo-bin  "$@" "${DB_ARGS[@]}"
            exec /opt/odoo/sources/odoo-bin  "$@" "${DB_ARGS[@]}"
        fi
        ;;
      -*)
        echo /opt/odoo/sources/odoo-bin  "$@" "${DB_ARGS[@]}"
        exec /opt/odoo/sources/odoo-bin  "$@" "${DB_ARGS[@]}"
        ;;
      *)
        echo "$@"
        exec "$@"
esac

exit 1
