if [ -z "$1" ]
then
  echo "Usage: ./container_shell.sh <name_of_container>\
    \n\tyou can use docker ps to find out"
  exit 1
fi
sudo docker exec -it $1 /bin/bash
