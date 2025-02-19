#!/bin/sh
	
	for i in `seq 1 60`; do
	  echo "Wait for 1 seconds..."
	  sleep 1
	
	  export PGPASSWORD=postgres

	  /usr/bin/psql -h 'db' -p '5432' -U 'postgres' -c 'select 1;' 2>&1 > /dev/null

	  if [[ $? -eq 0 ]]; then
	    echo "Connection established."
	    /usr/bin/pgweb --bind=0.0.0.0 --listen=8081
	  fi
	done
	
	echo "Failed to connect to database."
	exit 1
