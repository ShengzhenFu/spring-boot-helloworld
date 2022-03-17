pipeline {
    environment {
                DOCKER_HUB_LOGIN = credentials('docker-hub')
            }
    // agent { // Equivalent to "docker build -f Dockerfile . --target=build
    //     dockerfile {
    //         filename 'Dockerfile'
    //         dir '.'
    //         label 'build'
    //         args '--target=build'
    //     } 
    agent { any }
    
    stages {
        stage('Docker login') {
            steps {
                sh 'docker login --username=$DOCKER_HUB_LOGIN_USR --password=$DOCKER_HUB_LOGIN_PSW'
                echo "docker login success ! ${env.BUILD_ID} on ${env.JENKINS_URL}"
            }
        }
        stage('build') {
            steps {
                sh 'docker build . -t shengzhen4docker/ecr:build --target=build'
                echo "build success ! ${env.BUILD_ID} on ${env.JENKINS_URL}"
            }
        }
        stage('test') {
            steps {
                sh 'docker build . -t shengzhen4docker/ecr:test --target=test'
                echo "test success ! ${env.BUILD_ID} on ${env.JENKINS_URL}"
            }
        }
        stage('BuildRuntime') {
            steps {
                sh 'docker build . -t shengzhen4docker/ecr:runtime --target=runtime'
                echo "runtime build success ! ${env.BUILD_ID} on ${env.JENKINS_URL}"
            }
        }    
        stage('Deploy') {
            steps {
                echo "this is where kubectl apply -f deploy.yaml will run"
            }
        }    
    }
}