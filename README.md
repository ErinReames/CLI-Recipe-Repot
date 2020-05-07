# Recipe Repot

## Description:

The Recipe Repot is a recipe repository where a user will be able to create a recipe, add a recipe to their profile, as well as use a rating system. This repository provides methods of filtering the database by rating and by diet. Users can also adjust their recipe rating, or delete it all together. The user's profile will track not only their recipes, but the recipe's overall rating at that time. This repo uses the API <a href="http://www.recipepuppy.com/about/api/">RecipePuppy</a> in order to seed the recipe name and ingredients of the database, while the description and initial users are generated using the <a href="https://rubygems.org/gems/faker/versions/1.6.6">Faker</a> gem. The initial average rating of a recipe is then gathered from that data. Recipe Repot will store the user data on their local machine and the user can re-enter their profile using their profile name to return to their recipes and ratings. 

## How to run:

	1.	Clone down this project from Github
	2.	Open your terminal and change directories to the corresponding file
	3.	To install required gems and to seed the database, in your terminal, run “bundle install” and “rake db:reset”
	4.	To run the application, in your terminal, type “ruby bin/run.rb"
	5.	Follow the prompts!

## How to run as a collaborator:

	1.	Clone down this project from Github
	2.	Open your terminal and change directories to the corresponding file
	3.	To install required gems and to seed the database, in your terminal, run “bundle install” and “rake db:reset”
	4.	Request access from the admin
	5.	Create a branch
	6.	Adjust the code to your liking
	7.	Submit a pull request
	8.	If approved, collaborator will be able to push

## Licensing:

### Learn.co Educational Content License

##### Copyright (c) 2015 Flatiron School, Inc

##### The Flatiron School, Inc. owns this Educational Content. However, the Flatiron School supports the development and availability of educational materials in the public domain. Therefore, the Flatiron School grants Users of the Flatiron Educational Content set forth in this repository certain rights to reuse, build upon and share such Educational Content subject to the terms of the Educational Content License set forth [here](http://learn.co/content-license) (http://learn.co/content-license). You must read carefully the terms and conditions contained in the Educational Content License as such terms govern access to and use of the Educational Content.

##### Flatiron School is willing to allow you access to and use of the Educational Content only on the condition that you accept all of the terms and conditions contained in the Educational Content License set forth [here](http://learn.co/content-license) (http://learn.co/content-license). By accessing and/or using the Educational Content, you are agreeing to all of the terms and conditions contained in the Educational Content License. If you do not agree to any or all of the terms of the Educational Content License, you are prohibited from accessing, reviewing or using in any way the Educational Content.


