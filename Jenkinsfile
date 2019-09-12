pipeline{
    agent any
    environment{
        NODE_ENV='stage'
    }
    stages{
        stage("test"){
            steps{
                sh '''
                echo "ok"
                '''
            }
            post {
                failure {
                    emailext attachLog: true, body: '''$DEFAULT_CONTENT  test failed and rollback initiated''', subject: '$DEFAULT_SUBJECT', to: 'manish.soni@techifysolutions.com'    
                }
            } 
        }
        stage("backup"){
            steps{
                //sh '''
                //bash stage-backup.sh  docker-node-express-boilerplate_app
                //'''
                echo "done" 
            }
        }
        stage("build and deploy"){
            steps{
                sh '''
                bash stage-build-and-deploy.sh  docker-node-express-boilerplate_app  5000
                '''
            } 
        }
        stage("push to ECR"){
            steps{
                script{
                    withDockerRegistry(credentialsId: 'dockerhub', url: 'https://index.docker.io/v1/') {
                        sh '''
                        bash push.sh  docker-node-express-boilerplate_app  manisomanish/docker-node-express-boilerplate_app
                        '''
                    }
                }
            }
        }
    }
    post {
        success {
            emailext attachLog: true, 
            body: '''$DEFAULT_CONTENT''', 
            subject: '$DEFAULT_SUBJECT', 
            to: 'manish.soni@techifysolutions.com'
        }
        failure {
            emailext attachLog: true, body: '''$DEFAULT_CONTENT  test failed and rollback initiated''', subject: '$DEFAULT_SUBJECT', to: 'manish.soni@techifysolutions.com'
        }
    }
}

