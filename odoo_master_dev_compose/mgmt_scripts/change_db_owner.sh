if [ -z "$1" ]
then
  echo "Usage: $0 <name_of_container>\n\tyou can use docker ps to find out"
  exit 1
fi
sudo docker exec -it $1 psql -U odoo -d odoo -c 'ALTER DATABASE odoo OWNER TO odoo' 
