#!/bin/sh -e
cd "$DEVPI_SERVERDIR"
case "$DEVPI_ROLE"
in
master)  args="--role $DEVPI_ROLE" ;;
replica) args="--role $DEVPI_ROLE --master $DEVPI_MASTER_URL" ;;
web)     args="--role replica --master $DEVPI_MASTER_URL" ;;
esac

if test ! -e .nodeinfo
then
	if test "$DEVPI_ROLE" = "web"
	then
		pip install devpi-web
	fi
	devpi-server --init $args
fi
exec devpi-server --host 0.0.0.0 $args
