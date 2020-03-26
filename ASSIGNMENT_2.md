# Infrastructure for Master of Cloud - Excercise 2

```
   _____                   __                         _____  _________ .__                   .___
  /     \ _____    _______/  |_  ___________    _____/ ____\ \_   ___ \|  |   ____  __ __  __| _/
 /  \ /  \\__  \  /  ___/\   __\/ __ \_  __ \  /  _ \   __\  /    \  \/|  |  /  _ \|  |  \/ __ | 
/    Y    \/ __ \_\___ \  |  | \  ___/|  | \/ (  <_> )  |    \     \___|  |_(  <_> )  |  / /_/ | 
\____|__  (____  /____  > |__|  \___  >__|     \____/|__|     \______  /____/\____/|____/\____ | 
        \/     \/     \/            \/                               \/                       \/ 
```

## Introduction

You have managed to deploy your very first stacks. It time to take a deep dive into the
root folder of this project, and set you off to create something new.

You have already learned about the 6 key scripts:

```
rake.sh                # Compile the code to CloudFormation templates and run unit tests
rake_apply.sh          # Deploy the CloudFormation templates to AWS
rake_compile.sh        # Compile the code to CloudFormation templates
rake_dependencies.sh   # Read the output of the Dependency Stack and write them to a local file
rake_init.sh           # Create or update the Dependency Stacki
rake_spec.sh           # Run unit tests
rake_upload.sh         # Upload the CloudFormation templates to an AWS S3 Bucket
```

These shell scripts actually mount your current working directory in Docker. The docker container
has all the required dependencies installed, and takes care of the compilation of your code. The
scripts exist to make live easier for you, so you won't have to install these dependencies
locally. The drawback of this approach is that some buffered output will only display when the
specific command is finished (For example: when you run the apply script). You do not necessarily
need to use Docker. If you want to set up a local dev environment check out https://shorturl.at/quB26

So the `./rake_init.sh` script creates a Dependency Stack and `./rake_dependencies` fetches the
result and stores it locally. This is a one-time step per environment so that all the other scripts
know where to upload files to and what the environment's domain name is, and how to reference them.
Basically, it is the bootstrapping mechanism of your environment. Completing the first assignment
assures you have succesfully bootstrapped your environment so we can move on to the cool stuff.

Here is a brief explanation of the other files in the root folder of the project:

```
.env                     # Main environment variable file
.env.acceptance          # Environment variables for the `acceptance` environment
.env.dependencies.rspec  # Mock Dependency Stack environment variables for the unit tests
.env.dependencies.test   # Dependency Stack environment variables for the `test` environment 
.env.private             # Private environment variables, could contains secrets
.env.rspec               # Mock environment variables for unit tests
.env.test                # Environment variables for the `test` environment
.gitignore               # List of files that should never be committed to git
.rubocop.yml             # Configuration file outlining code style rules
Gemfile                  # Dependencies of this project
Gemfile.lock             # Dependencies of this project, with version specification
README.md                # You're reading it right now!
Rakefile                 # Definition of "tasks" of this project. For example:
                         # the tasks 'apply', 'compile', 'dependencies', 'upload', etc.
                         # are defined in this file
config.yaml              # The main configuration file for this project
```

The `config.yaml` file is the most important one of the bunch. It contains the base configuration
of this project. It's where you configure your project's domain name, do networking configuration,
and define applications that are to be deployed. Have a look at the config file right now...
At the bottom you see a definition of 2 applications:

```
applications:
  hello-world:
    image: nginxdemos/hello
    container_port: 80
    priority: 2 # The priority must be a unique number
    min: 2
    max: 8
    mem: 128
    env:
      SOME_ENV_VAR: Exposed
      SOME_OTHER_VAR: desopxE
  hello-world2:
    image: tutum/hello-world
    container_port: 80
    priority: 3
    min: 2
    max: 8
    mem: 128
    env:
      SOME_ENV_VAR: Exposed
      SOME_OTHER_VAR: desopxE
```

An application in this context is a Docker container. The image refers to an image on Dockerhub.
The first application is a HelloWorld example running on nginx. The second application is a
HelloWorld example running on Apache. As you've probably noticed, these applications were not
deployed in the first assignment. The reason for this is because the cluster size has not yet
been defined.

To do so, we need to add it to the config.yaml file. For example, for the `production` environment,
the config section would look like this:

```
  production:
    cluster_size: "2"
    cluster_instance_type: t2.small
    vpc_cidr: 10.40.0.0/16
    stack_name: production-devops
```

This will start two EC2 instances that together will form the Docker container platform (ECS).
Whenever you deploy an application to the container platform, ECS will find an instance that has
enough capacity to run the Docker container on. In addition, the application will be placed
behind a load balancer, so that traffic gets equally distributed between the containers. Finally,
it will configure DNS and a CDN with an SSL certificate to act as a proxy in front of your
load balancer, so that your application has a nice looking and secure URL.

And speaking of URLs... you will need to configure the domain_name in your config.yaml to match
your first name and last name. For example:

```
domain_name: "dennisvink.masterofcloud.com"
```

The validity of the domain name is important, because we will create actual DNS records and
request real SSL certificates. Ensure you have bootstrapped your environment correctly in the
previous excercise. If you need to reconfigure your domain name, now is the time to do so.

## Assignment

- Inspect lib/stacks/ and lib/stacks/parent_stack/parent.rb and notice the missing stacks. Add them.

- run `ENVIRONMENT="development" ./rake_init.sh` to bootstrap the development environment 

- run `ENVIRONMENT="acceptance" ./rake_init.sh` to bootstrap the acceptance environment

- run `ENVIRONMENT="production" ./rake_init.sh` to bootstrap the production environment

- Find out the DNS servers of the production Hosted Zone created

- Provide these DNS servers to your tutor on Slack. He will make your Hosted Zone authoritive for your subdomain!

- DO NOT CONTINUE UNTIL YOU'VE RECEIVED CONFIRMATION THAT THIS WAS DONE :-)

- Set the `cluster_size` to 2 for the `test` environment

- Set the cluster instance type to `t2.micro`

- Compile, upload & deploy!

- Find out the host name of your applications in the DNS management tool of AWS

- Enter each of the SSL-secured URLs into your browser

## Deliverables

- A screenshot of both web pages serving the HelloWorld example. Post it to the Slack channel.

- Commit the changes to your own repository (You did create one, didn't you?)
