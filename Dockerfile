FROM ubuntu:22.04
# updating system
RUN apt-get update && apt-get upgrade -y

# installing necessary apps
RUN apt install -y python3-psycopg2 \
    python3-pip \
    wget \
    unzip \
    xvfb 

# installing robotframework and libraries
RUN pip3 install robotframework \
    robotframework-seleniumLibrary \
    robotframework-databaseLibrary \
    robotframework-requests \ 
    robotframework-sikuliLibrary \ 
    robotframework-rpa

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

# dowloading and extracting drivers
RUN wget https://github.com/mozilla/geckodriver/releases/download/v0.31.0/geckodriver-v0.31.0-linux64.tar.gz
RUN wget https://chromedriver.storage.googleapis.com/103.0.5060.24/chromedriver_linux64.zip
RUN tar -xvf geckodriver-v0.31.0-linux64.tar.gz -C /home/parrot
RUN unzip chromedriver_linux64.zip -d /home/parrot

# moving drivers to global dir
RUN mv /home/parrot/geckodriver /usr/local/bin && mv /home/parrot/chromedriver /usr/local/bin

# removing donwloaded files
RUN rm geckodriver-v0.31.0-linux64.tar.gz && rm chromedriver_linux64.zip