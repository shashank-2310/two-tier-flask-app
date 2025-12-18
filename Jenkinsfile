pipeline{
    
    agent any;
    
    stages{
        stage("code"){
            steps{
                git url: "https://github.com/shashank-2310/two-tier-flask-app.git", branch: "master"
            }
        }
        stage("build"){
            steps{
                sh "docker build -t two-tier-flask-app ."
            }
        }
        stage("test"){
            steps{
                echo "tester/dev jaane ye..."
            }
        }
        stage("push to docker hub"){
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
        stage("deploy"){
            steps{
                sh "docker compose up -d"
            }
        }
        
    }
}
