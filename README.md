# README

React on Rails app that allows the user to upload and compare CSV files with a predefined structure (Headers: Account Email, YouTube Channel, Subscriber Count).

The Account Email addresses are returned for all rows containing a discrepancy.

* Ruby version - 2.6.2

* Rails - 6.1.0


# To Run App
Clone -> Yarn -> Bundle -> Rails S
```
$ git clone git@github.com:MamboMaya/csv-compare.git
$ yarn install
$ bundle install
$ rails s
```

# To Run Tests
```
$ rspec
```

# TODO
1. Refactor api with a Value Object design pattern in mind.
