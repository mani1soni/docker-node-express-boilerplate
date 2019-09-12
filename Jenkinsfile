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
                npm test
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
                sh stage-backup.sh gateway
                ''' 
            }
        }
        stage("build and deploy"){
            steps{
                sh '''
                sh stage-build-and-deploy.sh gateway 5000
                '''
            } 
        }
        stage("push to ECR"){
            steps{
                sh '''
                sh push.sh gateway manisomanish/gateway
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
            sh '''
            sh stage-rollback.sh gateway 5000
            '''
            emailext attachLog: true, body: '''$DEFAULT_CONTENT  test failed and rollback initiated''', subject: '$DEFAULT_SUBJECT', to: 'manish.soni@techifysolutions.com'
        }
    }
}

