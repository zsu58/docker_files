FROM python:3.8-slim
LABEL maintainer="zsu58@icloud.com"

# Aiflow Version & Home
ARG AIRFLOW_VERSION=2.0.2
ARG AIRFLOW_HOME=/opt/airflow
ENV AIRFLOW_HOME=${AIRFLOW_HOME}

# Install Dependencies & Tools
RUN apt-get update -yqq \
    && apt-get upgrade -yqq \
    && apt-get install -yqq --no-install-recommends \ 
    wget \
    libczmq-dev \
    curl \
    libssl-dev \
    git \
    inetutils-telnet \
    bind9utils freetds-dev \
    libkrb5-dev \
    libsasl2-dev \
    libffi-dev libpq-dev \
    freetds-bin build-essential \
    default-libmysqlclient-dev \
    apt-utils \
    rsync \
    zip \
    unzip \
    gcc \
    vim \
    locales \
    && apt-get clean

COPY ./constraints-3.8.txt /constraints-3.8.txt

# Upgrade pip & Create airflow user & Install apache airflow with subpackages
RUN pip install --upgrade pip \
    && useradd -ms /bin/bash -d ${AIRFLOW_HOME} airflow \
    && pip install apache-airflow[postgres]==${AIRFLOW_VERSION} --constraint /constraints-3.8.txt

# Set the owner of the files in AIRFLOW_HOME to the user airflow
# & Set the username to use & working dir for the container
RUN chown -R airflow: ${AIRFLOW_HOME}
USER airflow
WORKDIR ${AIRFLOW_HOME}

# mkdir dags and indicate that the 8080 port should be exposed
RUN mkdir dags
EXPOSE 8080

# add entrypoint.sh & execute the entrypoint.sh
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
