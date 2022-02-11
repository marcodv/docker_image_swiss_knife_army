# Swiss army knife image

This project contains an image with multiple tools already installed.
This allows us to use multiple tools in the same pipeline job

## versions

| docker image | aws-cli | terraform | terraform-docs | kubectl | helm  | jq  | curl      | bash     | openssl   |
| ---          | ---     | ---       | ----           | ---     | ---   | --- | ---       | ---      | ---       |
| **1.0.0**    | 2.1.39  | 1.1.3     | 0.16.0         | 1.23.3  | 3.8.0 | 1.6 | 7.80.0-r0 | 5.1.8-ro | -         |
| **1.1.0**    | 2.1.39  | 1.1.3     | 0.16.0         | 1.23.3  | 3.8.0 | 1.6 | 7.80.0-r0 | 5.1.8-ro | 1.1.1l-r8 |

## releases

release an new version by adding a git tag to the main branch.
This will trigger a pipeline to pushish a docker image with the tag name.
Please use the semanitic versioning for the git tag
