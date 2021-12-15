pipeline {
    agent any
    tools {
        terraform 'terraform-11'
    }

    stages {
        stage('Setup Parameters') {
            steps {
                script {
                    properties([
                        parameters([
                            string(
                                defaultValue: 'tf-provision-gke-cluster',
                                description: 'This parameter decides the name of terraform workspace',
                                name: 'NAME_TF_WORKSPACE'
                            )
                        ])
                    ])
                }
            }
        }

        stage('Get GCP Access Token') {
            steps {
                script {
                    sh '''cd /opt/ServiceAccount/syndeno-sandbox
                    ./accesstoken.sh
                    cat GCP_ACCESS_TOKEN.txt
                    '''
                }
            }
        }

        stage('Git Checkout') {
            steps {
                git credentialsId: 'c94f1316-a4c0-4691-b147-32f390296144', url: 'https://github.com/VietNguyen408/learn-terraform-provision-gke-cluster'
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    sh '''
                    export TF_VAR_access_token=$(cat /opt/ServiceAccount/syndeno-sandbox/GCP_ACCESS_TOKEN.txt)
                    terraform init -reconfigure -force-copy -backend-config="access_token=$TF_VAR_access_token" || terraform init -migrate-state -force-copy -backend-config="access_token=$TF_VAR_access_token"
                    terraform workspace select ${NAME_TF_WORKSPACE} || terraform workspace new ${NAME_TF_WORKSPACE}
                    terraform workspace show
                    terraform workspace list
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    sh '''
                    export TF_VAR_access_token=$(cat /opt/ServiceAccount/syndeno-sandbox/GCP_ACCESS_TOKEN.txt)
                    terraform apply --auto-approve
                    terraform output
                    echo TF_OUTPUT=$(terraform output) > tf_output.txt
                    cat tf_output.txt
                    '''
                }
            }
        }  
    }
    post {
            always {
                archiveArtifacts artifacts: 'tf_output.txt', onlyIfSuccessful: true
            }
        }
}
