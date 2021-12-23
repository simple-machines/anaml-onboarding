# Troubleshooting Problems That Occur During Setup

## ConfluentAvroDecoder.scala:84:16: ambiguous reference to overloaded definition,

When attempting to build and run a project using `sbt`, you may see the following error:

```
ConfluentAvroDecoder.scala:84:16: ambiguous reference to overloaded definition,
[error] both method limit in class ByteBuffer of type (x$1: Int)java.nio.ByteBuffer
[error] and  method limit in class Buffer of type ()Int
[error] match expected type ?
[error]         buffer.limit - 1 - 4
[error]                ^
```

This indicates a version incompatibility with your current versions of Java and SBT.
Ensure you are using Java 8 and a compatible version of SBT (1.5.5 and 1.5.8 seem to work fine).

---

## ERROR: unauthorized

When attempting to build and run a project using `sbt`, you may see the following error:

```
Pulling spark-master (gcr.io/anaml-release-artifacts/anaml-spark-server:latest)...
ERROR: unauthorized: You don't have the needed permissions to perform this operation, and you may have invalid credentials. To authenticate your request, follow the steps in: https://cloud.google.com/container-registry/docs/advanced-authentication
```

This indicates that your user is not authenticated to the Google Cloud Platform (GCP).

Make sure that you have created a GCP account and have been added to the Simple Machines organisation.
You then need to download and install the gcp-sdk then log in, as described in the [Development Setup](../home/dev_setup.md) guide.

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
