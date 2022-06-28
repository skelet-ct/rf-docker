FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive

# Updating system
RUN apt-get update && apt-get upgrade -y

# Installing essential packages
RUN apt install -y python3-psycopg2 \
	openconnect \
	python3-dev \
	python3-pip \
	python3-venv \
	wget \
	unzip \
	xvfb \
	iputils-ping \
	nano \
	zip 

# Create the user
ENV user=parrot
ARG USERNAME=${user}
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME}

ENV	PATH=/home/${user}/.local/bin:/root/.local/bin:$PATH
WORKDIR /home/${user}

# installing robotframework and libraries
RUN pip3 install robotframework \
	robotframework-seleniumLibrary \
	robotframework-databaseLibrary \
	robotframework-requests \
	robotframework-rpa \
	robocorp-dialog \
	robotframework-assertion-engine \
	robotframework-browser \
	robotframework-pythonlibcore \
	robotframework-seleniumtestability \
	psycopg2-binary
	
RUN pip3 install pipx

# installing mitmproxy
RUN pipx install mitmproxy

# downloading google chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# installing chrome
RUN apt install -y ./google-chrome-stable_current_amd64.deb

# removing google-chrome installer
RUN rm google-chrome-stable_current_amd64.deb -R

# dowloading and extracting drivers
RUN wget https://chromedriver.storage.googleapis.com/102.0.5005.61/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip -d /home/${user}

# moving drivers to global dir
RUN mv /home/${user}/chromedriver /usr/local/bin

# removing donwloaded files
RUN rm chromedriver_linux64.zip

# adding testaces
ADD robot.zip /home/${user}
RUN unzip	robot.zip
RUN rm /home/${user}/robot.zip

# adding starting srcript
ADD start.sh	/home/${user}/start.sh	

# making file executable and changing permissions
RUN chmod +x /home/${user}/start.sh -c
RUN chmod 777 /home/${user}/preprod_tests -R
