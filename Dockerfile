# Use the official Jenkins LTS image as the base image
FROM jenkins/jenkins:lts

# Switch to root user
USER root

# Install prerequisites
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker.io && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Check if the 'docker' group exists and add it if not, then add Jenkins to the group
RUN if ! getent group docker; then groupadd -g 999 docker; fi && \
    usermod -aG docker jenkins

# Set environment variables for Jenkins
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Install suggested Jenkins plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

# Copy the JCasC configuration file
COPY jenkins.yml /var/jenkins_home/casc_configs/jenkins.yml

# Set the environment variable for JCasC configuration path
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/casc_configs/jenkins.yml

# Expose Jenkins port and the slave agent port
EXPOSE 8080 50000

# Set up initial admin user (optional, recommended for automation)
COPY admin_user.groovy /usr/share/jenkins/ref/init.groovy.d/admin_user.groovy

