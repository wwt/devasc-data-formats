# Dockerfile for WWT - Cisco DevNet DEVASC Data Formats Study Resources

FROM python:3.9-slim-buster

LABEL maintainer="Tim Hull <tim.hull@wwt.com>"

WORKDIR /app

# TCP 8888 for Jupyter Lab Server
EXPOSE 8888/tcp

# Update repositories and install Git
RUN apt-get update && \
    apt-get install -y git

# Copy requirements files to Image
COPY requirements/ requirements/

# Install Python packages and Ansible Collections
RUN python -m pip install --upgrade pip && \
    python -m pip install -r requirements/requirements.txt

# Run script to launch server services
ENTRYPOINT [ "./requirements/server-launch.sh" ]

CMD [ "/bin/bash" ]
