pipeline {
    agent any
    environment {
        // 定義 Docker Compose 檔案名稱
        COMPOSE_FILE = 'docker-compose.v3.yaml'
        // 定義服務名稱（根據你的 docker-compose.yaml）
        SERVICE_NAME = 'web1'
    }
    stages {
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