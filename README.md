# python-ci-template

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

## Versioning and Semantic Version

```
$ pip install versioneer
```

Add the versioneer section in the setup.cfg

```
[versioneer]
VCS = git
style = pep440
versionfile_source = version/_version.py
versionfile_build = version/_version.py
tag_prefix =
parentdir_prefix = <the-project-name>
```

Next, we need to install the versioneer module into our project.
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