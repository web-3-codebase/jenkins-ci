pipeline {
    agent any

    environment {
        TARGET_BRANCH = 'main' // Branch to track
        PROJECT_DIRECTORY = '/home/ubuntu/jenkins/ci/jenkins-ci' // Explicit project directory
    }

    triggers {
        pollSCM('H/5 * * * *') // Poll every 5 minutes
    }

    stages {
        stage('Pull Changes and Install Dependencies') {
            steps {
                script {
                    sh """
                        echo "Navigating to the project directory: ${PROJECT_DIRECTORY}"
                        
                        # Ensure the directory exists
                        if [ ! -d "${PROJECT_DIRECTORY}" ]; then
                            echo "Directory does not exist: ${PROJECT_DIRECTORY}"
                            exit 1
                        fi
                        
                        cd ${PROJECT_DIRECTORY}
                        
                        echo "Pulling latest changes for branch: ${TARGET_BRANCH}"
                        git pull origin ${TARGET_BRANCH}
                        
                        echo "Installing npm dependencies"
                        npm install
                    """
                }
            }
        }

        stage('Build the Application') {
            steps {
                script {
                    sh """
                        echo "Building the application"
                        cd ${PROJECT_DIRECTORY}
                        npm run build
                    """
                }
            }
        }

        stage('Build and Deploy Docker Containers') {
            steps {
                script {
                    sh """
                        echo "Building and deploying Docker containers"
                        cd ${PROJECT_DIRECTORY}
                        docker-compose up --build -d
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'Build and deployment successful!'
        }
        failure {
            echo 'Build or deployment failed!'
        }
    }
}
