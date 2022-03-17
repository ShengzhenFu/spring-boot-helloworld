pipeline {
  agent {
    kubernetes {
      //cloud 'kubernetes'
      defaultContainer 'kaniko'
      yaml """
kind: Pod
spec:
  serviceAccountName: jenkins-sa
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:latest
    imagePullPolicy: Always
    args: ["--dockerfile=Dockerfile",
            "--context=git@github.com:ShengzhenFu/spring-boot-helloworld.git#refs/heads/release",
            "--destination=shengzhen4docker/ecr:v1"]
    volumeMounts:
    - name: kaniko-secret
      mountPath: "/kaniko/.docker"
  volumes:
  - name: kaniko-secret
    secret:
      secretName: docker
      items:
       - key: .dockerconfigjson
         path: config.json
  restartPolicy: Never
"""
    }
  }
  stages {
      stage(build) {
          steps {
              sh '/kaniko/executor -f `pwd`/Dockerfile -c `pwd` --target=build --cache=true --destination=shengzhen4docker/ecr:build'
          }
      }
  }