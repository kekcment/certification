pipeline {
  
  // agent {
  //   docker {
  //       image 'kekcment/jdk-plus:0.1.0'
  //       args '--privileged -v /var/run/docker.sock:/var/run/docker.sock -u root'
  //   }
  // }   

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
        sh 'terraform -chdir=build_tf/ apply -auto-approve'
      }
    } 
    
    stage('Build Java project') {
      steps {
        ansiblePlaybook credentialsId: 'ubuild', inventory: '/tmp/hosts', playbook: 'playbook_build.yml'
      }
    }   
    
    stage('Destroy VM1') {
      steps {
        sh 'terraform -chdir=build_tf/ destroy'
      }
    }   
  
    stage('Build VM2') {
      steps {
        sh 'terraform -chdir=prod_tf/ init'
        sh 'terraform -chdir=prod_tf/ plan'
        sh 'terraform -chdir=prod_tf/ apply -auto-approve'
      }
    } 

    stage('Push Java project on Project') {
      steps {
        ansiblePlaybook credentialsId: 'ubuild', inventory: '/tmp/hosts', playbook: 'playbook_prod.yml'
      }
    } 


    // stage('Make docker image') {
    //   steps {
    //     echo 'Build image'
    //     sh 'docker build -t prod .'          
    //   }
    // }
    
    // stage('Tag image') {
    //   steps {
    //     echo 'Tag image'
    //     sh 'docker tag prod kekcment/prod'
    //   }
    // }

    // stage('Push image') {
    //   steps {
    //     echo 'Push image'
    //     sh 'docker push kekcment/prod'
    //     }
    // }

//     stage('Deploy on slave1') {
//       steps {
//         sh '''ssh -tt root@84.201.177.23 << EOF
// 	      sudo docker pull kekcment/hw && sudo docker run -d -p 8088:8080 kekcment/hw
//         exit      
//         EOF'''
//       }
//     }

}
}