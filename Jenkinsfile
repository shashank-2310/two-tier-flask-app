pipeline{
    
    agent { label "dev" };
    
    stages{
        stage("Code"){
            steps{
                git url: "https://github.com/shashank-2310/two-tier-flask-app.git", branch: "master"
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
                withCredentials([usernamePassword(
                    credentialsId: "dockerHubCreds",
                    usernameVariable: "dockerHubUser",
                    passwordVariable: "dockerHubPass"
                    )]){
                    
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                    sh "docker image tag two-tier-flask-app ${env.dockerHubUser}/two-tier-flask-app"
                    sh "docker push ${env.dockerHubUser}/two-tier-flask-app:latest"
                    
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
