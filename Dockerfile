FROM ubuntu:22.04
# updating system
RUN apt-get update && apt-get upgrade -y

# installing necessary apps
RUN apt install -y python3-psycopg2
RUN apt install -y python3-pip
RUN apt install -y wget
RUN apt install -y unzip
RUN apt install -y xvfb 

ARG USERNAME=parrot
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME 

USER ${USERNAME}

# installing robotframework and libraries
RUN pip3 install robotframework
RUN pip3 install robotframework-seleniumLibrary
RUN pip3 install robotframework-databaseLibrary
RUN pip3 install robotframework-requests
RUN pip3 install robotframework-sikuliLibrary
RUN pip3 install robotframework-rpa

# installing mitmproxy
RUN pip3 install mitmproxy

USER root

# downloading google chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# installing chrome
RUN apt install -y ./google-chrome-stable_current_amd64.deb

# removing google-chrome installer
RUN rm google-chrome-stable_current_amd64.deb -R

# dowloading and extracting drivers
RUN wget https://chromedriver.storage.googleapis.com/103.0.5060.24/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip -d /home/parrot

# moving drivers to global dir
RUN mv /home/parrot/chromedriver /usr/local/bin

# removing donwloaded files
RUN rm chromedriver_linux64.zip

CMD export PATH=/home/parrot/.local/bin:$PATH \
    && ln -s ~/.local/bin/robot /usr/bin/robot 

WORKDIR /home/${USERNAME}