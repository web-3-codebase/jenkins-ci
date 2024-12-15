pipeline {
    agent any

    environment {
        TARGET_BRANCH = 'main' // Branch to track
        PROJECT_DIRECTORY = "${env.WORKSPACE}" 
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
                        cd ${PROJECT_DIRECTORY}
                        
                        echo "Resetting repository to clean state"
                        
                        echo "Pulling latest changes for branch: ${TARGET_BRANCH}"
                        git pull 
                        
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
