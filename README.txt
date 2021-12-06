# Directory contain the following
#
#
# Description                     |  path 
###################################################
#                                 |
# 1.Python Rick And Marty         |   files/rampi.py
#    webserver                    |
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


Compile:
Use compile script in order to pack the code into docker container

./_compile.sh
judab@judab-VirtualBox:~/git/x/my-code-example$ ./_compile.sh
[INFO]: Docker Build to judab/my-docker-example Pass sucessfully
ee57f1553dac8748337fc4cf66740216581a832f39f512b0167d841c7143eef0
MY RT: 0
[INFO]: Docker unitest  to judab/my-docker-example Pass sucessfully
[INFO]: Docker Push judab/my-docker-example:211206-10.58 Pass sucessfully

Once   the compilation pass sucessfully   the TAG will have date filed in it see ABOVE EXAMPLE  211206-10.58


Run methods:

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
