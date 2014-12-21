Install
=======

### Ubuntu 14.04

1. You have new server and SSH .pem key. SSH to it with root access
```
ssh -i any.pem user@serveripaddress
````

2. Create new user [(ref)][capistrano:auth]
  * `adduser deploy` - set some random password here if required and remember it, might be useful
  * `passwd -l deploy`
  * use `sudo su - deploy` to login as user

3. Add your dev SSH key to authorized_keys (do as **deploy** user)
```
cd ~
mkdir .ssh
chmod 700 .ssh
cd .ssh
vi authorized_keys # paste you key
chmod 600 authorized_keys 
```

3. Install nginx [(ref)][nginx:install]
  * `sudo apt-get install nginx`
  * Check your Web Server. In Ubuntu 14.04, by default, Nginx automatically starts when it is installed. You can access the default Nginx landing page to confirm that the software is running properly by visiting your server's domain name or public IP address in your web browser.

4. Install PostgreSQL [(ref)][postgres:install]
  * `sudo apt-get install postgresql postgresql-contrib libpq-dev`
  * `sudo -i -u postgres` - login as a postgres user
  * `createuser --interactive` - create a new user  called `trendy-application` (not superuser, can't create a new db, can't create new users)
  * `createdb createdb trendy-reggae-production` - create database
  * `psql` - run postgres cmd
    * `GRANT ALL PRIVILEGES ON DATABASE "trendy-reggae-production" to "trendy-application"`
    * `ALTER USER "trendy-application" WITH PASSWORD 'PCE66w5cD87UnbS';`

5. Install RVM (do as **deploy** user)
```
sudo apt-get install curl
\curl -L https://get.rvm.io | bash -s -- --autolibs=read-fail
# it may ask to install gpg keys, copy and run the command
source ~/.rvm/scripts/rvm
rvm reload
rvm requirements # manually install these, as root
rvm install 2.1.5
```
6. Configure project directory
```
# server (as root)
cd /var
sudo mkdir www
cd www
sudo mkdir trendy-reggae-production
sudo chown deploy:deploy trendy-reggae-production
sudo chmod g+s trendy-reggae-production
sudo chmod go-w trendy-reggae-production
sudo mkdir trendy-reggae-production/{releases,shared}
sudo chown deploy trendy-reggae-production/{releases,shared}
# server (as deploy)
ch /var/www/expert-social-network-production
mkdir current
mkdir shared/tmp
mkdir shared/config
```

7. Set up capistrano (PROFIT) and deploy app **NOT COMPLETE**

8. Install some things, **nodejs** - as JS runtime
```
sudo apt-get install git nodejs
```
9. Follow [this to configure nginx](https://bitbucket.org/ikantam/trendy-reggae/wiki/nginx%20virtualhost%20configuration)

10. Start unicorn
  * `cd /var/www/trendy-reggae-production/current`
  * `bin/unicorn start`


[nginx:install]: https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-14-04-lts
[capistrano:auth]: http://capistranorb.com/documentation/getting-started/authentication-and-authorisation/
[postgres:install]: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-14-04