# python-ci-template

[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![CI - Build and Test](https://github.com/CGnal/python-ci-template/actions/workflows/continous-integration.yml/badge.svg)](https://github.com/CGnal/python-ci-template/actions/workflows/continous-integration.yml)

This is a template project to be used as a standard, for any Python project.

## Makefile 

The process of installation of requirements, packaging, running checks (static typing, linting, unittests, etc) is 
done using Makefile. In order to setup and environment that compile and then install all requirements 
we can simply issue the following commands

```
make setup    # to install requirments
make dist     # to build the package
make install  # to install package
make checks   # to run all checks
```

For further information on the make commands, type

```
make help
```


## Requirements

This project uses ``pip-tools`` to keep track of requirements. In particular there is a ``requirements`` folder 
containing a ``requirements.in, requirements.txt, requirements_ci.in, requirements_ci.txt`` files corresponding to 
input (``*.in``) and actual (``*.txt``) requirements files for CI and prod environments.


## Coding style and linting

This project uses ``black`` (https://github.com/psf/black) for formatting and enforcing a coding style.
Execute ``black src`` to reformat all source code files according to PEP 8 specifications.

We use ``flake8`` () for static code analysis. The configuration file is located in the root: ``.flake8``.
It coincides with the configuration suggested by the ``black`` developers.

We use ``mypy`` for static type checking. The configuration file is located in the root: ``.mypy.ini``.
The only settings included in this configuration files are related to the missing typing annotations of some common third party libraries.

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