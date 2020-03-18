docker run -v $PWD:/stack -w /stack/ -e ENVIRONMENT masterofcloud/compiler:latest /bin/bash -c "rake spec"
