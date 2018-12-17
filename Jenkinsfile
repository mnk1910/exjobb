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
                sh '''
                    helm install --name wp-k8s --set wordpressUsername=admin,wordpressPassword=password,mariadb.mariadbRootPassword=secretpassword,wordpressBlogName=Blog stable/wordpress
                    ./scripts/wait.sh wp-k8s-wordpress
                '''
            }
        }

        stage('Create two users'){
            steps{
                sh '''
                    # fail if there is an error in the pipe
                    set -o pipefail

                    # get the URL for the wordpress installation
                    WORDPRESS=$(minikube service wp-k8s-wordpress --url | head -1)

                    for i in {1..2}
                    do
                        # send a POST request to the wordpress API
                        curl -s -X POST --user admin:password "${WORDPRESS}/wp-json/wp/v2/users/?username=user${i}&email=user${i}@example.com&password=password" | jq .
                    done
                '''
            }
        }

        stage('List all users'){
            steps{
                sh '''
                    # fail if there is an error in the pipe
                    set -o pipefail

                    # send a POST request to the wordpress API
                    curl -s -X GET --user admin:password "${WORDPRESS}/wp-json/wp/v2/users/" | jq -r ".[].name"
                '''
            }
        }
    }
}
