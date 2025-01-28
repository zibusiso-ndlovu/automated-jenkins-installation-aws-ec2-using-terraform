#!/bin/bash

# Update and upgrade system packages
sudo apt-get update -y
sudo apt-get upgrade -y

# Install Java (required for Jenkins)
#sudo apt-get install -y openjdk-17-jdk
sudo apt install openjdk-21-jdk -y

# Add Jenkins repository key and source list
#curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
#echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
# Update package index with Jenkins repository
sudo apt-get update -y

# Install Jenkins
sudo apt-get install -y jenkins

# Start Jenkins and enable it to start at boot
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Allow Jenkins on default port 8080 and OpenSSH through firewall
sudo apt-get install -y ufw
sudo ufw allow 8080
sudo ufw allow OpenSSH
sudo ufw --force enable

# Wait for Jenkins to initialize
echo "Waiting for Jenkins to start and generate admin password..."
sleep 10

# Display Jenkins initial admin password
if [ -f /var/lib/jenkins/secrets/initialAdminPassword ]; then
    echo "Jenkins is successfully installed. Here is the initial admin password:"
    sudo cat /var/lib/jenkins/secrets/initialAdminPassword
else
    echo "Failed to locate the initial admin password. Please check the Jenkins service."
fi
