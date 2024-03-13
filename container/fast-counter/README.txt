
-
I use my gitHub account as well my own AzureDevOps account

the counter-service code reside with other code examples i maintained,  
is invoke within the repository i maintain my-code-example
it is python code which reset counter to zero and increase it on each post , 
while in get it will return the counter ,  the code itself is simple,   

note i changed the implmentation so http listen on port 8000   inside the container it listen on port 8000
but in the docker i mapped it properly so 80 mapped to 8000,

in term of Dockerfile i put all the source files in src directory , while the Dockerfile and azure-pipeline.yaml
are in the root


