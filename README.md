# Infrastructure for Master of Cloud

```
   _____                   __                         _____  _________ .__                   .___
  /     \ _____    _______/  |_  ___________    _____/ ____\ \_   ___ \|  |   ____  __ __  __| _/
 /  \ /  \\__  \  /  ___/\   __\/ __ \_  __ \  /  _ \   __\  /    \  \/|  |  /  _ \|  |  \/ __ | 
/    Y    \/ __ \_\___ \  |  | \  ___/|  | \/ (  <_> )  |    \     \___|  |_(  <_> )  |  / /_/ | 
\____|__  (____  /____  > |__|  \___  >__|     \____/|__|     \______  /____/\____/|____/\____ | 
        \/     \/     \/            \/                               \/                       \/ 
```

## Prerequisites

- Execute the following commands:
```
mv .env.private.sample .env.private
mv Gemfile.sample Gemfile
mv Gemfile.lock.sample Gemfile.lock
```
- Edit .env.private and configure your AWS credentials, or export your AWS credentials.
- Modify config.yaml and change 'mysubdomain.masterofcloud.com' to 'yourname.masterofcloud.com'
- Type `./rake_init.sh` to create the DependencyStack in your AWS account

## Helper scripts

- `rake_init.sh` - Create the DependencyStack for this environment
- `rake.sh` - Compile code and run unit tests
- `rake_dependencies.sh` - Write dependencies to .env.dependencies.environment
- `rake_compile.sh` Compile code
- `rake_spec.sh` - Run unit tests
- `rake_upload.sh` - Upload the CloudFormation artifacts
- `rake_apply.sh` - Deploy code

## Rake commands

- `rake` - Retrieve required outputs from DependencyStack, Compile the code into CloudFormation templates and run unit tests
- `rake init` - Deploy the DependencyStack in the AWS account
- `rake compile` - Compile the code into CloudFormation templates
- `rake spec` - Run unit tests
- `rake upload` - Upload the CloudFormation templates to s3
- `rake update` - Save required outputs from DependencyStack to .env.dependencies.<ENVIRONMENT>
- `rake apply` - Deploy the CloudFormation templates

## Stack configuration

The `config.yaml` file in the root directory of this project contains most of the configuration.  It contains the networking configuration for each environment, subnet configuration, DNS and ECS (Docker) containers that are deployed.

