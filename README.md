# Lunch Meet WebApplication

  - User can create a Group and inivite friend to join thier group.
  - They can make a vote for where they wanna go for dinning.
  - Base on group members's preferences, System will give a list of resturant near by their group.
  - Group members will vote for restarants.
  - All restaurants are taken from Yelp API.

## Live API:
You can found the live code at:
```sh
https://happy-lunch-meet.herokuapp.com/
```

Admin site:
```sh
https://happy-lunch-meet.herokuapp.com/admin
```

## Tech
* Web server: Ruby on Rails
* Database: Postgresql
* Front-end: Slim, Javascript, Jquery, Bootstrap
* Other: Yelp API, Amazon S3, Google geocoder


## Installation

- Unzip the code.
- Open terminal and change to code base directory
- Run `bundle install` to install all the dependencies. You may need update new `rails` or `ruby` versions
- Then run `rails server` to start local server
- Open web browser and visit `localhost:3000`
