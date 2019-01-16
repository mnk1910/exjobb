pipeline{
    agent any
    stages{
        stage('Create five users'){
            steps{
                sh '''#!/bin/bash
                    # fail if there is an error in the pipe
                    set -o pipefail

                    # get the URL for the wordpress installation
                    WORDPRESS=wp-k8s-wordpress.default.svc.cluster.local

                    for i in {1..5}
                    do
                        # send a POST request to the wordpress API
                        curl -s -X POST --user admin:password "${WORDPRESS}/wp-json/wp/v2/users/?username=user${i}&email=user${i}@example.com&password=password" | jq .
                    done
                '''
            }
        }

        stage('List all users'){
            steps{
                sh '''#!/bin/bash
                    # fail if there is an error in the pipe
                    set -o pipefail

                    # get the URL for the wordpress installation
                    WORDPRESS=wp-k8s-wordpress.default.svc.cluster.local

                    # send a POST request to the wordpress API
                    curl -s -X GET --user admin:password "${WORDPRESS}/wp-json/wp/v2/users/" | jq -r ".[].name"
                '''
            }
        }

        stage('Delete five users'){
            steps{
                sh '''#!/bin/bash
                    # fail if there is an error in the pipe
                    set -o pipefail

                    # get the URL for the wordpress installation
                    WORDPRESS=wp-k8s-wordpress.default.svc.cluster.local

                    # send a DELETE request to the wordpress API
                    for id in $(curl -s -X GET --user admin:password "${WORDPRESS}/wp-json/wp/v2/users/" | jq -r '.[] | .name + " " + (.id|tostring)' | grep user | awk '{print $2}'); do
                        curl -s -X DELETE --user admin:password "${WORDPRESS}/wp-json/wp/v2/users/${id}?reassign=1&force=true" | jq .
                    done
                '''
            }
        }
    }
}
