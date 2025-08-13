pipeline {
    agent any
    environment {
        // 定義 Docker Compose 檔案名稱
        COMPOSE_FILE = 'docker-compose.v4.yaml'
        // 定義服務名稱（根據你的 docker-compose.yaml）
        SERVICE_NAME = 'web1'
    }
    stages {
        stage('Checkout from GitHub')
            steps {
                script {
                    // 1. 从GitHub检出代码（含标签信息）
                    checkout scm

                    // 2. 获取最新标签（按版本号排序取最新）
                    def tags = sh(
                        script: 'git tag --sort=-v:refname | head -n 1',
                        returnStdout: true
                    ).trim()
                    
                    if (tags.isEmpty()) {
                        error "未找到Git标签！"
                    }
                    
                    // 3. 将标签存储到环境变量
                    env.APP_VERSION = tags
                    echo "使用的Git标签: ${env.APP_VERSION}"                    
                }
            }
        stage('Build') {
            steps {
                script {
                    // 使用 Docker Compose 構建鏡像
                    sh "docker-compose -f ${env.COMPOSE_FILE} build"
                }
            }
        }
        stage('Run') {
            steps {
                script {
                    // 停止並移除舊容器
                    sh "docker-compose -f ${env.COMPOSE_FILE} down web1 || true"
                    // 啟動新容器（後台運行）
                    sh "docker-compose -f ${env.COMPOSE_FILE} up -d web1" 
                }
            }
        }
    }
}