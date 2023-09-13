pipeline {
    agent any
    
    stages {
        stage ('Checkout Source') {
            steps {
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/adikrisnaffa/sample-asp.git']])
            }
        }
        
        stage('Restore dotnet') {
            steps {
                bat(script: 'dotnet restore', returnStatus: true)
            }
        }
        
        stage('Build dotnet') {
            steps {
                bat(script: 'dotnet publish -c Release -o out', returnStatus: true)
            }
        }
        
        stage('Build Image Docker') {
            steps {
                bat 'docker build -t adikrisnanugraha/jenkins-docker-hub .'
            }
        }
        
        stage('Push Image to Docker hub') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
                        bat "docker login -u adikrisnanugraha -p %dockerhubpwd%"
                        bat 'docker push adikrisnanugraha/jenkins-docker-hub'
                        
                    }
                    
                }
                
            }
            
        }
        
        stage('Deploying to Minikube Kubernetes') {
            steps {
                script {
                    
                }
            }
        }

        
    }
}