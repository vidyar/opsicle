#Opsicle, an OpsWorks CLI
A gem bringing the glory of OpsWorks to your command line.

[![Gem Version](https://badge.fury.io/rb/opsicle.png)](http://badge.fury.io/rb/opsicle)
[![Build Status](https://travis-ci.org/sportngin/opsicle.png?branch=master)](https://travis-ci.org/sportngin/opsicle)

## Installation
Add this line to your project's Gemfile:  
```ruby
gem 'opsicle'; gem 'curses' unless RUBY_VERSION < "2.1.0"
```

**Why the extra `curses` gem conditional?**  
Ruby's library to interface with [curses](http://en.wikipedia.org/wiki/Curses_(programming_library))
was [removed from stdlib in Ruby 2.1.0](https://bugs.ruby-lang.org/issues/8584).
[The new curses gem](https://github.com/ruby/curses) doesn't install properly at all on 1.9.3, so
in an effort to keep this gem friendly with all current Ruby versions we don't list it as a
dependency in Opsicle's gemspec, as Bundler would error when trying to `bundle install` in your
project. Someday either >=2.1.0 will be enforced or Opsicle may be changed to become a global gem
outside of bundled projects. 

### Set up an Application to use opsicle

```yaml
# your_app_root/.opsicle

staging:
  stack_id: opsworks-stack-id
  app_id: opsworks-app-id
production:
  stack_id: opsworks-stack-id
  app_id: opsworks-app-id
```

```yaml
# ~/.fog

staging:
  aws_access_key_id: YOUR_AWS_ACCESS_KEY
  aws_secret_access_key: YOUR_AWS_SECRET_ACCESS_KEY
production:
  aws_access_key_id: YOUR_AWS_ACCESS_KEY
  aws_secret_access_key: YOUR_AWS_SECRET_ACCESS_KEY
```

## Using Opsicle

Run `opsicle help` for a full list of commands and their uses.  
Some common commands:

```bash

# Run a basic deploy for the current app
opsicle deploy staging

# Run the deploy for production
opsicle deploy production

# SSH to a server instance in the given environment stack
opsicle ssh staging

# Set your user SSH key (PUBLIC KEY) for OpsWorks
opsicle ssh-key staging <key-file>

# Start the deployment monitor for the given environment stack
opsicle deployments staging

```

Opsicle accepts a `--verbose` flag to show additional information as commands are run.
