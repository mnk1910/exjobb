pipeline{
    agent any
    stages{
        stage('Clean-up'){
            steps{
                sh '[[ $(helm list wp-k8s --short | wc -l) -eq 1 ]] && helm delete --purge wp-k8s && kubectl delete pvc --all && kubectl delete pv --all'
            }
        }

        stage('Deploy Wordpress'){
            steps{
                sh 'helm install --name wp-k8s --set wordpressUsername=admin,wordpressPassword=password,mariadb.mariadbRootPassword=secretpassword,wordpressBlogName=Blog stable/wordpress'
                sh './scripts/wait.sh wp-k8s-wordpress'
            }
        }
    }
}
