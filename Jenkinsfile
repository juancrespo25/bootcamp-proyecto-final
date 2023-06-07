#!/usr/bin/env groovy
properties([parameters([booleanParam(defaultValue: false, name: 'destroy')]), pipelineTriggers([GenericTrigger(causeString: 'Generic Cause', regexpFilterExpression: '', regexpFilterText: '', token: 'terraform-pipeline', tokenCredentialId: '')])])
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
          stage('Validate'){ 
            sh '''terraform fmt
                terraform validate'''
          }
          stage('Plan'){
            sh 'terraform plan --var-file=environments/prod.tfvars'
          }
          if (params.destroy){
              stage ('Destroy'){
                sh "terraform destroy --var-file=environments/prod.tfvars -auto-approve -lock=false"
              }
          }
          else {
              stage('Apply'){
                sh 'terraform apply --var-file=environments/prod.tfvars --auto-approve=true -lock=false'
              }
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
