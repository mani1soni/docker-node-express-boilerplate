pipeline{
    agent any
    environment{
        NODE_ENV='stag'
    }
    stages{
        stage("test"){
            steps{
                sh '''
                bash testapp.sh  docker-node-express-boilerplate_app 
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
                bash testecr.sh  docker-node-express-boilerplate_app  5000
                '''
            } 
        }
        stage("push to ECR"){
            steps{
                script{
                    withDockerRegistry(credentialsId: 'ecr:ap-south-1:aws ecr', url: 'https://981144953497.dkr.ecr.ap-south-1.amazonaws.com') {
                        sh '''
                        bash push.sh  docker-node-express-boilerplate_app  981144953497.dkr.ecr.ap-south-1.amazonaws.com/docker-node-express-boilerplate_app-${NODE_ENV}
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
            '''
            emailext attachLog: true, body: '''$DEFAULT_CONTENT  test failed and rollback initiated''', subject: '$DEFAULT_SUBJECT', to: 'manish.soni@techifysolutions.com'
        }
    }
}

