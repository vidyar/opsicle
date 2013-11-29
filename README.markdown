Opsworks Deployer - deploppy
---------------------

de command
--------------
```bash
# Run a basic deploy for the current app
deploppy staging

# Run the deploy for production
deploppy production

```

```bash
# Run other opsworks commands
deploppy update_custom_cookbooks staging

# Trigger the setup event
deploppy setup staging
````

Setup and app to use deploppy
-------
```yaml
# deploppy.yml

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


