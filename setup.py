from setuptools import setup
from gradesc import __version__

with open("README.md", "r") as fh:
    readme = fh.read()

setup(
    name="gradesc",
    version=__version__,
    # url="",
    license="MIT License",
    author="Eduardo M. de Morais",
    long_description=readme,
    long_description_content_type="text/markdown",
    author_email="emdemor415@gmail.com",
    keywords="",
    description=u"Simple Gradient Descent implementation",
    packages=["gradesc"],
    install_requires=["numpy", "pandas", "setuptools"],
)
