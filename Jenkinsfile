pipeline {
    agent any

    stages {
        stage('Prepare') {
            steps {
                sh './cleanup.sh'
                sh 'docker network create my-network || true'
            }
        }

        stage('Build Images') {
            steps {
                sh 'docker build -t flask-image .'
            }
        }

        stage('Run Containers') {
            steps {
                sh 'docker run -d --name flask-app --network my-network flask-image'
                sh 'docker run -d --name nginx --network my-network -p 80:80 nginx'
            }
        }
    }
}
