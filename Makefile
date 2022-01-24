# Signifies our desired python version
# Makefile macros (or variables) are defined a little bit differently than traditional bash, keep in mind that in the Makefile there's top-level Makefile-only syntax, and everything else is bash script syntax.
PYTHON = python

# .PHONY defines parts of the makefile that are not dependant on any specific file
# This is most often used to store functions
.PHONY = help

folders := src tests
files := $(shell find . -name "*.py")
doc_files := $(shell find sphinx -name "*.*")

# Uncomment to store cache installation in the environment
# package_dir := $(shell python -c 'import site; print(site.getsitepackages()[0])')
package_dir := .make_cache
package_name=$(shell python -c "import configparser;config=configparser.ConfigParser();config.read('setup.cfg');print(config['metadata']['name'])")

$(shell mkdir -p $(package_dir))

pre_deps_tag := $(package_dir)/.pre_deps
env_tag := $(package_dir)/.env_tag
env_dev_tag := $(package_dir)/.env_dev_tag
install_tag := $(package_dir)/.install_tag

# ======================
# Rules and Dependencies
# ======================

help:
	@echo "---------------HELP-----------------"
	@echo "Package Name: $(package_name)"
	@echo " "
	@echo "Type 'make' followed by one of these keywords:"
	@echo " "
	@echo "  - init for setting up the project"
	@echo "  - setup for installing base requirements"
	@echo "  - setup_dev for installing requirements for development"
	@echo "  - format for reformatting files to adhere to PEP8 standards"
	@echo "  - dist for building a tar.gz distribution"
	@echo "  - install for installing the package"
	@echo "  - uninstall for uninstalling the environment"
	@echo "  - tests for running unittests"
	@echo "  - lint for performing linting"
	@echo "  - mypy for performing static typing checks"
	@echo "  - docs for producing self-documentation"
	@echo "  - clean for removing cache file"
	@echo "------------------------------------"


$(pre_deps_tag):
	grep "^pip-tools\|^black"  requirements/requirements_dev.in | xargs ${PYTHON} -m pip install
	touch $(pre_deps_tag)

init: $(pre_deps_tag)
	@echo "This is for initializing the repository"

requirements/requirements.txt: requirements/requirements.in $(pre_deps_tag)
	pip-compile --output-file=requirements/requirements.txt --quiet --no-emit-index-url requirements/requirements.in

reqs: requirements/requirements.txt

requirements/requirements_dev.txt: requirements/requirements_dev.in requirements/requirements.txt
	pip-compile --output-file=requirements/requirements_dev.txt --quiet --no-emit-index-url requirements/requirements.txt requirements/requirements_dev.in

reqs_dev: requirements/requirements_dev.txt

$(env_tag): requirements/requirements.txt
	pip-sync requirements/requirements.txt
	rm -f $(env_dev_tag)
	touch $(env_tag)

$(env_dev_tag): requirements/requirements_dev.txt
	pip-sync requirements/requirements_dev.txt
	rm -f $(env_tag)
	touch $(env_dev_tag)

setup: $(env_tag)

setup_dev: $(env_dev_tag)

format:
	${PYTHON} -m black $(folders)

dist/.build-tag: $(files)
	python setup.py sdist
	ls -rt  dist/* | tail -1 > dist/.build-tag

dist: format dist/.build-tag

$(install_tag): dist/.build-tag
	${PYTHON} -m pip install $(shell ls -rt  dist/* | tail -1)
	touch $(install_tag)

uninstall:
	@echo "Uninstall package $(package_name)"
	pip uninstall -y $(package_name)
	pip freeze | grep -v "^-e" | xargs pip uninstall -y
	rm -f $(env_tag) $(env_dev_tag) $(pre_deps_tag) $(install_tag)

install: $(install_tag)

tests: setup_dev install 
	${PYTHON} -m pytest

mypy: setup_dev install 
	mypy --follow-imports silent $(folders)

lint: setup_dev
	flake8 $(folders)

checks: mypy lint tests

docs: $(doc_files)
	cd sphinx && make html

clean: uninstall
	rm -rf docs
	rm -rf $(shell find . -name "*.pyc") $(shell find . -name "__pycache__")
	rm -rf dist *.egg-info .mypy_cache .pytest_cache .make_cache $(env_tag) $(env_dev_tag) $(install_tag)
