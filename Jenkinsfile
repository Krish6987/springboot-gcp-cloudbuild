pipeline {
libraries{
lib 'shlib'
}

 agent any
   tools{
        maven "Maven"
    }
    stages {
      /*stage('Start')
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
                    jira 'BUILD FAILED','TEST-1'
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
            post{
                failure{
                    jira 'SONAR ANALYSIS FAILED','TEST-2'
                }
            }
            }
        stage('Quality Gate') {
            steps {
             gate 'GATE'
            }
            post{
                failure{
                    jira 'QUALITY GATE FAILED','TEST-3'
                }
            }
       }
       stage('Security scan') {
            steps {
            sendNotifications 'security scan started'
             scan 'SCAN'
            }
            post{
                failure{
                    jira 'SECURITY SCAN FAILED','TEST-4'
                }
            }
       }
  
            stage("Nexus") {
            steps {
          sendNotifications  'NEXUS STAGE STARTED'
          nexus 'NEXUS'
        }
        post{
                failure{
                    jira 'NEXUS UPLOADING FAILED','TEST-5'
                }
            }
        }
         stage('Deploy to Development'){
            steps{
            devenvironment 'DEPLOY INTO DEV ENVIROINMENT'
             deploy_development 'deploy_dev'
            }
            post{
                failure{
                    jira 'DEPLOYMENT TO DEVELOPMENT SERVER FAILED','TEST-6'
                }
            }
        }
        stage('Deploy to Ansible Master'){
            steps{
               sendNotifications 'Deploy to Ansible Master'
               deploy_ansible  'deploy_ansible'
            } 
            post{
                failure{
                    jira 'DEPLOY TO ANSIBLE MASTER FAILED','TEST-7'
                }
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
             post{
                failure{
                    jira 'DEPLOYMENT TO TEST SERVER FAILED','TEST-9'
                }
            }
        }*/
          stage('functional test')
    {
    steps
    {
    functional 'functional_test'
    }
    post{
                failure{
                    jira 'FUNCTIONAL TEST FAILED','TEST-10'
                }
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
             post{
                failure{
                    jira 'DEPLOYMENT TO PERFORMANCE SERVER FAILED','TEST-12'
                }
            }
        }
        stage('performance test')
       {
           steps
           {
           performance 'performance_test'
           }
           post{
                failure{
                    jira 'PERFORMANCE TEST FAILED','TEST-13'
                }
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
             post{
                failure{
                    jira 'DEPLOYMENT TO PRODUCTION SERVER FAILED','TEST-15'
                }
            }
        }

      
        }
        post{
always{
sendNotifications currentBuild.result
}
}

    }
