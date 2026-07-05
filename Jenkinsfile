pipeline {
    agent none

    stages {
        stage('Lint') {
            agent { docker 'python:3.11-slim' }
            steps {
                sh '''
                    pip install flake8 requests
                    flake8 app
                '''
            }
        }

        stage('Containerised Tests') {
            agent {
                docker {
                    image 'docker:cli'
                    args '-u root -v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                sh '''
                    apk add --no-cache docker-compose
                    docker compose up -d --build
                    docker compose exec -T api pytest
                    docker compose down -v
                '''
            }
        }

        stage('Docker Build & Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKERHUB_USER',
                    passwordVariable: 'DOCKERHUB_PASS'
                )]) {
                    sh '''
                        echo "$DOCKERHUB_PASS" | docker login -u "$DOCKERHUB_USER" --password-stdin
                        docker build -t $DOCKERHUB_USER/pulsenotify:$BUILD_ID -t $DOCKERHUB_USER/pulsenotify:latest .
                        docker push $DOCKERHUB_USER/pulsenotify:$BUILD_ID
                        docker push $DOCKERHUB_USER/pulsenotify:latest
                        docker rmi $DOCKERHUB_USER/pulsenotify:$BUILD_ID $DOCKERHUB_USER/pulsenotify:latest || true
                    '''
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
