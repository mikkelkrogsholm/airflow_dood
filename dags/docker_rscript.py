from airflow import DAG
from datetime import datetime, timedelta

# Operators
from airflow.operators.bash_operator import BashOperator
from airflow.operators.docker_operator import DockerOperator

# Default dag arguments
default_args = {
        'owner'                 : 'airflow',
        'description'           : 'Use of the DockerOperator',
        'depend_on_past'        : False,
        'start_date'            : datetime(2020, 2, 12),
        'email_on_failure'      : False,
        'email_on_retry'        : False,
        'retries'               : 1,
        'retry_delay'           : timedelta(minutes=5)
}

with DAG('docker_dag_rscript', default_args=default_args, schedule_interval="5 * * * *", catchup=False) as dag:

        t1 = BashOperator(
                task_id='print_current_date',
                bash_command='date'
        )

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

        t3 = BashOperator(
                task_id='print_hello',
                bash_command='echo "hello world"'
        )

        t1 >> t2 >> t3
