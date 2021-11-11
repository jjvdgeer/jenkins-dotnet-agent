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
                git url: 'https://github.com/jjvdgeer/jenkins-dotnet-agent.git', branch: dotnet6.0
            }
        }
        stage('Building our image') {
            steps {
                script {
                    docker.withRegistry("$registry") {
                        dockerImage = docker.build imageName + ":dotnet6.0-$BUILD_NUMBER"
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Tag as latest') {
            steps {
                script {
                    docker.withRegistry("$registry") {
                        dockerImage.push('dotnet6.0')
                    }
                }
            }
        }
        stage('Cleaning up') {
            steps {
                sh "docker rmi $imageName:dotnet6.0-$BUILD_NUMBER"
            }
        }
    }
}
