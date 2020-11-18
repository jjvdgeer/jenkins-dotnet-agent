pipeline {
    environment {
        imageName = "jjvdgeer/jenkins-dotnet-agent"
        registry = "http://qnap:5000/"
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
                    docker.withRegistry("$registry") {
                        dockerImage = docker.build imageName + ":dotnet3.1-$BUILD_NUMBER"
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Tag as latest') {
            steps {
                script {
                    docker.withRegistry("$registry") {
                        dockerImage.push('latest')
			dockerImage.push('dotnet3.1')
                    }
                }
            }
        }
        stage('Cleaning up') {
            steps {
                sh "docker rmi $imageName:dotnet3.1-$BUILD_NUMBER"
            }
        }
    }
}
