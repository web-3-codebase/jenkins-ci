pipeline {
    agent any

    environment {
        // Define variables
        TARGET_BRANCH = 'main' // Branch to track
        PROJECT_DIRECTORY = 'jenkins/ci/jenkins-ci' // Directory where the project is located
    }

    triggers {
        // Trigger pipeline on changes to the target branch
        pollSCM('H/5 * * * *') // Poll every 5 minutes
    }

    stages {
        stage('Pull Changes and Build') {
            steps {
                script {
                    // Perform git pull, stash, and build/deploy using docker-compose
                    sh """
                        echo "Navigating to the project directory: ${PROJECT_DIRECTORY}"
                        cd ${PROJECT_DIRECTORY}
                        
                        echo "Pulling latest changes for branch: ${TARGET_BRANCH}"
                        git pull origin ${TARGET_BRANCH}
                        git stash
                        
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
