#!/bin/bash

# Create app user
app_user=myapp
sudo useradd -m -s /bin/bash $app_user

# Fonction run_as_myapp
run_as_myapp() {
    sudo -u $app_user bash -c "$1"
}


# Install nodejs and npm
apt install -y nodejs npm

# Check NodeJS and NPM version
sleep 5
echo ""
echo -n "NodeJS version : "
nodejs --version
echo -n "NPM version : " 
npm --version

echo ""
sleep 5

# Download package
run_as_myapp "wget -O /home/$app_user/bootcamp-node-envvars-project-1.0.0.tgz https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz"

#Unzip package
run_as_myapp "tar xvf /home/$app_user/bootcamp-node-envvars-project-1.0.0.tgz -C /home/$app_user/"


# Set log directory
read -p "Choose absolute path for log directory (e.g. /var/log/) : " dir_log

if [ -d "$dir_log" ]
then
        echo "Directory already exists"
	sudo chown $app_user: -R $dir_log 
else
        run_as_myapp "mkdir $dir_log"
	echo "Directory has been created"
fi

echo ""

# Set env variable and start application with app user
run_as_myapp "
export APP_ENV=dev DB_USER=myuser DB_PWD=mysecret LOG_DIR=$dir_log
cd /home/$app_user/package/
npm install
node /home/$app_user/package/server.js &
"

# Check application running and listening port
echo "Running process : "
ps aux |egrep "server.js|USER" |grep -v grep
sleep 5
echo "Listening port : "
netstat -tulnp 2>/dev/null |egrep :"3000|Proto"

