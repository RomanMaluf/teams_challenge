# README

[![Maintainability](https://api.codeclimate.com/v1/badges/1febadae2b4eba346abb/maintainability)](https://codeclimate.com/github/RomanMaluf/teams_challenge/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/1febadae2b4eba346abb/test_coverage)](https://codeclimate.com/github/RomanMaluf/teams_challenge/test_coverage)

This is a `Rails` project bootstrapped with `rails new teams_challenge -d postgresql -T`

Deployed at https://teams-challenge.onrender.com/

Access: email: admin@arkusnexus.com , password: arkusnexus

## GETTING STARTED
-----
### Installation hybrid schema
-----
>using docker for the database and install rails locally

> Personal Option: This is the best options, because render views with rails inside docker its a very slow process.
So with the hybrid schema you could speed up your developments
#### Rails
 From [`rvm`](https://rvm.io/) documentation
 ```bash
  # First install RVM
  gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
  \curl -sSL https://get.rvm.io | bash -s stable
  # Second install Ruby 3.2.0
  rvm install 3.2.0
  # Third install rails gem and all the dependencies
  gem install rails 7.0.4.2
  # 4. After docker-compose up
  rails db:create && rails db:migrate
  # Seed you can pass two arguments to seed user count and admin user password
  # The admin user email is admin@arkusnexus.com
  # For Example
  ADMIN_PASSWORD=arkusnexus USERS_COUNT=75 rails db:seed
 ```
#### Docker
  Simply run ``` docker-compose up postgres```

### Swagger
  To access swagger-ui
  Run ``` docker-compose up swagger```, and go to localhost/swagger