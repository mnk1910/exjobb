pipeline{
    agent any
    stages{
        stage('Clean-up'){
            steps{
                sh './scripts/clean-up.sh'
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
