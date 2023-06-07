#!/usr/bin/env groovy

node ("EC2"){
  def err = null
  try{
    echo "Hello, World"
    stage('checkout'){
      checkout changelog: false, poll: false, scm: scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'git-credentials', url: 'https://github.com/juancrespo25/bootcamp-proyecto-final.git']])
    }
    withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: "aws-credentials",
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]){
          stage('init') {
            sh 'terraform init'
          }
          stage('Workspace'){
            sh 'terraform workspace new prod'
          }
          stage('Validate'){ 
            sh '''terraform fmt
                terraform validate'''
          }
        }
  }
  catch(caughtError){
        err = caughtError
        currentBuild.result = 'FAILURE'
    }
    finally{
        stage ('Clean'){
            cleanWs()
        }
        if(err) {
            throw err
        }
    }
}
