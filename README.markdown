#Opsicle, an OpsWorks CLI
A gem bringing the glory of OpsWorks to your command line.

[![Gem Version](https://badge.fury.io/rb/opsicle.png)](http://badge.fury.io/rb/opsicle)
[![Build Status](https://travis-ci.org/sportngin/opsicle.png?branch=master)](https://travis-ci.org/sportngin/opsicle)

##Deployment Commands

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

##Set up an Application to use opsicle

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


