# Jenkins
Dockerfile that builds a custom Jenkins image that executes Docker runtime inside the container for running on various host OS distros.

The Dockerfile pulls the original Jenkins image from the official repository and instills a Docker runtime separate from the host to avoid
re-using the docker.sock and avoid vulnerabilities.
