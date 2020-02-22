# Airflow D(ocker) O(utside) O(f) D(ocker)

This repository shows you how to spin up Airflow in docker and have it execute docker containers as siblings - ie Docker Outside Of Docker (DOOD). It uses the standard Airflow docker operator.  

### Why Docker
Using Airflow in a docker container makes it very easy to build infrastructure with code and deploy it on any server you like

### Why the docker operator
Using the docker operator you can build more or less any flow in any language you want, wrap it in a Dockerfile and then orchestrate it using Airflow and its docker operator.


## Get started
This shows you how to get started with an R script being executed in Airflow using the docker operator.

1) To get started simply clone this repo.

1) Then, build the docker image:

We tag it with the same tag as the underlying puckel/docker-airflow image.

```
docker build -t airflow_dood_webserver:1.10.8 .
```

3) And run `docker-compose up -d`.

Remember to change `YOUR ABSOLUTE PATH HERE` under volumes in the `dags/docker_rscript.py` file:

```
t2 = DockerOperator(
        task_id='docker_command',
        image='rocker/tidyverse:3.6.1',
        api_version='auto',
        auto_remove=True,
        volumes=['YOUR ABSOLUTE PATH HERE/airflow_dood/rscripts:/rscripts'],
        command='Rscript /rscripts/test.R',
        docker_url='unix://var/run/docker.sock',
        network_mode='bridge'
)
```
