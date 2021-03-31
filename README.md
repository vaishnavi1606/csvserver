PART 1 Solution

1. Pull the required Images
   $ docker pull infracloudio/csvserver:latest
   $ docker pull prom/prometheus:v2.22.0

2. CLone the git repository
   $ git clone https://github.com/infracloudio/csvserver.git

3. Change the directory
   $ cd ~/csvserver/solution

4. Create gencsv.sh and copy the following content
#!/bin/bash
#rm inputFile

if [ -z "$@" ]
 then
    count=9
 else
    count=`expr $@ - 1`
fi

for i in $(seq 0 $count);
do
        echo "$i,$RANDOM" >> inputFile
done
chmod 664 inputFile

5. Assign execute permission to gencsv.sh and execute it
   $ chmod +x gencsv.sh
   $ /bin/bash gencsv.sh

6. Create the container from docker image
   $ docker run  -itd  -p 9393:9300 --env CSVSERVER_BORDER=Orange infracloudio/csvserver /bin/bash

7. Copy the inputFile from host to container
   $ docker cp inputFile <containerId>:/csvserver/inputdata

8. Access the shell of docker container
   $ docker exec -it <containerid> bash

9. execute the binary file which is inside docker container
   $ chmod +x /csvserver/csvserver
   $ ./csvserver

10. Download part-1-output
    - Exit the container. use the solution directory
    wget -O ./part-1-output http://localhost:9393/raw

11. Create logs file
    $ docker logs [container_id] >& part-1-logs

PART 2 Solution

1. Create Dockerfile of the following content

FROM infracloudio/csvserver
RUN touch /csvserver/inputdata
COPY inputFile /csvserver/inputdata
RUN chmod +x /csvserver/csvserver
RUN cd /csvserver
RUN ./csvserver
EXPOSE 9300
CMD /bin/bash

2. Create docker-compose.yml file of the following content
version: "3"
services:
  web:
    build: .
    ports:
     - "9393:9300"
    environment:
      CSVSERVER_BORDER: Orange

3. up the server using docker compose
   $ docker-compose up
   
PART 3 Solutions:

1. pull the prometheus image
2. create prometheus.yml file
3. add the content of docker-compose file.
4. execute the command docker-compose up


