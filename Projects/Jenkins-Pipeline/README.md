This projects includes:

Deploying an ec2 instance, install Jenkins in the instance, configure Docker cagent adn containers, set up cicd, deploy applications to k8s.

Run the below commands to install Java and Jenkins:

Install Java
'''
    sudo apt update
    sudo apt install openjdk-17-jre
'''

Verify Java is Installed
'''
    java -version
'''

Now, you can proceed with installing Jenkins

'''
    curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update
    sudo apt-get install jenkins
'''

Install jenkins

Install Docker:
'''
    sudo apt install docker.io
'''

Grant Jenkins user and Ubuntu user permission to docker deamon.
'''
    sudo su - 
'''

Give jenkins and ubuntu user permission for docker deamon.
'''
    usermod -aG docker jenkins
    usermod -aG docker ubuntu
    systemctl restart docker
'''

Once you are done with the above steps, it is better to restart Jenkins.
'''
    http://<ec2-instance-public-ip>:8080/restart
'''

Install docker pipeline plugin in jenkins.

