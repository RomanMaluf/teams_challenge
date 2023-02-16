# README

This is a `Rails` project bootstrapped with `rails new teams_challenge -d postgresql -T`

## GETTING STARTED
-----
### Installation hybrid schema
-----
>using docker for the database and install rails locally

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

 ```
#### Docker
  Simply run ``` docker-compose up postgres ```