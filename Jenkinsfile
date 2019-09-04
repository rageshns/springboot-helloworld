pipeline {
  agent {
    node {
      label 'test'
    }

  }
  stages {
    stage('checkout') {
      steps {
        echo 'test1'
      }
    }
    stage('compile') {
      steps {
        sleep 5
      }
    }
    stage('build') {
      steps {
        sh 'hello'
      }
    }
    stage('end') {
      steps {
        echo 'end'
      }
    }
  }
}