docker run -v $PWD:/stack -w /stack/ -e ENVIRONMENT -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY masterofcloud/compiler:latest /bin/bash -c "rake dependencies"
