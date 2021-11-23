# Directory contain the following
#
#
# Description                     |  path 
###################################################
#                                 |
# 1.Application Rampi             |   files/rampi.py
#                                 |
#                                 |
#                                 |
# 2. Compilation script will      |
# create the docker run unitest   |   ./_compile.sh
# and upload to docker hub        |
#                                 |
#                                 |
# 3. k8s deployment yaml +        |   ./k8s
#        service yaml             |
#                                 |
#                                 |
# 4. helm chart                   |   ./helm
#                                 |
##################################################

Install methods:

a. docker version
   --------------
   run the following command
   on 1st termina execute:
   docker run -p 5000:5000 -ti docker.io/judab/my-docker-example:211115-14.32

   on 2nd terminal execute:
   curl localhost:5000/ram


b. on kubernetes:
   --------------
   cd k8s/yaml
   kubectl apply -f deploy.yaml
   kubectl apply -f svc.yaml



c. kubernetes helm chart
   cd helm
   helm install rampai1 ./ramapi


output example:
curl x.x.x.x:30879/ram
[
  {
    "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
    "location": "Citadel of Ricks",
    "name": "Rick Sanchez"
  },
  {
    "image": "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
    "location": "Citadel of Ricks",
    "name": "Morty Smith"
  },
  {
    "image": "https://rickandmortyapi.com/api/character/avatar/3.jpeg",
    "location": "Earth (Replacement Dimension)",
    "name": "Summer Smith"
  },
  {
    "image": "https://rickandmortyapi.com/api/character/avatar/4.jpeg",
    "location": "Earth (Replacement Dimension)",


d.
