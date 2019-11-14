pipeline {
libraries{
lib 'shlib'

}

 agent any
   tools{
        maven "Maven"
    }
    stages {
      stage('Start')
            {
                steps
                 { 
                    sendNotifications 'STARTED'
                 }
            }

      stage('clean and build')
            {
                steps{
                    
                sendNotifications 'STARTEDBUILD'
                build 'BUILD'
                 
            }
            post{
            failure{
            jira()
            }
            }
            }
    
             stage('SonarQube analysis') {
             environment {
           scannerHome=tool 'sonarScanner'
       }

            steps {
            sendNotifications 'SONAR ANALYSIS STARTED'
                sonar()
            } 
            }
        stage('Quality Gate') {
            steps {
             gate 'GATE'
            }
       }
       /*stage('Security scan') {
            steps {
            sendNotifications 'security scan started'
             scan 'SCAN'
            }
       }*/
  
            stage("Nexus") {
            steps {
          sendNotifications  'NEXUS STAGE STARTED'
          nexus 'NEXUS'
        }
        }
         stage('Deploy to Development'){
            steps{
            devenvironment 'DEPLOY INTO DEV ENVIROINMENT'
             deploy_development 'deploy_dev'
            }
        }
        stage('Deploy to Ansible Master'){
            steps{
               sendNotifications 'Deploy to Ansible Master'
               deploy_ansible  'deploy_ansible'
            } 
        }
        
        stage('Approval1'){
                steps{
                approval 'APPROVAL'
                }
                }
                
        stage('Deploy to Test Server'){
             steps{
                 sendNotifications 'Deploy to Test Server'
                 deploy_test 'deploy_test'
             }
        }
          stage('functional test')
    {
    steps
    {
    functional 'functional_test'
    }
    }
        stage('Approval2'){
                steps{
                approval1 'APPROVAL1'
                }
                }
        stage('Deploy to Performance Server'){
             steps{
             sendNotifications 'Deploy to Performance Server'
                 deploy_performance 'deploy_per'
             }
        }
        stage('performance test')
       {
           steps
           {
           performance 'performance_test'
           }
      }
        stage('Approval3'){
                steps{
                approval2 'APPROVAL1'
                }
                }
        stage('Deploy to Production Server'){
             steps{
             sendNotifications 'Deploy to Production Server'
                 deploy_production  'deploy_prod'
             }
        }

      
        }
        post{
always{
sendNotifications currentBuild.result
}
}

    }
