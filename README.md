# rf-docker

dockerfile for robotframework test execution

***installed robotframework libraries:***

    - robotframework-seleniumLibrary
    - robotframework-databaseLibrary
    - robotframework-requests
    - robotframework-sikuliLibrary
    - robotframework-rpa
    - robocorp-dialog
	- robotframework-assertion-engine
	- robotframework-browser
	- robotframework-pythonlibcore
    - robotframework-seleniumtestability
	- psycopg2-binary
	

***other pip applications:***

    - mitmproxy

***db driver:***
    
    - psycopq2

***browsers:***
    
    - google-chrome

***required ENV varialles***
    - DB_NAME
    - DB_USER
    - DB_PASSWORD
    - DB_HOST
    - DB_PORT
    - CI_PROJECT_NAME
    - VPN_USER
    - VPN_PASS