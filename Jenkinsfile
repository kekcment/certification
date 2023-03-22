pipeline {
  
  agent {
    docker {
        image 'kekcment/jdk-plus:0.1.0'
        args '--privileged -v /var/run/docker.sock:/var/run/docker.sock -u root'
    }
  }   

  stages {
      
     stage('get project') {
            steps {
                echo 'git clone'
                git 'https://github.com/kekcment/ya_ter.git'
            }
        }

        stage('test terraform run') {
            steps {
                sh 'terraform -chdir=build_tf/ init'
                sh 'terraform -chdir=build_tf/ plan'
                sh 'terraform -chdir=build_tf/ apply -auto-approve'
            }
        }
    
       
    
    stage('Copy source from git') {
      steps {
        echo 'git clone'
        sh 'cd /tmp/'
        git 'https://github.com/kekcment/certification.git'
      }
    }    
    
    stage('Build War') {
      steps {
        echo 'Build War'
        sh 'mvn package'
      }
    }


    stage('Make docker image') {
      steps {
        echo 'Build image'
        sh 'docker build -t prod .'          
        }
      }
    
    stage('Tag image') {
      steps {
        echo 'Tag image'
        sh 'docker tag prod kekcment/prod'
        }
    }

    stage('Push image') {
      steps {
        echo 'Push image'
        sh 'docker push kekcment/prod'
        }
    }

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