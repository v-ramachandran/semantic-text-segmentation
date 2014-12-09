from setuptools import setup

setup(
    name = "semantic-text-segmentation",
    version = 1.0,
    author = "Venketaram Ramachandran",
    author_email = "v.ram28@gmail.com",
    url = "http://v-ramachandran.github.io/semantic-text-segmentation",
    install_requires = ["segeval", "sentence2vec", "pandas"],
    dependency_links =
        ["http://github.com/v-ramachandran/sentence2vec/tarball/master#egg=sentence2vec-1.0"]
)
