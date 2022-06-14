FROM ubuntu:22.04
# updating system
RUN apt-get update
RUN apt-get upgrade -y

# installing necessary apps
RUN apt install -y python3-psycopg2
RUN apt install -y python3-pip
RUN apt install -y wget

# installing robotframework and libraries
RUN pip3 install robotframework
RUN pip3 install robotframework-seleniumLibrary
RUN pip3 install robotframework-databaseLibrary
RUN pip3 install robotframework-requests
RUN pip3 install robotframework-sikuliLibrary
RUN pip3 install robotframework-rpa

# installing mitmproxy
RUN pip3 install mitmproxy

#installing firefox
RUN apt install -y firefox

# downloading google chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# installing chrome
RUN apt install -y ./google-chrome-stable_current_amd64.deb

# removing google-chrome installer
RUN rm google-chrome-stable_current_amd64.deb -R

# creatig user for running tests
RUN adduser --disabled-password --gecos '' parrot
RUN ls -Al /home/harrier
