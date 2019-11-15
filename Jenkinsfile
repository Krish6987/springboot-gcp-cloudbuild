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
       /*stage('Security scan') {
            steps {
            sendNotifications 'security scan started'
             scan 'SCAN'
            }
            post{
                failure{
                    jira 'SECURITY SCAN FAILED','TEST-4'
                }
            }
       }*/
  
            stage("Nexus") {
            steps {
          sendNotifications  'NEXUS STAGE STARTED'
          
        }
        when { branch "feature1" }
        steps{
          withCredentials([usernamePassword(credentialsId: 'nexus_creds', passwordVariable: 'password', usernameVariable:'username')]) {
              sh 'curl -u ${username}:${password} --upload-file target/springboot-0.0.1-SNAPSHOT.war http://ec2-18-224-155-110.us-east-2.compute.amazonaws.com:8081/nexus/content/repositories/devopstraining/hexagon6/springboot-0.0.1-SNAPSHOT-feature-$BUILD_NUMBER.war'
         }
         }
         when { branch "developer" }
         steps{
          withCredentials([usernamePassword(credentialsId: 'nexus_creds', passwordVariable: 'password', usernameVariable:'username')]) {
              sh 'curl -u ${username}:${password} --upload-file target/springboot-0.0.1-SNAPSHOT.war http://ec2-18-224-155-110.us-east-2.compute.amazonaws.com:8081/nexus/content/repositories/devopstraining/hexagon6/springboot-0.0.1-SNAPSHOT-developer-$BUILD_NUMBER.war'
         }
         }
         when { branch "master" }
         steps{
          withCredentials([usernamePassword(credentialsId: 'nexus_creds', passwordVariable: 'password', usernameVariable:'username')]) {
              sh 'curl -u ${username}:${password} --upload-file target/springboot-0.0.1-SNAPSHOT.war http://ec2-18-224-155-110.us-east-2.compute.amazonaws.com:8081/nexus/content/repositories/devopstraining/hexagon6/springboot-0.0.1-SNAPSHOT-master-$BUILD_NUMBER.war'
         }
         }
         when { branch "release" }
         steps{
          withCredentials([usernamePassword(credentialsId: 'nexus_creds', passwordVariable: 'password', usernameVariable:'username')]) {
              sh 'curl -u ${username}:${password} --upload-file target/springboot-0.0.1-SNAPSHOT.war http://ec2-18-224-155-110.us-east-2.compute.amazonaws.com:8081/nexus/content/repositories/devopstraining/hexagon6/springboot-0.0.1-SNAPSHOT-release-$BUILD_NUMBER.war'
         }
         }
        post{
                failure{
                    jira 'NEXUS UPLOADING FAILED','TEST-5'
                }
            }
        }
         stage('Deploy to Development'){
            when { branch "feature1" }
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
        } 
        when{ branch "developer"}
         steps{
            sh 'scp -i /var/lib/jenkins/.ssh/id_rsa -r /var/lib/jenkins/workspace/springboot-demo_developer/target/springboot-0.0.1-SNAPSHOT.war ansadmin@172.31.31.91:/projects/developer/playfile.yml'
          }
        when{ branch "master"}
         steps{
            sh 'scp -i /var/lib/jenkins/.ssh/id_rsa -r /var/lib/jenkins/workspace/springboot-demo_master/target/springboot-0.0.1-SNAPSHOT.war ansadmin@172.31.31.91:/projects/developer/performance.yml'
          }
        when{ branch "release"}
         steps{
            sh 'scp -i /var/lib/jenkins/.ssh/id_rsa -r /var/lib/jenkins/workspace/springboot-demo_release/target/springboot-0.0.1-SNAPSHOT.war ansadmin@172.31.31.91:/projects/developer/production.yml'
          }
        }

            post{
                failure{
                    jira 'DEPLOY TO ANSIBLE MASTER FAILED','TEST-7'
                }
            }
        }
        
        stage('Approval1'){
        when { branch "developer" }
                steps{
                approval 'APPROVAL'
                }
                }
                
        stage('Deploy to Test Server'){
        when { branch "developer" }
             steps{
                 sendNotifications 'Deploy to Test Server'
                 deploy_test 'deploy_test'
             }
             post{
                failure{
                    jira 'DEPLOYMENT TO TEST SERVER FAILED','TEST-9'
                }
            }
        }
          stage('functional test')
    {
    when{ branch "developer" }
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
        when{ branch "master" }
                steps{
                approval1 'APPROVAL1'
                }
                }
        stage('Deploy to Performance Server'){
        when { branch "master" }
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
       when{ branch "master" }
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
        when{ branch "release" }
                steps{
                approval2 'APPROVAL1'
                }
                }
        stage('Deploy to Production Server'){
        when { branch "release" }
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
        /*post{
always{
sendNotifications currentBuild.result
}
}*/

    }
