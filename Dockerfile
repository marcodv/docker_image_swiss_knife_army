ARG PYTHON_VERSION=3.9
ARG PYTHON_BASE=alpine

FROM python:${PYTHON_VERSION}-${PYTHON_BASE} as python

ARG APP_HOME=/app

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

ENV BASH_CLI_VERSION=5.1.8-r0
ENV TERRAFORM_CLI_VERSION=1.1.3
ENV AWS_CLI_VERSION=2.1.39
ENV CURL_CLI_VERSION=7.80.0-r0
ENV KUBECTL_CLI_VERSION=v1.23.3

RUN apk update && apk upgrade && apk add \
    musl-dev \
    gcompat \
    bash=${BASH_CLI_VERSION} \
    curl=${CURL_CLI_VERSION}

RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_CLI_VERSION}/terraform_${TERRAFORM_CLI_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_CLI_VERSION}_linux_amd64.zip && rm terraform_${TERRAFORM_CLI_VERSION}_linux_amd64.zip && \
    mv terraform /usr/bin/terraform

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VERSION}.zip" -o "/tmp/awscliv2.zip" && \
    unzip /tmp/awscliv2.zip -d /tmp && \
    /tmp/aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli

RUN curl "https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_CLI_VERSION}/bin/linux/amd64/kubectl" -o "/tmp/kubectl" && \
    chmod +x /tmp/kubectl && \
    mv /tmp/kubectl /usr/local/bin/kubectl

WORKDIR ${APP_HOME}

COPY requirements.txt requirements.txt
RUN pip install -r ./requirements.txt

COPY . .

