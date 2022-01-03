import os
import setuptools
import versioneer

with open(os.path.join("requirements", "requirements.txt"), "r") as fid:
    requirements = [
        line.replace("\n", "")
        for line in fid.readlines()
        if not line.strip(" ").startswith("#")
    ]

setuptools.setup(
    version=versioneer.get_version(),
    cmdclass=versioneer.get_cmdclass(),
    install_requires=requirements,
)
