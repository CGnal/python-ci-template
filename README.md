# python-ci-template

[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![CI - Build and Test](https://github.com/CGnal/python-ci-template/actions/workflows/continous-integration.yml/badge.svg)](https://github.com/CGnal/python-ci-template/actions/workflows/continous-integration.yml)

This is a template project to be used as a standard, for any Python project.

## Requirements

This project uses ``pip-tools`` to keep track of requirements. In particular there is a ``requirements`` folder 
containing a ``requirements.in, requirements.txt, requirements_dev.in, requirements_dev.txt`` files corresponding to 
input (``*.in``) and actual (``*.txt``) requirements files for dev and prod environments.

## Pre-commit hooks
We use ``pre-commit`` to ensure that any update in input requirements files is correctly reflected in actual files.
Furthermore this project uses pre-commit hooks with ``black`` to format code and ``flake8`` for linting. 
To configure your local environment please install the development dependencies and set up
the commit hooks.

```
$ pip install -r requirements/requirements_dev.txt
$ pre-commit install
```

We can check everything works correctly by running pre-commit manually.

```
$ pre-commit run --all-files
```

## Versioning and Semantic Version

The present repository had already set up the versioneer using the procedure described below. 
No need to re-run it. To change configuration parameters (e.g. parentdir_prefix) we simply need to edit the ``setup.cfg`` file.  

### Verisioneer setup

1. First of all we need to install the versioneer package from pip
```
$ pip install versioneer
```

2. Then we edit the versioneer section in the setup.cfg

```
[versioneer]
VCS = git
style = pep440
versionfile_source = version/_version.py
versionfile_build = version/_version.py
tag_prefix =
parentdir_prefix = <the-project-name>
```

3. Next, we need to install the versioneer module into our project.
```
versioneer install
```

Running this command will create a few new files for us in our project and also ask us to make some changes to our setup.py file. We need to import versioneer in the setup, replace the version keyword argument with versioneer.get_version() and add a new argument cmdclass=versioneer.get_cmdclass().

```

setuptools.setup(
    ...
    version=versioneer.get_version(),
    cmdclass=versioneer.get_cmdclass(),
    ...
)
```
 for full documentation [versioneer GitHub repo](https://github.com/python-versioneer/python-versioneer)