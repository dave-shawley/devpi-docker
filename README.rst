Dockerfile for Dev-PI
=====================
This "works" in docker-compose.  Use it by:

1. setting up a data volume for each component somewhere
2. starting up a master by setting the ``DEVPI_ROLE`` environment
   variable to ``master``
3. start up one or more replicas by setting ``DEVPI_ROLE=replica``
   and ``DEVPI_MASTER_URL`` environment variables

Point your ``index-url`` to either the master or one of the replicas.

Example docker-compose.yml
--------------------------
.. code-block:: yaml

   version: '2'

   services:
     devpi-master:
       build: devpi
       environment:
         DEVPI_ROLE: master
       ports:
         - 3141
       volumes:
         - ./data/master:/opt/devpi

     devpi-mirror:
       build: devpi
       environment:
         DEVPI_ROLE: replica
         DEVPI_MASTER_URL: http://devpi-master:3141/
       ports:
         - 3141
       volumes:
         - ./data/mirror-one:/opt/devpi
