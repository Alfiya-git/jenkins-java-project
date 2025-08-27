pipeline {
    agent any

    tools {
        maven "Maven3"  // Make sure M3 is configured in Jenkins
    }

    stages {
        stage('Build') {
            steps {
                sh "mvn clean package"
            }
        }
        
        stage('Docker'){
            steps {
                script {
                    sh '''
                    echo "Building docker image"
                    docker build -t java-app-image:latest .
                    
		    echo "Stopping old container if exists"
	            docker rm -f java-app-container || true

                    echo "Running docker container"
                    docker run -d --name java-app-container -p 9090:8080 java-app-image:latest
                    '''
                }
            }
        }
    }   // <-- closes stages

    post {
        success {
            archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            echo "Build Successfully Done ✅"
        }
        failure {
            echo "Build Unsuccessful ❌"
        }
        always {
            emailext body: 'Build is  Successful', recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']], subject: 'Test'
        }

    }
}
