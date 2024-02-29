pipeline{
    agent{
        label 'virtualAgeticDAN'
    }
    // parameters{

    // }
    // environment{
        
    // }
    stages{
        
        stage('analisis de codigo con sonarqube'){
            steps{
                script{
                    def scannerHome = tool 'sonarqube';
                    
                    withSonarQubeEnv('sonarqube') {
                        sh """${scannerHome}/bin/sonar-scanner -D.sonar.projectKey=analisis_construccion \
                        -D.sonar.projectName=analisis_construccion \
                        -D.sonar.projectVersion=1.0 \
                        -D.sonar.sources=/home/danv/jenkinsNode/workspace/analisis_construccion \
                        -D.sonar.language=java script \
                        -D.sonar.sourceEnconding=UTF-8 
                        """
                        
                    }
                }
            }
            
        }
        stage('build'){
            steps{
                             
                withCredentials([string(
                    credentialesId:'dockerhubTOKEN',
                    variable:'tokendocker'
                )])
                {
                    script{
                        sh "docker build -t calcjs:1.0 .";
                        sh "docker run -d --name calcjs -p3000:3000 calcjs:1.0";
                        sh "echo "$tokendocker" | docker login -u danv159 --password-stdin";
                        sh "docker tag calcjs:1.0 danv159/calcjs:1.0";
                        sh "docker push danv159/calcjs:1.0";
                    }
                }
            }
        }
        stage('commit status a github'){
            steps{
                setBuildStatus("Compiling", "compile", "pending");
                script {
                    try {
                        // do the build here
                        setBuildStatus("Build complete", "compile", "success");
                    } catch (err) {
                        setBuildStatus("Failed", "pl-compile", "failure");
                        throw err
                    }
                }
            }
        }
    }
}
