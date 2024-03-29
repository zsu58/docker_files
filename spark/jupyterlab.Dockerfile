FROM cluster-base
LABEL maintainer="zsu58@icloud.com"

# -- Layer: JupyterLab
ARG spark_version=3.1.2
ARG jupyterlab_version=2.2.6

RUN pip3 install wget pyspark==${spark_version} jupyterlab==${jupyterlab_version}

# -- Runtime
EXPOSE 8888
WORKDIR ${SHARED_WORKSPACE}
CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token=
