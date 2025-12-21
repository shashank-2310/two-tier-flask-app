@Library("Shared")_
pipeline{
    
    agent { label "dev" };
    
    stages{
        stage("Code"){
            steps{
                script{
                    clone("https://github.com/shashank-2310/two-tier-flask-app.git","master")
                }
            }
        }
        stage("Trivy Filesystem Scan"){
            steps{
                script{
                    trivy_fs()
                }
            }
        }
        stage("Build"){
            steps{
                sh "docker build -t two-tier-flask-app -f Dockerfile-multistage ."
            }
        }
        stage("Test"){
            steps{
                echo "Task for testers/devs..."
            }
        }
        stage("Push to Docker Hub"){
            steps{
                script{
                    docker_push("dockerHubCreds", "two-tier-flask-app", "latest")
                }
            }
        }
        stage("Deploy"){
            steps{
                sh "docker compose up -d"
            }
        }
        
    }
    
    post{
        success{
            script{
                emailext from:'shashankgupta944@gmail.com',
                    subject: "Build Successful for Demo CICD App",
                    body: "Good News: Your build was successful for Demo CICD App!",
                    to: 'shashankgupta944@gmail.com',
                    mimeType: 'text/html'
            }
        }
        failure{
            script{
                emailext from:'shashankgupta944@gmail.com',
                    subject: "Build Failed for Demo CICD App",
                    body: "Good News: Your build was failed for Demo CICD App!",
                    to: 'shashankgupta944@gmail.com',
                    mimeType: 'text/html'
          }
       }
    }
}
