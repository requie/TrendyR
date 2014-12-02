Trendy Reggae
=============

### Sofware Requirements
- Web-server: nginx ([how to configure](https://bitbucket.org/ikantam/trendy-reggae/wiki/nginx%20virtualhost%20configuration))
- Language: Ruby 2.1.5
- Database: PostgreSQL

### Environment configurations

* copy *config/database.sample.yml* to *config/database.yml* and set database connection settings for your local installation

* copy *config/secrets.sample.yml* to *config/secrets.yml* and set appropriate values for your local installation

### Database and seeds

* `bin/rake db:schema:load` instead of `bin/rake db:migrate` to initialize an empty database
* `bin/rake db:migrate` to apply migrations to database
* `bin/rake db:seed` to plant seeds

### Unicorn
* use `bin/unicorn start|restart|stop` to manage unicorn server state

### Workflow requirements
* when updating assets make sure to place all styles, images, fonts, etc under *vendor* directory
  * update *app/assets/stylesheets/paths.scss* if there are any paths updates in styles
* before sending a PR check how your code works in **production** environment
* use namespaces for controllers, views, routes, etc to split funcionality for diffrerent user roles on separate modules
* use `pundit` to define access rules throughout the application
* use `slim` to compose views
* use `foreigner` for adding and removing foreign key constraints on a database level
* use `draper` to move decorational methods out of models to separate classes
* use `rubocop`, `brakeman`, `rake jshint` to check your code for following style guides and vulnerabilities

### Git Flow

* working(develop) branch - `develop`, production branch - `master`
* using **rebase** instead of merge ([read more](https://github.com/edx/edx-platform/wiki/How-to-Rebase-a-Pull-Request))
* working in **forks**, sending **Pull Requests**, doing **Code Reviews**
* send PRs only to `develop` branch
  * try to squash all commits to one commit before sending a PR (read more)
* approximate git commands flow, but it may vary, you can achieve the same results with another methods/commands
    * suppose *origin* is your fork remote, and *upstream* is a remote of the original repo

```
// git flow example
git checkout develop
git pull upstream develop
git checkout -b mytask
// doing task
git checkout develop
git pull upstream develop
git checkout mytask
git rebase develop
// fixing conflicts
git push origin mytask
// sending PR
```

### Coding standarts

##### Conventions
* 1 tab = 2 spaces (the resulting indent must be in **spaces**) for all technologies (Ruby, JS, CSS, etc)
* [A community-driven Ruby coding style guide](https://github.com/bbatsov/ruby-style-guide)
* [A community-driven Ruby on Rails 4 style guide](https://github.com/bbatsov/rails-style-guide)
* [Code Conventions for the JavaScript Programming Language](http://javascript.crockford.com/code.html)
* [Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript)

##### Tools
* `rubocop` - check your Rails code for following coding standarts
* `brakeman` - check your Rails code for vulnerabilities
* `rake jshint` - checl your JavaScript code for following coding standarts and vulnerabilities
