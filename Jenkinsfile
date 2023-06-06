#!/usr/bin/env groovy

node ("EC2"){
    echo "Hello, World"
    stage('checkout'){
      checkout changelog: false, poll: false, scm: scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'git-credentials', url: 'https://github.com/juancrespo25/bootcamp-proyecto-final.git']])
    }
    stage('init') {
      sh 'terraform init'
    }
    stage('Validate'){ 
      sh '''terraform fmt
          terraforma validate'''
    }
}
