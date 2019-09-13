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
                sh '''
                bash stage-backup.sh  docker-node-express-boilerplate_app
                ''' 
            }
        }
        stage("build and deploy"){
            steps{
                sh '''
                bash stage-build-and-deploy.sh  docker-node-express-boilerplate_app  5000
                docker exec docker-node-express-boilerplate_app npm test /home/nodejs/app
                '''
            } 
        }
        stage("push to ECR"){
            steps{
                script{
                    withDockerRegistry(credentialsId: 'ecr:ap-south-1:aws ecr', url: 'https://981144953497.dkr.ecr.ap-south-1.amazonaws.com') {
                        sh '''
                        bash push.sh  docker-node-express-boilerplate_app  981144953497.dkr.ecr.ap-south-1.amazonaws.com/${NODE_ENV}-docker-node-express-boilerplate_app
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
            sh '''
            bash stage-rollback.sh docker-node-express-boilerplate_app 5000
            emailext attachLog: true, body: '''$DEFAULT_CONTENT  test failed and rollback initiated''', subject: '$DEFAULT_SUBJECT', to: 'manish.soni@techifysolutions.com'
        }
    }
}

