pipeline {
  
  agent {
    docker {
        image 'kekcment/boxf:0.1.1'
        args '--privileged -v /var/run/docker.sock:/var/run/docker.sock -u root'
    }
  }   

  stages {
      
    stage('Copy source from git') {
      steps {
        echo 'git clone'
        git 'https://github.com/kekcment/sertification.git'
      }
    }    
    
    stage('Build War') {
      steps {
        echo 'Build War'
        sh 'mvn package'
      }
    }

    stage('Show file War') {
      steps {
        echo 'ShoW file War'
        sh 'cd /tmp/sertification'
        sh 'ls /tmp/sertification'
      }
    }
    
//     stage('Make docker image') {
//       steps {
//         echo 'Build image'
//         sh 'docker build -t hw .'          
//         }
//       }
    
//     stage('Tag image') {
//       steps {
//         echo 'Tag image'
//         sh 'docker tag hw kekcment/hw'

//         }
//     }

//     stage('Push image') {
//       steps {
//         echo 'Push image'
//         sh 'docker push kekcment/hw'
//         }
//     }

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