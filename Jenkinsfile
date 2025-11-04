pipeline {
    agent any

    parameters {
        booleanParam(
            name: 'TERRAFORM_PLAN',
            defaultValue: false,
            description: 'Check to plan TF changes'
        )
        booleanParam(
            name: 'TERRAFORM_APPLY',
            defaultValue: false,
            description: 'Check to apply TF changes'
        )
        booleanParam(
            name: 'TERRAFORM_DESTROY',
            defaultValue: false,
            description: 'Check to destroy TF manages resources'
        )
    }

    stages {
        stage('Clone Repository') {
            steps{
                deleteDir()

                git branch: 'main', url: 'https://github.com/DEEZY4U/RTDOP-01-JK-Infra.git'

                sh 'ls -lart'
            }
        }

        stage('Terraform Init') {
            steps{
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-deez']]) {
                    dir('infra') {
                        sh 'echo "===== Terraform Init ====="'
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps{
                script {
                    if (params.TERRAFORM_PLAN) {
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-deez']]) {
                            dir('infra') {
                                sh 'echo "===== Terraform Plan ====="'
                                sh 'terraform plan'
                            }
                        }
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps{
                script {
                    if (params.TERRAFORM_APPLY) {
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-deez']]) {
                            dir('infra') {
                                sh 'echo "===== Terraform Apply ====="'
                                sh 'terraform apply -auto-approve'
                            }
                        }
                    }
                }
            }
        }

        stage('Terraform Destroy') {
            steps{
                script {
                    if (params.TERRAFORM_DESTROY) {
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-deez']]) {
                            dir('infra') {
                                sh 'echo "===== Terraform Destroy ====="'
                                sh 'terraform destroy -auto-approve'
                            }
                        }
                    }
                }
            }
        }
    }
}
