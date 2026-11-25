## Commands used to diagnose the problem
sudo containerlab deploy -t topology/lab.clab.yml 
docker stop clab-first-lab-srl2
docker ps
docker exec -it clab-first-lab-srl2 sr_cli
containerlab inspect -t topology/lab.clab.yml 
docker ps -a --filter name=clab-first-lab-srl2
docker ps -a 
docker restart clab-first-lab-srl2
docker ps -a 
docker exec -it clab-first-lab-srl2 sr_cli

## How was it fixed
docker restart clab-first-lab-srl2 

## Why `docker ps` alone wouldn't show the stopped container (you need -a)
`docker ps` - will show only running coantainers. Add the `-a` option to see all existing containers.
