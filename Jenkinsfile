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
}
