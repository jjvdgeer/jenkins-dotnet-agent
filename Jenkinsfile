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
                git url: 'https://github.com/jjvdgeer/jenkins-dotnet-agent.git', branch: 'dotnet9.0'
            }
        }
        stage('Building our image') {
            steps {
                script {
                    docker.withRegistry("$registry") {
                        dockerImage = docker.build imageName + ":dotnet9.0-$BUILD_NUMBER"
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Tag as dotnet3.1') {
            steps {
                script {
                    docker.withRegistry("$registry") {
			dockerImage.push('dotnet9.0')
                    }
                }
            }
        }
        stage('Cleaning up') {
            steps {
                sh "docker rmi $imageName:dotnet9.0-$BUILD_NUMBER"
            }
        }
    }
}
