FROM ubuntu:22.04

# Updating system
RUN apt-get update && apt-get upgrade -y

# Installiong essential packages
RUN apt install -y python3-psycopg2 \
	python3-pip \
	python3-venv \
	wget \
	unzip \
	xvfb 

# Create the user
ARG USERNAME=parrot
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME}

USER ${USERNAME}
WORKDIR /home/${USERNAME}

ENV	PATH=/home/parrot/.local/bin:${PATH}

# installing robotframework and libraries
RUN pip3 install robotframework \
	robotframework-seleniumLibrary \
	robotframework-databaseLibrary \
	robotframework-requests \
	robotframework-sikuliLibrary \
	robotframework-rpa 
	
RUN pip3 install pipx
	
# installing mitmproxy
RUN pipx install mitmproxy

USER root

# downloading google chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# installing chrome
RUN apt install -y ./google-chrome-stable_current_amd64.deb

# removing google-chrome installer
RUN rm google-chrome-stable_current_amd64.deb -R

# dowloading and extracting drivers
RUN wget https://chromedriver.storage.googleapis.com/102.0.5005.61/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip -d /home/parrot

# moving drivers to global dir
RUN mv /home/parrot/chromedriver /usr/local/bin

# removing donwloaded files
RUN rm chromedriver_linux64.zip
