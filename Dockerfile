ARG PYTHON_VERSION=3.9
ARG PYTHON_BASE=alpine

FROM python:${PYTHON_VERSION}-${PYTHON_BASE} as python

ARG APP_HOME=/app

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

WORKDIR ${APP_HOME}

COPY requirements.txt requirements.txt
RUN pip install -r ./requirements.txt

COPY . .

