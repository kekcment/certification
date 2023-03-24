pipeline {
  
  agent any

  stages {
      
    stage('Copy source from git') {
      steps {
        echo 'git clone'
        git 'https://github.com/kekcment/certification.git'
      }
    }  

    stage('Build VM1') {
      steps {        
        sh 'terraform -chdir=build_tf/ init'
        sh 'terraform -chdir=build_tf/ plan'
        sh 'terraform -chdir=build_tf/ apply -auto-approve && export ANSIBLE_HOST_KEY_CHECKING=False'
      }
    } 
    
    stage('Build Java project') {
      steps {
        ansiblePlaybook credentialsId: 'ubuild', inventory: '/tmp/hosts', playbook: 'playbook_build.yml'
      }
    }   
    
    stage('Destroy VM1') {
      steps {
        sh 'terraform -chdir=build_tf/ destroy -auto-approve'
      }
    }   
  
    stage('Build VM2') {
      steps {
        sh 'terraform -chdir=prod_tf/ init'
        sh 'terraform -chdir=prod_tf/ plan'
        sh 'terraform -chdir=prod_tf/ apply -auto-approve'
      }
    } 

    stage('Build application on VM2') {
      steps {
        ansiblePlaybook credentialsId: 'ubuild', inventory: '/tmp/hosts', playbook: 'playbook_prod.yml'
      }
    } 

}
}