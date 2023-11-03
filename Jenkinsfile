@Library('my-shared-library') _

pipeline {
    agent any

    parameters{
        choice(name: 'action', choices: 'create\ndelete', description: 'Choose create/Destroy')
        string(name: 'aws_account_id', description: " AWS Account ID", defaultValue: '988320610889')
        string(name: 'Region', description: "Region of ECR", defaultValue: 'us-east-1')
        string(name: 'ECR_REPO_NAME', description: "name of the ECR", defaultValue: 'react')
    }

    environment{
        ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID')
        SECRET_KEY = credentials('AWS_SECRET_KEY_ID')
    }

    stages {

        stage('Git Checkout'){
        when { expression {  params.action == 'create' } }
            steps{
                     gitCheckout(
                        branch: "master",
                        url: "https://github.com/harshid9125/React-Jenkins-AWS.git"
                     )
                 }
        }

        stage('Pre-build') {
        when { expression {  params.action == 'create' } }
            steps {
                sh 'echo Installing source NPM dependencies...'
                sh 'npm install'
            }
        }

        stage('Build') {
        when { expression {  params.action == 'create' } }
            steps {
                sh 'echo Build started on `date`'
                sh 'npm run build'
            }
        }

        stage('Docker Image Build'){
         when { expression {  params.action == 'create' } }
            steps{
               script{
                   
                   dockerBuild("${params.ImageName}","${params.ImageTag}","${params.DockerHubUser}")
               }
            }
        }

        stage('Docker Image Build : ECR'){
        when { expression {  params.action == 'create' } }
            steps{
               script{
                   dockerBuild("${params.aws_account_id}","${params.Region}","${params.ECR_REPO_NAME}")
               }
            }
        }

        stage('Docker Image Push : ECR'){
        when { expression {  params.action == 'create' } }
            steps{
               script{
                   dockerImagePush("${params.aws_account_id}","${params.Region}","${params.ECR_REPO_NAME}","${ACCESS_KEY}", "${SECRET_KEY}")
               }
            }
        }

        stage('Docker Image Cleanup : ECR '){
        when { expression {  params.action == 'create' } }
            steps{
               script{
                   dockerImageCleanup("${params.aws_account_id}","${params.Region}","${params.ECR_REPO_NAME}")
               }
            }
        }
    }
}