FROM cluster-base
LABEL maintainer="zsu58@icloud.com"

ENV PYTHON_VERSION=3.8.10
ARG shared_workspace=/opt/workspace

# Install Python
RUN set -x \
    && apt-get update \
    && apt-get install -y \
    build-essential \
    zlib1g-dev \
    libncurses5-dev \
    libgdbm-dev \
    libnss3-dev \
    libssl-dev \
    libreadline-dev \
    libffi-dev \
    libbz2-dev \
    libsqlite3-dev \
    autoconf \
    && curl -fSL https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz -o /tmp/Python-${PYTHON_VERSION}.tgz \
    && tar -zxvf /tmp/Python-${PYTHON_VERSION}.tgz -C /tmp/ \
    && cd /tmp/Python-${PYTHON_VERSION} \
    && ./configure --enable-optimizations \
    && make altinstall \
    && ln -s /usr/local/bin/python$(echo $PYTHON_VERSION | cut -d "." -f 1-2) /usr/local/bin/python3 \
    && curl -fSL https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py \
    && python3 /tmp/get-pip.py \
    && rm -rf /tmp/Python* \
    && rm -rf /tmp/*.py \
    && rm -rf /var/lib/apt/lists/*

# mecab
RUN set -x \
    && mkdir -p ${shared_workspace} \
    && cd ${shared_workspace} \
    && curl -LO https://bitbucket.org/eunjeon/mecab-ko/downloads/mecab-0.996-ko-0.9.2.tar.gz \
    && tar -zxvf mecab-0.996-ko-0.9.2.tar.gz \
    && cd mecab-0.996-ko-0.9.2 \
    # -- intel
    # && ./configure \
    # -- m1
    && ./configure --build=aarch64-unknown-linux-gnu \
    && make && make check && make install && ldconfig \
    # mecab-ko-dic
    && cd ${shared_workspace} \
    && curl -LO https://bitbucket.org/eunjeon/mecab-ko-dic/downloads/mecab-ko-dic-2.1.1-20180720.tar.gz \
    && tar -zxvf mecab-ko-dic-2.1.1-20180720.tar.gz \
    && cd mecab-ko-dic-2.1.1-20180720 \
    && ./autogen.sh \
    # -- intel
    # && ./configure \
    # -- m1
    && ./configure --build=aarch64-unknown-linux-gnu \
    && make && make install \
    && cd ${shared_workspace} \
    && rm mecab-0.996-ko-0.9.2.tar.gz mecab-ko-dic-2.1.1-20180720.tar.gz

# add jars & make folder src
RUN set -x \
    && cd ${shared_workspace} \
    && mkdir jars \
    && cd jars \
    && curl -LO https://repo1.maven.org/maven2/org/mongodb/spark/mongo-spark-connector_2.12/3.0.1/mongo-spark-connector_2.12-3.0.1.jar \
    && curl -LO https://repo1.maven.org/maven2/org/mongodb/mongodb-driver-core/4.0.5/mongodb-driver-core-4.0.5.jar \
    && curl -LO https://repo1.maven.org/maven2/org/mongodb/mongodb-driver-sync/4.0.5/mongodb-driver-sync-4.0.5.jar \
    && curl -LO https://repo1.maven.org/maven2/org/mongodb/bson/4.0.5/bson-4.0.5.jar \
    && curl -LO https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.21/mysql-connector-java-8.0.21.jar \
    && curl -LO https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.2.3/hadoop-aws-3.2.3.jar \
    && curl -LO https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.901/aws-java-sdk-bundle-1.11.901.jar \
    && mkdir -p /opt/workspace/src
    

RUN pip3 install --upgrade \
    pip \
    setuptools \
    wheel \
    pandas \
    # m1
    # tensorflow==2.6.0 -f https://tf.kmtea.eu/whl/stable.html \
    # intel
    # tensorflow==2.6.0 \
    # scipy \
    # Cython \
    # scikit-learn==0.22.1  \
    # torch \
    JPype1 \
    konlpy \
    mecab-python3 \
    # # kss \
    && pip uninstall -y keras==2.8.0