pipeline {
    environment {
        imageName = "jjvdgeer/jenkins-dotnet-agent"
        registry = "http://qnap:5000/"
        dockerImage = ''
        isLatest = false
        isPreview = false
    }
    agent { label 'docker' }
    stages {
        stage('Clone sources') {
            steps {
                git url: 'https://github.com/jjvdgeer/jenkins-dotnet-agent.git', branch: 'dotnet3.1'
            }
        }
        stage('Building our image') {
            steps {
                script {
                    docker.withRegistry("$registry") {
                        dockerImage = docker.build imageName + ":$BRANCH_NAME-$BUILD_NUMBER"
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Tag image') {
            steps {
                script {
                    docker.withRegistry("$registry") {
			dockerImage.push("$BRANCH_NAME")
                    }
                }
            }
        }
        stage('Tag as latest') {
            when {
                expression { return isLatest; }
            }
            steps {
                script {
                    docker.withRegistry("$registry") {
                        dockerImage.push('latest')
                    }
                }
            }
        }
        stage('Tag as preview') {
            when {
                expression { return isPreview; }
            }
            steps {
                script {
                    docker.withRegistry("$registry") {
                        dockerImage.push('preview')
                    }
                }
            }
        }
        stage('Cleaning up') {
            steps {
                sh "docker rmi $imageName:$BRANCH_NAME-$BUILD_NUMBER"
            }
        }
    }
}
