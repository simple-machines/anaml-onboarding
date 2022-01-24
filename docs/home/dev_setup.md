# Development Setup

Most services will detail their particular development requirements in their respective READMEs, but this is a rough guide for what you'll need when working with most of the PRODUCT_NAME codebases.

You will need to install the following:

* The Google Cloud Platform (GCP) SDK

  [Install instructions](https://cloud.google.com/sdk/docs/install)

  You will then need to run the following commands to log in with your GCP credentials and set the default project:

```shell
$ gcloud auth login

$ gcloud config set project anaml-dev-nonprod
```


* The Java 8 JDK

  [Downloads Archive](https://www.oracle.com/java/technologies/downloads/archive/)

  Alternatively, you can use SDKMAN (detailed below)


* SBT
  
  [Install instructions](https://www.scala-sbt.org/1.x/docs/Setup.html)

  Alternatively, you can use SDKMAN (detailed below)


* Docker

  [Docker Desktop downloads](https://docs.docker.com/get-docker/)

  If you just want the command-line tools, you can instead run the following:

```shell
$ sudo apt-get install docker docker-compose
$ sudo service docker start
$ sudo usermod -aG docker $(whoami)
```


### Using SDKMAN

[Install instructions](https://sdkman.io/install)

#### Installing JDK8:

SDKMAN doesn't keep all versions of each SDK, so these commands will download OpenJDK and register it with SDKMAN to allow for easy switching.

```shell
$ brew tap AdoptOpenJDK/openjdk

$ brew install --cask adoptopenjdk8

# The name "8.0.292-open" here is just a reference for sdkman and does not affect the version installed.
# Check what version was installed by the previous command in order to set a suitable name.
$ sdk install java 8.0.292-open /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home

$ sdk default java 8.0.292-open
```

Verify that the correct installation is being used:

```shell
$ java -version
openjdk version "1.8.0_292"
OpenJDK Runtime Environment (AdoptOpenJDK)(build 1.8.0_292-b10)
OpenJDK 64-Bit Server VM (AdoptOpenJDK)(build 25.292-b10, mixed mode)
```

Some JDK versions are known not to work, so check what you have:
* 1.8.0_271 - known to work
* 1.8.0_292 - known to work
* 1.8.0_312 - known to not work

#### Installing SBT

```shell
# Versions 1.5.5, 1.5.8, 1.6.1 have all been tested and should work.
$ sdk install sbt 1.5.8
```
