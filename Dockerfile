ARG PYTHON_VERSION=3.9
ARG PYTHON_BASE=alpine

FROM python:${PYTHON_VERSION}-${PYTHON_BASE} as python

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

ENV BASH_CLI_VERSION=5.1.16-r0
ENV TERRAFORM_CLI_VERSION=1.1.3
ENV TERRAFORM_DOCS_CLI_VERSION=0.16.0
ENV AWS_CLI_VERSION=2.1.39
ENV CURL_CLI_VERSION=7.80.0-r0
ENV KUBECTL_CLI_VERSION=v1.23.3
ENV HELM_CLI_VERSION=3.8.1
ENV JQ_CLI_VERSION=1.6
ENV OPENSSL_CLI_VERSION=1.1.1l-r8

RUN apk update && apk upgrade && apk add \
    # package needed for awscliv2
    musl-dev \ 
    # package needed for awscliv2
    gcompat \
    openssh \
    curl

# terraform cli
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_CLI_VERSION}/terraform_${TERRAFORM_CLI_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_CLI_VERSION}_linux_amd64.zip && rm terraform_${TERRAFORM_CLI_VERSION}_linux_amd64.zip && \
    mv terraform /usr/bin/terraform

# terraform docs cli
RUN curl -Lo /tmp/terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/v${TERRAFORM_DOCS_CLI_VERSION}/terraform-docs-v${TERRAFORM_DOCS_CLI_VERSION}-linux-amd64.tar.gz && \
    tar -xzf /tmp/terraform-docs.tar.gz && \
    rm /tmp/terraform-docs.tar.gz && \
    chmod +x terraform-docs && \
    mv terraform-docs /usr/local/bin/terraform-docs

# aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VERSION}.zip" -o "/tmp/awscliv2.zip" && \
    unzip /tmp/awscliv2.zip -d /tmp && rm /tmp/awscliv2.zip && \
    /tmp/aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli && \
    rm -R /tmp/aws

# kubectl cli
RUN curl "https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_CLI_VERSION}/bin/linux/amd64/kubectl" -o "/tmp/kubectl" && \
    chmod +x /tmp/kubectl && \
    mv /tmp/kubectl /usr/local/bin/kubectl

# helm cli
RUN wget "https://get.helm.sh/helm-v${HELM_CLI_VERSION}-linux-amd64.tar.gz" -P "/tmp" && \
    tar -zxvf /tmp/helm-v${HELM_CLI_VERSION}-linux-amd64.tar.gz && \
    rm /tmp/helm-v${HELM_CLI_VERSION}-linux-amd64.tar.gz && \
    mv ./linux-amd64/helm /usr/local/bin/helm && \
    rm -R ./linux-amd64

# jq cli
RUN wget "https://github.com/stedolan/jq/releases/download/jq-${JQ_CLI_VERSION}/jq-linux64" -P "/tmp/" && \
    chmod +x /tmp/jq-linux64 && \
    mv /tmp/jq-linux64 /usr/local/bin/jq

FROM python as development 

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip install -r ./requirements.txt

COPY . .

