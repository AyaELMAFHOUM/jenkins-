pipeline {
    agent any

    environment {
        KUBECONFIG = credentials('kube-config')  // Récupère le kubeconfig pour Kubernetes
        GITHUB_CREDENTIALS = credentials('github-token') 
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    git branch: 'master', credentialsId: 'github-token', url: 'https://github.com/AyaELMAFHOUM/jenkins-.git'
                }
            }
        }

        stage('Build and Push Docker Images') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
                        // Build de l'image PHP
                        def phpImage = docker.build("aya452/gestionabsence-php-apach:latest", "-f dockerfile .")
                        
                        phpImage.push("latest")

                        // Build de l'image MySQL
                        def mysqlImage = docker.build("aya452/imagee:latest", "-f dockerfile .")
                        mysqlImage.push("latest")
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Appliquer les fichiers de déploiement et service sur Kubernetes
                    sh 'kubectl apply -f mysql-deployment.yml'
                    sh 'kubectl apply -f php-deployment.yml'
                    
                    
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                sh 'kubectl get pods'
                sh 'kubectl get services'
            }
        }
    }
} 

