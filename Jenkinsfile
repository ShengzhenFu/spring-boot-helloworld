pipeline {
    environment {
                DOCKER_HUB_LOGIN = credentials('docker-hub')
                VERSION = ${env.BUILD_ID}
            }
    agent any
    
    stages {
        stage('Docker login') {
            steps {
                sh 'docker login --username=$DOCKER_HUB_LOGIN_USR --password=$DOCKER_HUB_LOGIN_PSW'
                echo "docker login success !"
            }
        }
        stage('build') {
            steps {
                sh 'docker build . -t shengzhen4docker/ecr:build --target=build'
                echo "build success ! BUILD_ID ${env.BUILD_ID}, VERSION ${VERSION}"
            }
        }
        stage('test') {
            steps {
                sh 'docker build . -t shengzhen4docker/ecr:test --target=test'
                echo "test success ! BUILD_ID ${env.BUILD_ID}, VERSION ${VERSION}"
            }
        }
        stage('BuildRuntime') {
            steps {
                sh 'docker build . -t shengzhen4docker/ecr:runtime${VERSION} --target=runtime'
                echo "runtime build success ! BUILD_ID ${env.BUILD_ID}, VERSION ${VERSION}"
            }
        }    
        stage('Push Image') {
            steps {
                sh 'docker push shengzhen4docker/ecr:runtime${VERSION}'
                echo "runtime build success ! BUILD_ID ${env.BUILD_ID}, VERSION ${VERSION}"
            }
        }
        stage('Deploy') {
            steps {
                echo "this is where kubectl apply -f deploy.yaml will run"
            }
        }    
    }
}