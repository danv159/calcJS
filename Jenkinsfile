//para hacer el commit status
void setBuildStatus(String message, String state) {
  step([
      $class: "GitHubCommitStatusSetter",
      reposSource: [$class: "ManuallyEnteredRepositorySource", url: "https://github.com/danv159/calcJS"],
      contextSource: [$class: "ManuallyEnteredCommitContextSource", context: "ci/jenkins/build-status"],
      errorHandlers: [[$class: "ChangingBuildStatusErrorHandler", result: "UNSTABLE"]],
      statusResultSource: [ $class: "ConditionalStatusResultSource", results: [[$class: "AnyBuildResult", message: message, state: state]] ]
  ]);
}


pipeline{
    agent{
        label 'virtualAgeticDAN'
    }
    // parameters{

    // }
    // environment{
        
    // }
    stages{
        
        
        /*stage('build'){
            steps{
                             
                withCredentials([string(
                    credentialsId:'dockerhubTOKEN',
                    variable:'tokendocker'
                )])
                {
                    script{
                        sh "docker build -t calcjs:1.0 .";
                        sh "docker run -d --name calcjs -p3000:3000 calcjs:1.0";
                        sh "echo $tokendocker | docker login -u danv159 --password-stdin";
                        sh "docker tag calcjs:1.0 danv159/calcjs:1.0";
                        sh "docker push danv159/calcjs:1.0";
                    }
                }
            }
        }*/
        stage('analisis de codigo con sonarqube'){
            steps{
                script{
                    def scannerHome = tool 'sonarqube';
                    
                    withSonarQubeEnv('sonarqube') {
                        sh """${scannerHome}/bin/sonar-scanner \
                            -Dsonar.projectKey=analisis_construccion \
                            -Dsonar.projectName=analisis_construccion \
                            -Dsonar.projectVersion=1.0 \
                            -Dsonar.sources=/home/danv/jenkinsNode/workspace/analisis_construccion \
                            -Dsonar.language=javascript \
                            -Dsonar.sourceEncoding=UTF-8
                        """
                    }
                }
            }
            
        }
        
    }
    post {
    success {
        setBuildStatus("Build succeeded", "SUCCESS");
    }
    failure {
        setBuildStatus("Build failed", "FAILURE");
    }
  }
}
