pipeline {
    agent any

    stages {
        stage('Prepare') {
            steps {
                sh 'chmod +x ./cleanup.sh'
                sh './cleanup.sh'
                sh 'docker network create my-network || true'
            }
        }

        stage('Build Images') {
            steps {
                sh 'docker build -t flask-image .'
                sh 'docker build -f ./Dockerfile2 -t nginx-image .'
            }
        }

        stage('Run Containers') {
            steps {
                sh 'docker run -d --name flask-app --network my-network flask-image'
                sh 'docker run -d --name nginx --network my-network -p 80:80 nginx-image'
            }
        }
        stage("Security Scan") {
            steps {
                sh "trivy fs --format json -o trivy-report.json ."
            }
            post {
                always {
                    // Archive the Trivy report
                    archiveArtifacts artifacts: 'trivy-report.json', onlyIfSuccessful: true
                }
            }
        }
        stage('tests'){
            steps {
                sh 'chmod +x ./unit-test.sh'
                sh './unit-test.sh'
            }
        }
    }
}
