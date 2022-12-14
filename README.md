# Building an End-to-End Open-Source Modern Data Platform for Biomedical Data

This workshop at [PyBCN 2022](https://pybcn.org/events/pyday_bcn/pyday_bcn_2022/) is a detailed guide to help you navigate the modern data stack and build your own platform using open-source technologies. Data engineering has experiences enormous growth in the last years, allowing for rapid progress and innovation as more people than ever are thinking about data resources and how to better leverage them. In this talk we will explore the related technologies and build from scratch an end-to-end modern data platform for the analysis of medical data. 

We will be using open-source tools and libraries, including python-based [DBT](https://getdbt.com/), [Apache Airflow](https://airflow.apache.org) and [Querybook](https://www.querybook.org/). 

The platform will consist of the following components: 
 - Data warehouse 
 - Data integration 
 - Data transformation 
 - Data orchestration 
 - Data visualization


## INSTALL REQUIREMENTS

- Install [Python](https://www.python.org/downloads/)
- Install [Java](https://www.java.com/en/download/help/download_options.html)
- Install [docker](https://docs.docker.com/engine/install/)
  - in Linux edit your /etc/hosts and add `172.17.0.1 docker.host.internal`

## INSTALL COMPONENTS

- Download [synthea](https://synthetichealth.github.io/synthea/) patient data generator: [synthea-with-dependencies.jar](https://github.com/synthetichealth/synthea/releases/download/master-branch-latest/synthea-with-dependencies.jar)
- Install [Dremio](https://www.dremio.com/): `docker pull dremio/dremio-oss`
- Install [PostgreSQL](https://www.postgresql.org): `docker pull postgres` 
  - Install [psql](https://www.timescale.com/blog/how-to-install-psql-on-mac-ubuntu-debian-windows/)
  - Install a SQL client such as [PgAdmin](https://www.pgadmin.org/) or [DBeaver](https://dbeaver.io/)
- Install [DBT](https://docs.getdbt.com/docs/get-started/pip-install): `pip install dbt-postgres dbt-dremio`
- Install [Airflow](https://airflow.apache.org/docs/apache-airflow/stable/start.html)
- Install [Querybook](https://github.com/pinterest/querybook)
- Install [Datahub](https://datahubproject.io/docs/quickstart/)

## Have a drink, and relax ...

![](https://i.ytimg.com/vi/y3TxcejHw-4/hqdefault.jpg)
- https://www.youtube.com/watch?v=y3TxcejHw-4

## FIRST STEPS

- Clone this repo

```
git clone https://github.com/alabarga/pybcn22-modern-data-stack.git
``` 

- Generate or download [synthetic data](https://github.com/alabarga/pybcn22-modern-data-stack/blob/main/synthea/)



