pipeline {
    agentany
    stages{
        stage("git ceckout") {
        steps{
            git 'https://github.com/SaiRevanth-J/kaiburr_assessment.git'
        }
        }
        stage ("image build") {
            steps  {
                sh "docker bulid -t revantkumar9/webapp"
                 }
        }
        stage ("images vulernability check") {
            steps  {
                sh "trivy --exit-code 1 --severity CRITICAL revanthkumar9/webapp:latest"
                 }
        }
        stage ("Code check") {
            steps  {
                nodejs(nodejsInstallationName: 'nodejs')
                sh "npm install"
                withEnvSonarQubeEnv('sonar'){
                    sh "npm install sonar-scanner"
                    sh "npm run sonar"
                }
                
            }
                 

        }
        stage("docker login & push"){
            steps{
                sh "cat /home/dockerpass.txt | docker login --user revanthkumar9 --password-stdin"
                sh "docker push revanthkumar9/webapp"
            }
        }
        stage ("copy terraform in to kubenerets master") {
            steps{
                sh "cd kubernetes_files"
                sh "sudo scp *.yaml:kubemaster@172.31.38.223:/home/kubemaster"
                sh "ssh kubemaster@172.31.38.223"
                sh "kubectl apply -f ."
            }
        }
}