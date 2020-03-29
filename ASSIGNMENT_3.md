# Infrastructure for Master of Cloud - Excercise 3

```
   _____                   __                         _____  _________ .__                   .___
  /     \ _____    _______/  |_  ___________    _____/ ____\ \_   ___ \|  |   ____  __ __  __| _/
 /  \ /  \\__  \  /  ___/\   __\/ __ \_  __ \  /  _ \   __\  /    \  \/|  |  /  _ \|  |  \/ __ | 
/    Y    \/ __ \_\___ \  |  | \  ___/|  | \/ (  <_> )  |    \     \___|  |_(  <_> )  |  / /_/ | 
\____|__  (____  /____  > |__|  \___  >__|     \____/|__|     \______  /____/\____/|____/\____ | 
        \/     \/     \/            \/                               \/                       \/ 
```

## Introduction

In session one and two of this Cloud Master and the hands on lab you have bootstrapped your
project, created your own stack, and launched two docker containers on AWS' container
orchestration platform ECS. You have made it this far. It is now time for you to remove your
ECS cluster before we move onto the assignment.

To do so, open the parent.rb file from the parent stack. The ECS cluster stack is included
in the parent stack as follows:

```
resource :ecs_stack,
         type: "AWS::CloudFormation::Stack" do |r|
  r.property(:template_url) { "ecsstack" }
  r.property(:parameters) do
    {
      "Vpc": "VpcStack".ref("Outputs.VpcId"),
      "Subnets": [
        :vpc_stack.ref("Outputs.Ec2PrivateSubnetName"),
        :vpc_stack.ref("Outputs.Ec2PrivateSubnet2Name"),
        :vpc_stack.ref("Outputs.Ec2PrivateSubnet3Name")
      ].fnjoin(","),
      "PublicSubnets": [
        :vpc_stack.ref("Outputs.Ec2PublicSubnetName"),
        :vpc_stack.ref("Outputs.Ec2PublicSubnet2Name"),
        :vpc_stack.ref("Outputs.Ec2PublicSubnet3Name")
      ].fnjoin(",")
    }
  end
end
```

I do not want you to throw away the code, however. It might be useful later on.
Instead, I want to teach you about an argument that you can pass to the resource: `amount`.

This is how you delete a resource, without having to delete the code.

```
resource :ecs_stack,
         amount: 0,
         type: "AWS::CloudFormation::Stack" do |r|
 ...
end
```

You can also play around with that number: You are able to create multiple resources of the
same type. For example:

```
resource :s3_bucket,
         amount: 3,
         type: "AWS::S3::Bucket"
```

Will generate 3 S3 Buckets with the following resource names:

```
S3Bucket
S3Bucket2
S3Bucket3
```

A practical application for creating multiple instances of a resource is that you have a config file
with bucket names, or specific configuration. For example:

```
bucket_names = [
  "my-foobar-bucket",
  "my-barfoo-bucket",
  "the-last-bucket"
]

resource :iterated_bucket,
         amount: bucket_names.count,
         type: "AWS::S3::Bucket" do |r, index|
  r.property(:bucket_name) { bucket_names[index] }
end
```

The above example would produce 3 S3 Buckets with resource names IteratedBucket, IteratedBucket2,
and IteratedBucket3, with its respective BucketName set.

I digress... so you set the `ecs_stack` amount to 0. Do the same for the ACM stack and remove the
cluster_size setting from your `config.yaml` file.

Now go ahead and deploy! You should see all the money slobbering resources disappear. No worries,
in the next assignment we're going to burn some more monies.

One of the greatest skills you must possess to be a Cloud Engineer is the ability to read through
documentation. This assignment involves inspecting the documentation thoroughly.

## Assignment

- Create a new stack: database_stack

- Implement this resource: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-rds-database-instance.html

- It must be of type mysql. Do not choose Aurora.

- Choose a db.t2.micro as InstanceType

- Stick your database password in your .env.private, and use ENV["YOUR_ENV_VAR"] to reference it in the code:

- For example: `r.property(:master_user_password) { ENV["YOUR_ENV_VAR"] }`

- This will keep the MySQL password out of GIT ;-)

- Configure the minimum required to make it work. It can have a public IP.

- Connect to the database after it has been created

- Create a database table, with some data (doesn't matter which data. Insert or import something)

- Create a database snapshot of your RDS instance in the AWS console

- Configure the snapshot ID in the .env file for your specific environment

- Remove the RDS instance from your stack, without deleting the code

- Enable the RDS instance, but load the data from snapshot automatically

## Deliverables

- A screenshot of you deleting and rebuilding the RDS instance, and a screenshot of your MySQL table with the data still intact.

