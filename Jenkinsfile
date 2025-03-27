pipeline{
    agent any
    stages{
        stage("prepare"){
            steps{
                sh ./cleanup.sh
                docker network create my-network
            }
        }
        stage("build images"){
            steps{
                docker build -t flask-image
            }
        }
        stage("run containers"){
            steps{
                docker run --name flask-app --network my-network flask-image
                docker run --name nginx --network -p 80:80 my-network nginx
            }
        }
    }
}