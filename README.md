# Blocipedia

Blocipedia is a Ruby on Rails application that allows users to create wikis and collaborate on other wikis. Users can pay to upgrade their membership, allowing them to view and create private wikis.

The app is deployed on Heroku: https://blocipedia-c9.herokuapp.com/

The source code is here on GitHub: https://github.com/tmoolmuang/blocipedia

This app was created as part of the [Bloc](www.bloc.io) Web Developer Track.

# Features

+ Users can create a standard account in order to create, edit, and collaborate on public wikis using Markdown syntax. Anyone can view public wikis.
+ Users can pay to upgrade their account to Premium in order to view and create private wikis.
+ Premium users can allow others to view and collaborate on the private wikis they create.
+ Premium users can downgrade their account back to Standard.
+ When a user downgrades his or her account, his or her private wikis will automatically become public.

# Setup and Configuration

**Languages and Frameworks**: Ruby on Rails and Bootstrap

**Ruby version 2.3.0**

**Rails version 4.2.5**

**Databases**: SQLite (Test, Development), PostgreSQL (Production)

**Development Tools and Gems include**:

+ Devise for user authentication
+ Pundit for authorization
+ Redcarpet for Markdown formatting
+ Stripe for payments

**Setup:**

+ Environment variables were set using Figaro and are stored in config/application.yml (ignored by git).

+ The config/application.example.yml file illustrates how environment variables should be stored.

**To run Blocipedia locally:**

+ Clone the repository
+ Run bundle install
+ Create and migrate the SQLite database with `rake db:create` and `rake db:migrate`
+ Start the server using `rails server`
+ Run the app on `localhost:3000`

**Business Rules:**

+ Unregistered Users <br>
Also considered as guest. A guest is not required to sign up. Unregistered users have access to all public wikis.
But do not have authorization to create or update wikis.
 
+ Registered Users <br>
Also considered as standard user. A standard user is required to sign-up and register with the site. 
All standard users are allowed to update and create public wikis. 

+ Premium Users <br>
A standard user can upgrade to premium level with a small amount of fee. Premium user can create private wikis
which can be viewd by all other premium members. Premium level also gives user a right to edit public and private wikis.
Premium member can change a public wiki to a private wiki. Premium membership can be forfeited anytime by downgrading.
Once membership is downgraded to standard level, all the private wikis that has been created by the user
will become public wikis. <br><br>
 
Any private wikis can be assigned with collaborators by a premium user. Once a user has been assigned as a collaborator 
he or she can edit that particular wiki.

+ Admin Users <br>
An admin user has access to all wikis. Admin can edit and delete any wikis.