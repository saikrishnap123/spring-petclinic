pipeline {
    agent any
    
    environment {
        // Define environment variables
        AWS_REGION = 'us-east-1'  // Adjust your region
        ECR_REPOSITORY_NAME = 'my-java-app'  // Adjust your ECR repository name
        IMAGE_TAG = "latest"  // Or you can use git commit hash or versioning
        AWS_CREDENTIALS = 'aws-credentials-id'  // Jenkins AWS credentials ID
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the Java code from your repository
                git 'https://github.com/yourusername/your-repository.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image from the Dockerfile
                    docker.build("${ECR_REPOSITORY_NAME}:${IMAGE_TAG}")
                }
            }
        }

        stage('Login to AWS ECR') {
            steps {
                script {
                    // Use AWS CLI to authenticate Docker to ECR
                    withCredentials([usernamePassword(credentialsId: AWS_CREDENTIALS, passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
                        sh '''
                            aws --version  # Check if AWS CLI is installed
                            aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                        '''
                    }
                }
            }
        }

        stage('Push Docker Image to ECR') {
            steps {
                script {
                    // Tag the Docker image with the ECR repository URI
                    def imageUri = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY_NAME}:${IMAGE_TAG}"
                    sh """
                        docker tag ${ECR_REPOSITORY_NAME}:${IMAGE_TAG} ${imageUri}
                        docker push ${imageUri}
                    """
                }
            }
        }
    }

    post {
        always {
            // Clean up docker images if necessary
            sh 'docker system prune -f'
        }
    }
}
