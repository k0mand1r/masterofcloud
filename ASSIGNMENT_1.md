# Infrastructure for Master of Cloud - Excercise 1

```
   _____                   __                         _____  _________ .__                   .___
  /     \ _____    _______/  |_  ___________    _____/ ____\ \_   ___ \|  |   ____  __ __  __| _/
 /  \ /  \\__  \  /  ___/\   __\/ __ \_  __ \  /  _ \   __\  /    \  \/|  |  /  _ \|  |  \/ __ |
/    Y    \/ __ \_\___ \  |  | \  ___/|  | \/ (  <_> )  |    \     \___|  |_(  <_> )  |  / /_/ |
\____|__  (____  /____  > |__|  \___  >__|     \____/|__|     \______  /____/\____/|____/\____ |
        \/     \/     \/            \/                               \/                       \/
```

## Prerequisites

- Docker is installed and working
- You must have a github.com account with your SSH key configured.
- You have cloned this git repository (And if you're reading this, chances are you have done so.
- Clone it with ssh, not with https!
- You have an AWS account with Administrator or Poweruser privileges

## Introduction

Welcome to the first assignment of this crash course in cloud engineering. This repository
contains all the source code necessary to build, test and upload and deploy resources on AWS.
For the time being, you do not need to know about the purpose of all the different files,
however it is key to understand the difference between provisioning resources through the
AWS console and through (infrastructure as) code:

When you provision resources through the console, there is no record of how you put that
resource together, nor is there a log of changes. If you modify a resource, its current
state is the only state known. If you made a mistake, you have to remember what you had
changed and revert those changes. Lastly, if you want replicate what you have clicked
together in the console, you have to repeat the actions you have done so before. This
is time consuming, and prone to error.

Now imagine you have made a whole bunch of changes, and you've made a mistake somewhere
and decide to go back to the latest working version: At that moment you would have to
undo _everything_ that you did before to go back to a known working state. This is
untenable from a management perspective and highly undesirable.

The way that we provision resources to AWS during this course is through Infrastructure
as Code. This means that we explicitly declare the resources that we want to provision.
These resources are detailed in a json (or yaml) file. We call this json file the
CloudFormation template. Not only does it make the resources we want to provision
explicit, it is also versioned - which means that if we want to undo a change, we simply
revert the last commit and deploy again. In addition: When deploying a CloudFormation
template, AWS compares the currently deployed template to the template you're trying
to deploy. It will see what has changed and _only_ update the changed or added resources.
If something goes wrong - for example, something was misconfigured - then AWS will
automatically roll back to the previously known working version.

The result of a deploy can be one of two states:

- The deploy succeeds: The new version is now deployed and any old resources are decommissioned
- The deploy fails: The last working version is still deployed and any new resources are decommissioned

Our Infrastructure as Code project does not contain CloudFormation templates, however.
It contains code that _generates_ CloudFormation templates. The code to produce these
templates is a minimal abstraction of CloudFormation, and set up in this way to enable you
to add programming logic to your resource generation, and to allow for you to unit test
the code and its CloudFormation artifacts.

## Assignment

1. Set up your own repository. Do not fork this repository.

- Create a new github repository
- Clone your github repository, choose ssh for cloning
- Copy over all the files of this repository (master branch)
- Commit the files.

2. Edit .env.private

- Add AWS_ACCESS_KEY_ID="AKIAxxxxxxxxxxx"
- Add AWS_SECRET_ACCESS_KEY="REPLACE_WITH_YOUR_SECRET_KEY"

These credentials should have been supplied to you by your cloud tutor. If you are using
your own AWS account, go to the AWS console, and open Identity and Access Management.
Create a new user and select 'Programmatic Access'. Attach a policy 'Administrator Access'
to the user. At the end, AWS will provide you with an Access Key Id and a Secret Access Key.
Add them to your .env.private file.

3. Edit `config.yaml`

- Modify the `domain_name: "mysubdomain.masterofcloud.com"` line.
- Change `mysubdomain` to your first and last name in lower case: e.g. `dennisvink.masterofcloud.com`

4. Run the `./rake_init.sh` script.

- Watch the magic. In the meanwhile, log into the AWS console to observe what is happening.
- In the console, search for CloudFormation under 'Find Service'. Select eu-west-1 (Ireland) as your region in the top right navbar.
- A stack should now have appeared: `masterofcloudTestDependencyStack`.
- Click the stack name, and go to the `Outputs` tab.

You will see something similar to this:

```
ArtifactBucket        masterofcloudtestdependencystack-artifactbucket-70jvazj62lhy
CloudformationBucket  masterofcloudtestdependencys-cloudformationbucket-y65s95n7dug7
HostedZoneId          ZZOJ8FG9G1MYI
HostedZoneName        test.dennisvink.masterofcloud.com
LambdaBucket          masterofcloudtestdependencystack-lambdabucket-1req22m6frveb
LoggingBucket         masterofcloudtestdependencystack-loggingbucket-1k4tgzqwvr52u
```

These values contain all the bootstrapping your stack will need for now. You do not
need to know what they are right now. We'll go in depth in a later excercise.

You do not need to copy these values manually: Issue the following command: `./rake_dependencies.sh`

This command will fetch these bootstrapping values from your freshly created stack
and stores them locally in the `.env.dependencies.test` file.

With the bootstrapping for our `test` environment done, we can now proceed!

5. Compiling the code

- Invoke `./rake_compile` to compile the code
- Look inside the build/ directory

The files inside your build/ directory are the CloudFormation templates that our
project has generated. They are the artifacts that we are going to deploy to AWS.

6. Run the unit tests

- If you've done a `./rake_compile.sh` in step 5, do a `./rake_spec.sh` now.
- If you had ran './rake.sh' instead, you can skip 6, as 'rake.sh' combines both compiling and unit testing.

7. Upload the templates

- Invoke the script for uploading the templates

8. Deploy!

- Invoke the script for deploying the templates
- Watch the magic happen in the AWS console

9. Commit your changes. Double check that .env.private is in `.gitignore`.

## Deliverables

- A screenshot of your dependency stack and the stacks this project deployed. Post it to the #masterofcloud Slack channel.
- A link to your GIT repository (keep it public, or invite me. I am `dennisvink` on github.
