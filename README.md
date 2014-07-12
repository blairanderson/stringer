# Stingerails

[![Coverage Status](https://coveralls.io/repos/blairanderson/stringer/badge.png?branch=master)](https://coveralls.io/r/blairanderson/stringer?branch=master)
[![Build Status](https://travis-ci.org/blairanderson/stringer.svg?branch=master)](https://travis-ci.org/blairanderson/stringer)
[![Code Climate](https://codeclimate.com/github/blairanderson/stringer.png)](https://codeclimate.com/github/blairanderson/stringer)
[![Stories in Ready](https://badge.waffle.io/blairanderson/stringer.png?label=ready&title=Ready)](https://waffle.io/blairanderson/stringer)

## Getting Started


This repository comes equipped with a self-setup script:

__Make Sure PostGreSQL is running!__

    $ bundle install

    $ ./bin/setup

    $ rake db:migrate:reset db:seed

After setting up, you can run the application using [foreman](http://ddollar.github.io/foreman/):

    $ foreman start
    
## Note 
1) Capybara webkit requires QT in order to build and install the gem.  

If your bundle fails on Capybara webkit follow the instructions at 

https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit 

to install QT


2) You may need to generate a secret key using 
    
    $rake secret
    
Insert the generated key into the .env file

    SECRET_KEY_BASE= <your generated secret key>
    

Devise may also require a secret key and if you fail to set it you wil be 

prompted to do so when running the rails server for the first time.  

In your devise initializer (devise.rb): set the key generated as instructed by the error message

    config.secret_key = <secret key generated by devise upon running rails s>


## Guidelines

Use the following guides for getting things done, programming well, and
programming in style.

* [Protocol](http://github.com/thoughtbot/guides/blob/master/protocol)
* [Best Practices](http://github.com/thoughtbot/guides/blob/master/best-practices)
* [Style](http://github.com/thoughtbot/guides/blob/master/style)


# [TODOs](https://waffle.io/blairanderson/stringer)
