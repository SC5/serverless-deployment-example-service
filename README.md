# Example Serverless project for deployment

## Serverless Deployment with Ansible (Lite)
[serverless-deployment-ansible-lite](https://github.com/SC5/serverless-deployment-ansible-lite) builds and deploys project with Serverless so no extra configuration is needed.

## Serverless Deployment with Ansible
[serverless-deployment-ansible](https://github.com/SC5/serverless-deployment-ansible) deploys already built serverless package.

Here is the deployment flow in short:

1. Build artifact with `sls deploy --ansible` ([serverless-ansible-build-plugin](https://github.com/laardee/serverless-ansible-build-plugin)) which creates Jinja2 template from CloudFormation stack and copies .zip file to deployment folder.
2. Copy .j2 template and zip to Artifactory/S3 or where ever you wish.
3. Ansible playbook downloads template and deploys CloudFormation stack and functions zip to AWS.

More detailled instructions will be available in [serverless-deployment-ansible](https://github.com/SC5/serverless-deployment-ansible).