### Develop odoo ERP using a docker container

Allows you to run odoo from source without installing any of the dependencies
(except Docker and Docker-compose). 

*odoo_10_dev/* contains the files needed to build the docker image (you
don't need to do that, its on dockerhub.com/petrbarborka and the compose
script will find it.

*odoo_10_dev_compose/* is the real meat - spins up one container for docker 10
( from sources cloned from github into sources/ ) and another for postgresql
database. Both the data for the db and odoo instance are persisted in Docker
named volumes. That means that you don't have direct access to them from
your filesystem (ownership reasons), but you can always ssh into the container
(see mgmt_scripts/) 

You have to clone the sources yourself (you can use the script in
mgmt_scripts/).

*odoo_10_dev_compose/mgmt_scripts* also contains scripts to install docker
and docker-compose on ubuntu should you need that.


TO RUN CLEAN:
( docker compose down -v to kill all incl volumes )
1) do sudo docker-compose up
2) do it once again once db is up
3) change db owner ( mgmt scripts )

TO DEBUG:
import wdb; wdb.set_trace(); -> localhost:1984
=======
