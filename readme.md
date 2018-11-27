# ExJobb project
Thid document describes how to deploy an `Application Under Test` and `Jenkins` for automated tests in a `minikube` environment.

## Project idea
Test a generic wordpress blog based in a container environment (kubernetes) in a simple, predictable, reliable and replicable way.
Notes: the environment containing the application under test (AUT) and the services and frameworks needed in order to achieve the goal will be based on Kubernetes - a vendor agnostic (platform oberoende) container-centric management environment.

## Project scope
1. (general) To deploy an application (a WordPress blog) in a Kubernetes environment and make sure everything is working fine.
2. (detail) To deploy an `AUT` (application under test) and `Jenkins` for automated tests in a `minikube` environment in order to create and deploy the testing pipelines.

## Tools used
1. minikube
2. Jenkins
3. kubectl
4. helm
5. Robotframework with SeleniumLibrary

## Testing scope
1. automated testing with robotframework & SeleniumLibrary: login & logout, links validation aka blog pages links are working (scripted)
2. manual testing: blog search functionality (scripted)
3. exploratory testing (unscripted, based on checklists)

## Set up the environment

### start minikube
```console
minikube start
```

### stop minikube
```console
minikube stop
```

### deploy wordpress
```console
# Deploy wordpress
helm install --set serviceType=NodePort --name wp-k8s stable/wordpress

# Check password for wordpress
kubectl get secret --namespace default wp-k8s-wordpress -o jsonpath="{.data.wordpress-password}" | base64 --decode
```

### access wordpress
```console
minikube service wordpress --url
```

### deploy jenkins
```console
# Clone minikube-helm-jenkins
git clone https://github.com/lvthillo/minikube-helm-jenkins.git
cd minikube-helm-jenkins

# Create namespace
kubectl create -f minikube/jenkins-namespace.yaml

# Create persistent volume (folder /data is persistent on minikube)
kubectl create -f minikube/jenkins-volume.yaml

# Execute helm
helm install --name jenkins -f helm/jenkins-values.yaml stable/jenkins --namespace jenkins-project

# Check admin password for jenkins:
printf $(kubectl get secret --namespace jenkins-project jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo
```

### access jenkins
```console
minikube service --namespace=jenkins-project jenkins --url
```

