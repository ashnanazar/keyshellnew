#!/bin/bash

echo "Branch: ${GIT_BRANCH}"

echo "Installing Dependencies..."
npm install || exit 1

echo "Building applications..."
ng build --base-href / || exit 1

echo "Droping old apps from EC2"
ssh root@34.100.246.173 'rm -rvf /var/www/html/*'

echo "Deploying application on EC2..."
rsync -avzP dist/keyshell/* root@34.100.246.173:/var/www/html/

if [ $? -eq 0 ]; then
    echo "Deployed the apps successfully"
fi
