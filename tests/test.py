import os
import pytest


def test_python():
    stream = os.popen("python --version")
    output = stream.read()
    assert "3.9" in output


@pytest.mark.parametrize(
    "env_variable,command",
    [
        ("BASH_CLI_VERSION", "bash --version"),
        ("CURL_CLI_VERSION", "curl --version"),
        ("AWS_CLI_VERSION", "aws --version"),
        ("TERRAFORM_CLI_VERSION", "terraform -version"),
        ("KUBECTL_CLI_VERSION", "kubectl version --client"),
        ("HELM_CLI_VERSION", "helm version"),
        ("JQ_CLI_VERSION", "jq --version"),
    ],
)
def test_cli_version(env_variable, command):
    stream = os.popen(command)
    output = stream.read()
    version = str(os.environ.get(env_variable)).split("-")[0]
    assert version in output
