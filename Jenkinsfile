pipeline {
    environment {
        dockerhubCredentials = 'dockerhub'
    }
    agent any
    stages {
        stage('Lint HTML') {
            steps {
                dir('app') {
                    sh 'tidy -q -e *.html'
                }
            }
        }
        stage('Lint Dockerfile') {
            steps {
                script {
                    dir('app') {
                            docker.image('hadolint/hadolint:latest-debian').inside() {
                                sh 'hadolint ./Dockerfile | tee -a hadolint_lint.txt'
                                sh '''
                                    lintErrors=$(stat --printf="%s"  hadolint_lint.txt)
                                    if [ "$lintErrors" -gt "0" ]; then
                                        echo "Errors have been found, please see below"
                                        cat hadolint_lint.txt
                                    exit 1
                                    else
                                        echo "There are no erros found on Dockerfile!!"
                                    fi
                                '''
                            }
                        }
                }
            }
        }

        stage('Build & Push to dockerhub') {
            steps {
                script {
                    dir('app') {
                        dockerImage = docker.build("pras1905/udacity-static-capstone:${env.BUILD_ID}")
                        docker.withRegistry('', dockerhubCredentials) {
                            dockerImage.push("${env.BUILD_ID}")
                        }
                    }
                }
            }
        }

        stage('Deploying to EKS') {
            steps {
                dir('k8s') {
                    withAWS(credentials: 'mini', region: 'us-west-2') {
                            sh "aws eks --region us-west-2 update-kubeconfig --name capstone-eks-cluster-EKS-Cluster"
                        }
                    }
            }
        }
        stage('Apply service.yaml') {
			steps {
                dir('k8s') {
				withAWS(region:'us-west-2', credentials:'mini') {
					    sh '''
						    kubectl apply -f service.yaml
					    '''
                    				}
				}
			}
		}
        stage('Apply deploy.yaml') {
			steps {
                		dir('k8s') {
				    withAWS(region:'us-west-2', credentials:'mini') {
			    sh "kubectl apply -f deploy.yaml"
                            sh "kubectl set image --record -f deploy.yaml capstone-image=pras1905/udacity-static-capstone:${env.BUILD_ID}"
                  								  }
				}
			}
		}
            }
}
