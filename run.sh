#! /bin/bash

set -e

service=$SHELL_IN_A_BOX_SERVICE

if [ -z "$service" ]; then
  service="/:root:root:/root:/bin/bash"
fi

echo "export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" > /root/.bashrc

( 
  cd /tmp 
  /usr/bin/shellinaboxd -b --no-beep --service $service
)

exec "$@"
