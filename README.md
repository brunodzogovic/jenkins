# Jenkins CI/CD
Dockerfile that builds a custom Jenkins image that executes Docker runtime inside the container for running on various host OS distros. There's an admin user preconfigured (see `admin_user.groovy` file). The backend runs on port 8080, accessible from the browser.

The Dockerfile pulls the original Jenkins image from the official repository and uses the Docker runtime from the host.

There is an option to configure and run a Jenkins project before the environment is built. You can customize the ``jenkins.yml`` file for that purpose to fit your environment. 

You can customize the plugins that Docker should provision in Jenkins during the build stage, in the ``plugins.txt`` file.


