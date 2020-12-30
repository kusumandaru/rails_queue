# README

<img src="https://ci.appveyor.com/api/projects/status/97w7dbr26x515i6p/branch/master?svg=true">

Rails Queue Example

* Ruby version
ruby >= 2.5.5
rails >= 5.2.4.3

* System dependencies
rabbitmq >= 3.7

* Configuration


* Database creation
cp .env.example .env
rails db:create

* Database initialization
rails db:migrate

* How to run the test suite
rspec spec/*

* Services (running consumer)
rake sneakers:run

example console:

publisher = UserPublisher.new([User.new(id: 1, last_name: 'me')]) 
publisher.publish




