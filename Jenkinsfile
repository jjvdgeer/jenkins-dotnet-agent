pipeline {
    environment {
        registry = "jjvdgeer/jenkins-dotnet-agent"
        dockerImage = ''
    }
    agent { label 'docker' }
    stages {
        stage('Clone sources') {
            steps {
                git url: 'https://github.com/jjvdgeer/jenkins-dotnet-agent.git'
            }
        }
        stage('Building our image') {
            steps {
                script {
                    docker.withRegistry('http://qnap:5000/') {
                        dockerImage = docker.build registry + ":dotnet3.1-$BUILD_NUMBER"
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Tag as latest') {
            steps {
                script {
                    docker.withRegistry('http://qnap:5000/') {
                        dockerImage.push('latest')
			dockerImage.push('dotnet3.1')
                    }
                }
            }
        }
        stage('Cleaning up') {
            steps {
                sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }
    }
}
