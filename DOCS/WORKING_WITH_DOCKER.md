

### define the env variables
```bash
MYSQL_ROOT_HOST="%"
MYSQL_DATABASE="tasksdb"
MYSQL_USER="mysql_user"
MYSQL_PASSWORD="SuperSecret"
MYSQL_ROOT_PASSWORD="SuperSecret"

## Variables for api in container
TODO_API_VERSION=v1
APPLICATION_PORT=8080
SPRING_DATASOURCE_USERNAME=mysql_user
SPRING_DATASOURCE_PASSWORD=SuperSecret
SPRING_DATASOURCE_URL=jdbc:mysql://mysqldb:3306/tasksdb
IS_FORMAT_SQL=true
IS_SHOW_SQL=true
HOW_ANSI_OUTPUT_IS_ENABLED=ALWAYS

```


### Define your docker-compose.override.yaml
```yaml
version: '3.7'

services: 
  db:    
    volumes:
      - ./scripts/init.sql:/docker-entrypoint-initdb.d/setup.sql 
      - springboot-task-tracker-mysql-api-volume:/var/lib/mysql
    env_file:
      - .env_container    
    environment:
      - SOME_DB_VAR=SOME_DB_VALUE
    healthcheck:
      test: ["CMD", "mysqladmin" ,"ping", "-h", "localhost"]

  api:
    build: 
      context: .
      target: development
    profiles: ["backend"]
    depends_on:
      db:
        condition: service_healthy
    env_file:
      - .env_container
    environment:
      - SOME_API_VAR=SOME_API_VALUE
    volumes:
      - .:/app
    command: sh mvnw spring-boot:run

```

#### build your production image
```bash
docker build --target demo -t springboot-task-tracker-mysql-k8s:v1 .

docker build --target production -t springboot-task-tracker-mysql-k8s:v1 .
```

### set images
```bash
docker_registry_name="<SET_YOUR_DOCKER_USER_NAME>"
docker tag springboot-task-tracker-mysql-k8s:v1 $docker_registry_name/springboot-task-tracker-mysql-k8s:v1
docker push $docker_registry_name/springboot-task-tracker-mysql-k8s:v1
```



### work with compose
```bash
# start only the database
docker compose up -d

# start the api
docker compose --profile backend up -d

# start 3 replicas of the api container containers
docker compose --profile backend up -d --scale api=3

#
docker compose --profile repository up -d

#
docker compose --profile backend down 

#
docker compose --profile repository down

docker compose down 
```

---

## References


- ['docker-compose' creating multiple instances for the same image](https://stackoverflow.com/questions/39663096/docker-compose-creating-multiple-instances-for-the-same-image)
- [Docker-compose check if mysql connection is ready](https://stackoverflow.com/questions/42567475/docker-compose-check-if-mysql-connection-is-ready)