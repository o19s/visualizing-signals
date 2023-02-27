# Visualizing E-Commerce Search Signals
A Practical Introduction to Exploring and Visualizing E-Commerce Search Signal Data

This repository is accompanying the blog post ["Visualize e-commerce search signal data with SQL & Apache Superset"](https://opensourceconnections.com/blog/2022/08/17/visualize-ecommerce-search-signal/)

The signal data set of AI-Powered Search by Trey Grainger, Doug Turnbull and Max Irwin (https://www.manning.com/books/ai-powered-search) is used, stored in PostgreSQL and visualized with Apache Superset to derive insights from the data.

You can clone the repository and just run the quickstart.sh script if you want to choose the easy way.

Alternatively, you can follow the step-by-step approach that guides you through all the setup tasks.

## Prerequisites:
- Docker
- Ports 8080 and 5432 are free
- At least 6GB of RAM should be enough to run the containers

## Quickstart

Clone the repository:

`git clone https://github.com/wrigleyDan/visualizing-signals.git`

Change into the directory of the cloned repo:

`cd visualizing-signals`

Run the quickstart.sh script:

`./quickstart.sh`

Sit back and wait for the script to complete.

Access Superset by visiting http://localhost:8080.
Login via username `admin` and password `admin`.

## Step-by-Step Setup

Download and extract the data. We'll be using the signals data from the AI-Powered Search book (https://www.manning.com/books/ai-powered-search)

```
wget https://github.com/ai-powered-search/retrotech/raw/master/signals.tgz
tar xzvf signals.tgz
mv signals.csv data
```

Run Postgres and populate it with the downloaded signal data

`docker-compose up -d`

Run Apache Superset container on port 8080 connected to the network in which the Postgres db is running

`docker run -d -p 8080:8088 --network="superset" --name superset apache/superset`

Create an admin user

```
docker exec -it superset superset fab create-admin \
              --username admin \
              --firstname Superset \
              --lastname Admin \
              --email admin@superset.com \
              --password admin
```

Upgrade internal database

`docker exec -it superset superset db upgrade`

Initialize Apache Superset

`docker exec -it superset superset init`

Log in to Superset by visiting http://localhost:8080 with the username `admin` and the password `admin`

## Exploring Data and Creating Visualizations

Follow the blog post ["Exploring and Visualizing E-Commerce Search Signal Data - a Practical Introduction"](www.o19s.com/blog) and let me know if you have any questions!
