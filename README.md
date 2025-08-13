# nginx-practice
Practice of setup nginx with docker:

## Practice 1: Standalone Web
```
docker compose -f docker compose -f docker-compose-2standaloneweb.yaml up -d
```

Result:
We can visit: 
- [http://localhost:8081](http://localhost:8081)
- [http://localhost:8082](http://localhost:8082)


## Practice 2: Web with Loadbalance setup
```
docker compose -f docker compose -f docker-compose-3webslb.yaml up -d
```

Result:
When can visit [http://localhost:1000](http://localhost:1000), load balance (round-robin) works and offload the work to 
- [http://localhost:8081](http://localhost:8081)
- [http://localhost:8082](http://locahost:8082)
- [http://localhost:8083](http://localhost:8083) [backup]


## Practice 3: Build web as image
```
docker compose -f docker compose -f docker-compose.build.yaml build
docker compose -f docker compose -f docker-compose.build.yaml up -d
```

Result:
1. web1:v0.1.0 image is build
2. web2 and web3 is setup with web1 image
3. [http://localhost:1000](http://localhost:1000) offload the work to:
    - [http://localhost:8081](http://localhost:8081)
    - [http://localhost:8082](http://locahost:8082)
    - [http://localhost:8083](http://localhost:8083) [backup]


## Practice 4: Simple CICD with Jenkin
With the setup of practice 3, create CICD pipeline with Jenkins. 

### To start jenkins docker:
```
docker compose -f docker compose -f docker-compose.jenkins.yaml up -d
```

### Jenkins 1st time startup 
1. Open file at [your project folder]/jenkins_home/logs/jenkins/secrets/initialAdminPassword
2. Visit [http://localhost:9000](http://localhost:9000)
3. Enter the initialAdminPassword and wait for the setup
4. Install following plugin in Jenkins
    - Docker Pipeline
    - Blue Ocean

### Install Docker-Compose
Since we are using docker-compose to manage our docker images and containers, we have to install docker-compose cli into Jenkins container

1. Download correct docker-compose from Github to host computer
    ```
    curl -L https://github.com/docker/compose/releases/download/v2.31.0/docker-compose-linux-aarch64 -o docker-compose
    ```

2. Copy docker-compose into Jenkins container
    ```
    docker cp docker-compose jenkins:/usr/local/bin/docker-compose
    docker exec -u root jenkins chmod +x /usr/local/bin/docker-compose
    ```

3. Run to check docker-compose execution inside Jenkins container
    At host
    ```
    docker exec -it [jenkins container] bash
    ```

    Inside Jenkins container
    ```
    docker-compose version
    ```
    
You should be returned the version no. of docker-compose as you downloaded before.

### Create Job in Jenkins (Jenkins pipeline)
1. Login to Jenkins
2. Click "New Item" -> "Pipeline"
3. In Pipeline session:
    | Key | Values |
    | - | - |
    | Definition | Pipeline script from SCM
    | SCM | Git |
    | Respository URL | Your github repo |
    | Creditials | Select existing creditial or create new creditial, see [Create Git credential in Jenkins](#create-git-credential-in-jenkins) |
    | Branch Specifier | */[your target branch] |
    | Script Path | Jenkinsfile |
4. Click "Save"
5. Click "Build Now"


### Create Git credential in Jenkins<a name="create-git-credential-in-jenkins" />
1. In Jenkins, goto "Manage Jenkins"
2. Goto "Credentials"
3. Click "System" in "Stores scoped to Jenkins"
4. Click "Global credentials (unrestricted)"
5. Click "Add Credentials"
6. In New credentials:
    | Key       | Values                              |
    | --------- |:----------------------------------- |
    | Kind      | Username with password              |
    | Scope     | Global                              |
    | Username: | [Your github username]              |
    | Password: | [Your github Personal Access Token] |
7. Click "Create"

Reference: 
- [Creating a personal access token (classic)](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-personal-access-token-classic)