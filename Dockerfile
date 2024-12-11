# Use the official Jenkins LTS image as the base image
FROM jenkins/jenkins:lts

# Switch to root user
USER root

# Install Docker CLI inside the Jenkins container
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Add the Jenkins user to the Docker group
RUN groupadd -g 999 docker && \
    usermod -aG docker jenkins

# Set environment variables for Jenkins
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Install suggested Jenkins plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

# Expose Jenkins port and the slave agent port
EXPOSE 8080 50000

# Set up initial admin user (optional, recommended for automation)
COPY admin_user.groovy /usr/share/jenkins/ref/init.groovy.d/admin_user.groovy

