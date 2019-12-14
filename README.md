# README

<img src="https://ci.appveyor.com/api/projects/status/github/kusumandaru/rails-queue?branch=master&svg=true">

Rails Queue Example

* Ruby version
ruby 2.5.0
rails 5.2.3

* System dependencies
rabbitmq 3.7

* Configuration


* Database creation
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




