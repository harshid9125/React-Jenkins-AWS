# React DevOps Project :

In This Project I have Deployed one React "hellow_world" app by using Jenkins, Docker, Terraform and Kubernetes.

## Requirements

AWS CLI <br>
Terraform <br>
Jenkins <br>
 Docker<br>
Kubernetes <br>
Git <br>
React <br>

## Usage

### Clone Code from Github:
https://github.com/harshid9125/React-Jenkins-AWS.git

### Build React Project:
- npm install

### Build Docker image for React Application:
- docker build -t react . 

### Docker Push ECR:
- docker push <Account_number>.dkr.ecr.<region>.amazonaws.com/ repoName:tag 

### Deploy React Application:
- kubectl apply -f deployment.yml

### Check Deployments, Pods and Services:
- kubectl get deploy <br>
kubectl get pods <br>
kubectl get svc

- Now Goto Loadbalancer and check whether service comes Inservice or not, If it comes Inservice copy DNS Name of Loadbalancer and Give in WebBrowser

### cleanup deployments by using below commands:

- kubectl delete deploy kubernetes-configmap-reload <br>
kubectl delete svc kubernetes-configmap-reload
