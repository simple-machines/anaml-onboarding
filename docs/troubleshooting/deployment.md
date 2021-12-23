# Troubleshooting Problems That Occur During Deployment

## `anaml-ui` indicates `(unhealthy)`

The status of the docker containers can be checked with the following command:

```sh
docker ps -a --format '{{.Names}} {{.Status}}'
```

If the `anaml-ui` docker container indicates that it is `unhealthy`, ensure that you have exported the following environment variables:

* `ANAML_ADMIN_PASSWORD`
* `ANAML_ADMIN_TOKEN`
* `ANAML_ADMIN_SECRET`

You can check the values for these environment variables with a command such as:

```sh
echo $ANAML_ADMIN_PASSWORD
```

Alternatively, install the `direnv` tool, which will pick up these variables from an `.envrc` file if it exists in the project.

```
brew install direnv
```

---

## docker.errors.DockerException: Error while fetching server API version

When running `docker-compose`, you may encounter the following error:

```
docker.errors.DockerException: Error while fetching server API version: ('Connection aborted.', PermissionError(13, 'Permission denied'))
[1887] Failed to execute script docker-compose
```

Ensure your user is in the `docker` group. This can be determined by executing the `groups` command. This will list all the groups for your user. Ensure that `docker` is one of the listed groups. If this is not the case:

* Run the command `sudo usermod -aG docker $USER`
* Log out and log back in to the machine
* Run the `groups` command to ensure your user is in the `docker` group

---

## ERROR: gcloud failed to load

When running `docker-compose`, you may encounter an error similar to the following:

```
ERROR: gcloud failed to load: /tmp/.../libssl.so.1.1: version `OPENSSL_1_1_1' not found
  ...
This usually indicates corruption in your gcloud installation or problems with your Python interpreter.

Please verify that the following is the path to a working Python 2.7 or 3.5+ executable:
    /usr/bin/python3

If it is not, please set the CLOUDSDK_PYTHON environment variable to point to a working Python 2.7 or 3.5+ executable.

...

docker.errors.DockerException: Credentials store error: StoreError('Credentials store docker-credential-gcloud exited with "".')
  [7337] Failed to execute script docker-compose
```

Ensure you set the `CLOUDSDK_PYTHON` environment variable to point to a python 2 executable. For example:

```sh
export CLOUDSDK_PYTHON=/usr/bin/python2
```

You can check that you have set this environment variable correctly by executing the following command:

```sh
`$CLOUDSDK_PYTHON --version`
```

!!! Tip
This environment variable settings is generally required on Ubuntu Linux with its default setup. Other operating systems may also require this to be set.

---

## Traceback (most recent call last):

When running `docker-compose`, you may encounter an error similar to the following:

```
Traceback (most recent call last):
  ...
FileNotFoundError: [Errno 2] No such file or directory
```

This error is encountered when the docker service has not been started. The service can be started with the following command:

```sh
sudo systemctl enable docker.service && sudo systemctl start docker.service
```

The service can be verified that it is running with the following command:

```sh
sudo systemctl status docker.service
```

You should then see `active (running)` in the output.

---

## Warnings about environment variables not set

When running `docker-compose`, you may encounter one or more of the following warnings:

```
WARNING: The ANAML_ADMIN_PASSWORD variable is not set. Defaulting to a blank string.
WARNING: The ANAML_ADMIN_TOKEN variable is not set. Defaulting to a blank string.
WARNING: The ANAML_ADMIN_SECRET variable is not set. Defaulting to a blank string.
```

Ensure you have set all three of these environment variables. This can be done by observing their value with the following commands:

```sh
echo $ANAML_ADMIN_PASSWORD
echo $ANAML_ADMIN_TOKEN
echo $ANAML_ADMIN_SECRET
```

If you have not set one or more of these environment variables, ensure each is set e.g.

```sh
export ANAML_ADMIN_PASSWORD="my password"
```

Alternatively, install the `direnv` tool, which will pick up these variables from an `.envrc` file if it exists in the project.

```
brew install direnv
```

Next, stop the docker process before trying again:

```sh
docker-compose down
```

---

## ERROR: unauthorized

When running `docker-compose`, you may encounter an error similar to the following:

```
ERROR: unauthorized: You don't have the needed permissions to perform this operation, and you may have invalid credentials. To authenticate your request, follow the steps in: https://cloud.google.com/container-registry/docs/advanced-authentication
```

This indicates that your user is not authenticated to the Google Cloud Platform (GCP).

If you have not already, run the command which will log you into the GCP and configure docker for GCP.

```sh
gcloud init
gcloud auth configure-docker
```

If you have already run `gcloud init` and you are still encountering this error, re-authenticate to the Google Cloud Platform:

```sh
gcloud auth login
gcloud auth configure-docker
```