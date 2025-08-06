# nginx-practice
Practice of setup nginx with docker

## Practice 1: Standalone Web
```
docker compose -f docker compose -f docker-compose-2standaloneweb.yaml up -d
```

Result:
We can visit: 
[http://localhost:8081](http://localhost:8081)
[http://localhost:8082](http://localhost:8082)


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



