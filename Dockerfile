FROM ubuntu:focal

ENV APPTEMP_PATH=/srv/apptemp \
    DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC

ENV APPTEMP_SRC=${APPTEMP_PATH}/src APPTEMP_DATA=${APPTEMP_PATH}/data

RUN apt-get update && apt-get install -y \
    nginx \
    postgresql \
    python3 \
    python3-pip \
    python3-venv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p ${APPTEMP_DATA} ${APPTEMP_SRC} /srv/nginx /srv/postgres

# Copied separately to prevent rebuilds
COPY requirements.txt ${APPTEMP_SRC}/

RUN cd ${APPTEMP_SRC} && \
    python3 -m venv venv && \
    . venv/bin/activate && \
    pip install -r requirements.txt

COPY docker-entrypoint.sh /usr/local/bin/
COPY src ${APPTEMP_SRC}

WORKDIR ${APPTEMP_SRC}

RUN . venv/bin/activate && \
    pylint apptemp && \
    flake8 --exclude=venv apptemp

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["venv/bin/gunicorn", "-b", "localhost:20000", "-w", "2", "apptemp:app"]
