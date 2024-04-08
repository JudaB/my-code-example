FROM jenkins/jenkins:lts
USER jenkins
RUN jenkins-plugin-cli --plugins kubernetes workflow-aggregator git configuration-as-code blueocean docker-workflow amazon-ecs docker-plugin artifactory  kubernetes workflow-aggregator git configuration-as-code 
RUN jenkins-plugin-cli --plugins ant cloudbees-bitbucket-branch-source build-timeout nodejs pipeline-aws remote-file sonar
