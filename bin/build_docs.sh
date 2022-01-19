#!/usr/bin/env bash

sphinx-build -b html "sphinx/source" "docs"
touch "/docs/.nojekyll"