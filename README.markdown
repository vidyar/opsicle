Opsworks CLI - opsicle
---------------------

Deployment Commands
--------------
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

Setup and Application to use opsicle
-------
```yaml
# your_app_root/.opsicle

staging:
  stack_id: opsworks-stack-id
production:
  stack_id: opsworks-stack-id
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


