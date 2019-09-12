pipeline{
    agent any
    environment{
        NODE_ENV='stage'
    }
    stages{
        stage("test"){
            steps{
                sh '''
                npm i
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
                sh stage-backup.sh docker-node-express-boilerplate_app_1 
                ''' 
            }
        }
        stage("build and deploy"){
            steps{
                sh '''
                sh stage-build-and-deploy.sh docker-node-express-boilerplate_app_1  5000
                '''
            } 
        }
        stage("push to ECR"){
            steps{
                sh '''
                sh push.sh docker-node-express-boilerplate_app_1  manisomanish/docker-node-express-boilerplate_app_1 
                '''
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

