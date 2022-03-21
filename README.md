# spring-boot-helloworld



[![Jenkins](/pictures/jenkinsPipeline.png "Jenkins, pipeline for Springboot")](https://github.com/ShengzhenFu/spring-boot-helloworld/blob/main/pictures/jenkinsPipeline.png)


TODO
add SonarQube server to scan code after unit test, for code scan

```
        stage('Sonar scan execution') {
            // Run the sonar scan
            steps {
                script {
                    def mvnHome = tool 'Maven 3.3.9'
                    withSonarQubeEnv {

                        sh "'${mvnHome}/bin/mvn'  verify sonar:sonar -Dintegration-tests.skip=true -Dmaven.test.failure.ignore=true"
                    }
                }
            }
        }
        // waiting for sonar results based into the configured web hook in Sonar server which push the status back to jenkins
        stage('Sonar scan result check') {
            steps {
                timeout(time: 2, unit: 'MINUTES') {
                    retry(3) {
                        script {
                            def qg = waitForQualityGate()
                            if (qg.status != 'OK') {
                                error "Pipeline aborted due to quality gate failure: ${qg.status}"
                            }
                        }
                    }
                }
            }
        }
```