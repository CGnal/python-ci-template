# python-docker

[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![CI - Build and Test](https://github.com/CGnal/python-ci-template/actions/workflows/continous-integration.yml/badge.svg)](https://github.com/CGnal/python-ci-template/actions/workflows/continous-integration.yml)

This is a template project to be used as a standard, for any Python project.

## Requirements

This project uses ``black`` to format code and ``flake8`` for linting. We also support ``pre-commit`` to ensure
these have been run. To configure your local environment please install these development dependencies and set up
the commit hooks.

```
$ pip install black flake8 pre-commit
$ pre-commit install
```

We can check everything works correctly by running pre-commit manually.

```
$ pre-commit run --all-files
```

## Versioning ans Semantic Version

```
$ pip install versioneer
```

Add the versioneer section in the setup.cfg
