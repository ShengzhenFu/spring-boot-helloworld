pipeline {
    environment {
                DOCKER_HUB_LOGIN = credentials('docker-hub')
            }
    agent any
    
    stages {
        stage('Docker login') {
            steps {
                sh 'docker login --username=$DOCKER_HUB_LOGIN_USR --password=$DOCKER_HUB_LOGIN_PSW'
                echo "docker login success !"
            }
        }
        stage('Build') {
            steps {
                sh 'docker build . -t shengzhen4docker/ecr:build --target=build'
                echo "build success ! BUILD_ID ${env.BUILD_ID}"
            }
        }
        stage('Test') {
            steps {
                sh 'docker build . -t shengzhen4docker/ecr:test --target=test'
                echo "test success ! BUILD_ID ${env.BUILD_ID}"
            }
        }
        stage('Code Scan') {
            steps {
                echo "Sonarcube code scan goes here"
                echo "generate code scan report"
            }
        }
        stage('BuildRuntime') {
            steps {
                sh ("docker build . -t shengzhen4docker/ecr:runtime${env.BUILD_ID} --target=runtime")
                echo "runtime build success ! BUILD_ID ${env.BUILD_ID}"
            }
        }    
        stage('Push Image') {
            steps {
                sh ("docker push shengzhen4docker/ecr:runtime${env.BUILD_ID}")
                echo "runtime build success ! BUILD_ID ${env.BUILD_ID}"
            }
        }
        stage('Deploy') {
            steps {
                sh "sed -i 'deployment.bak' 's/runtime/runtime${env.BUILD_ID}/g' deployment.yaml"
                sh ("kubectl apply -f deployment.yaml -n springboot")
                echo "deployed to kubernetes !"
            }
        }    
    }
}