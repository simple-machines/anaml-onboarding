# Anaml Onboarding

This is the Anaml Onboarding guide served with [MkDocs Material](https://squidfunk.github.io/mkdocs-material).

## Editing

If using VSCode, install the https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker extension for spell checking.

Enable the language setting `en-GB` in the extension language settings.

## Installation

Clone the Anaml python sdk repository in the same directory of the directory containing this repository.

```
git clone git@github.com:simple-machines/anaml-python-sdk.git
```

```
pip install mkdocs-material mkdocstrings isodate
```

## Serving

You will need to install the anaml-client wheel, if you haven't already done so.

```
pip install anaml-client
```

Run the following to serve a copy of the docs locally with hot reloading

```
$ PYTHONPATH=anaml-python-sdk/src mkdocs serve
```

## Building Docker Container

```
$ docker build . -t anaml-onboarding
```

## Running from the docker container

```
$ docker run -d -p 8000:80 anaml-onboarding
```
