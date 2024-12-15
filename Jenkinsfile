pipeline {
    agent any

    environment {
        // Define variables
        TARGET_BRANCH = 'main' // Branch to track
        PROJECT_DIRECTORY = '/home/ubuntu/jenkins/ci/jenkins-ci' // Directory where the project is located
    }

    triggers {
        // Trigger pipeline on changes to the target branch
        pollSCM('H/5 * * * *') // Poll every 5 minutes
    }

    stages {
        stage('Pull Changes and Install Dependencies') {
            steps {
                script {
                    // Perform git pull, stash, install dependencies, and build the application
                    sh """
                        echo "Navigating to the project directory: ${PROJECT_DIRECTORY}"
                        cd ${PROJECT_DIRECTORY}
                        
                        echo "Pulling latest changes for branch: ${TARGET_BRANCH}"
                        git pull origin ${TARGET_BRANCH}
                        git stash
                        
                        echo "Installing npm dependencies"
                        npm install
                    """
                }
            }
        }

        stage('Build the Application') {
            steps {
                script {
                    // Run build command to build the application
                    sh """
                        echo "Running npm build"
                        npm run build
                    """
                }
            }
        }

        stage('Build and Deploy Docker Containers') {
            steps {
                script {
                    // Build and deploy Docker containers using docker-compose
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
