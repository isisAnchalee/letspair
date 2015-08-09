# Letspair? Mavenly? Savantly? We'll see.

This is a platform to connect freelance tech consultants / independent contractors and businesses.

## Set up

[Download](http://www.postgresql.org/download/), install, and run postgres app

Go to project directory and run `rake db:create db:migrate`

Start a server locally `rails s`

To view the app go to [http://localhost.com:3000](http://localhost.com:3000)

## Internal Data Structures

### Users

Everyone who uses the platform is a User model.
The user model has [devise auth](https://github.com/plataformatec/devise) attributes along with attributes for a users name,
`email`, and a flag `is_company` denoting a company looking for consultants.
There is also an admin flag.

#### Identity

This platform uses omni auth, and supports logging in through email, Facebook, or LinkedIn.
The `Identity` model allows a single user to log in via email, Facebook, or LinkedIn
by keeping track of the `uid` and `provider` returned by omniauth. The `Identity` model also has a `user_id` model
to keep track of which user it belongs to, and a user `has_many` identities.


###There are two different types of profiles for Users. There is a `User Profile` model, and a `Company Profile`:


The User Profile has a `short_tag_line` to describe the user, a longer `description`, and a space for `work_history`.
In the future, there will be attachments to show previous work and a resume.

The `Company Profile` simply has a `name`, `description`, and `location`.

###Projects, Bids, and Reviews

Users (mainly companies) have many `Projects`. Projects require a `title`, `description`, `time_line`, and optionally a `price`.
Projects are the work that consultants are hired to perform.

Users may `Bid` on a project. A bid requires the `Price` a consultant will charge,
and also `content` to clarify details and negotiate terms of the project/job.

The `Review` model is for both consultant and company users. After the completion of a project,
the consultant and company must complete a review of each other.
Currently, reviews only have a `title`, `body`, and a `rating`.

### Tags

`Tag` models can belong to Users or Projects through the `Taggings` join table. A Tag has a `name` and a `taggings_count`.
Tags are very important for finding appropriate consultants, or for finding appropriate projects.
The `name` is searchable, and the `taggings_count` will show which tags are popular, and therefore help Users choose better tags.

### Follows

A user may follow another user or project through the `Follows` join table.
There is a followable concern included in `Users` and `Projects`.

![](/models.png)
