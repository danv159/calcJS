pipeline{
    agent{
        node{
            label 'virtualAgeticDAN'
        }
    }
    // parameters{

    // }
    // environment{
        
    // }
    stages{
        
        stage('analisis de codigo con sonarqube'){
            steps{
                script {
                    def scannerHome = tool 'SonarQube Scanner';
                    withSonarQubeEnv('sonarqube') {
                        sh "${scannerHome}/bin/sonar-scanner"
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
                        docker build -t calcjs:1.0 .
                        docker run -d --name calcjs -p3000:3000 calcjs:1.0
                        echo "$tokendocker" | docker login -u danv159 --password-stdin
                        docker tag calcjs:1.0 danv159/calcjs:1.0
                        docker push danv159/calcjs:1.0
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
