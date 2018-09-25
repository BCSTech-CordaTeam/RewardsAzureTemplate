#!/bin/sh

### Get command line options
POSTGRES_URL=$1
POSTGRES_PORT=$2
POSTGRES_DBNAME=$3
POSTGRES_LOGIN=$4
POSTGRES_PASS=$5
PASS=$6 # Not supplied by user
USER=$7

FILE="rewards-0.0.3-DEV"

# Get current path of this script for later.
# Source: https://stackoverflow.com/questions/630372/determine-the-path-of-the-executing-bash-script
MY_PATH="`dirname \"$0\"`"              # relative
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"  # absolutized and normalized
if [ -z "$MY_PATH" ] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi

### Download/Install dependencies
apt-get update -y
# Java
apt-get install default-jre -y
# 7zip
apt-get install p7zip-full -y

### Move to a nice location
mkdir /home/$USER/rewards # && cd "$_"
cd /home/$USER/rewards

### Download the jar
wget https://github.com/BCSTech-CordaTeam/RewardsAzure/blob/master/$FILE.7z?raw=true
mv $FILE.7z?raw=true $FILE.7z

### Extract it
# password:
7z x $FILE.7z -p$PASS

### Generate the application.properties file
mkdir ./WEB-INF/classes -p

echo "
spring.jpa.hibernate.ddl-auto=update
spring.jpa.hibernate.generate-ddl=true
spring.datasource.initialization-mode=always
spring.batch.initialize-schema=always
spring.datasource.platform=postgres
spring.jpa.properties.hibernate.temp.use_jdbc_metadata_defaults = false
spring.jpa.database-platform=org.hibernate.dialect.PostgreSQL9Dialect
spring.jpa.properties.hibernate.jdbc.time_zone = UTC
logging.file=framework.log
logging.level.org.springframework.web=ERROR
logging.level.com.framework.rewards=DEBUG
logging.pattern.console= "%d{yyyy-MM-dd HH:mm:ss} - %msg%n"
logging.pattern.file= "%d{yyyy-MM-dd HH:mm:ss} [%thread] %-5level %logger{36} - %msg%n"
spring.datasource.url= jdbc:postgresql://$POSTGRES_URL:$POSTGRES_PORT/$POSTGRES_DBNAME?&sslmode=require
spring.database.driverClassName=org.postgresql.Driver
spring.jpa.properties.hibernate.default_schema=public
spring.datasource.username=$POSTGRES_LOGIN
spring.datasource.password=$POSTGRES_PASS" > ./WEB-INF/classes/application.properties
# user=$POSTGRES_LOGIN&password=$POSTGRES_PASS

### Move application.properties into the WAR
7z u $FILE.war ./WEB-INF

### Cleanup
rm WEB-INF -r -f
rm $FILE.7z

### Generate systemd thingy
echo "
[Unit]
Description=Rewards APIs
Requires=network.target

[Service]
Type=simple
User=$USER
WorkingDirectory=/home/$USER/rewards
ExecStart=/usr/bin/java -server -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:InitialRAMFraction=2 -XX:MinRAMFraction=2 -XX:MaxRAMFraction=2 -XX:+UseG1GC -XX:MaxGCPauseMillis=100 -XX:+UseStringDeduplication -jar /home/$USER/rewards/$FILE.war
Restart=on-failure

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/rewards.service

### Start the service
systemctl enable rewards.service
systemctl start rewards.service

### Generate readme
echo "
The rewards framework is running through a systemd service and will automatically restart upon vm shutdown. " > README.md
# # Give permission to run
# chown $USER:$USER ./start.sh
# chown $USER:$USER ./$FILE.war
# chmod 770 ./start.sh
# chmod 770 ./$FILE.war

### Run the jar
# sudo nohup ./start.sh & 

### Self destruct
rm $MY_PATH/${0##*/}

