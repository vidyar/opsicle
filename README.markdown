#Opsicle, an OpsWorks CLI
A gem bringing the glory of OpsWorks to your command line.

[![Build Status](https://travis-ci.org/sportngin/opsicle.png?branch=master)](https://travis-ci.org/sportngin/opsicle)

##Deployment Commands

```bash
# Run a basic deploy for the current app
opsicle deploy staging

# Run the deploy for production
opsicle deploy production

```

```bash
# Run other opsworks commands
opsicle update_custom_cookbooks staging

# Trigger the setup event
opsicle setup staging
````

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


