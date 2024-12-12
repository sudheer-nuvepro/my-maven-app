pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "sudheer99123/my-maven-app"
        DOCKER_TAG = "latest"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/sudheer-nuvepro/my-maven-app.git'
            }
        }

        stage('Build Maven Project') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
                        docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").push()
                    }
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                sh '''
                    docker stop my-maven-app || true
                    docker rm my-maven-app || true
                    docker run -d -p 8081:8080 --name my-maven-app ${DOCKER_IMAGE}:${DOCKER_TAG}
                '''
            }
        }

        stage('Cleanup Workspace') {
            steps {
                sh 'rm -rf *'
            }
        }
    }
}
