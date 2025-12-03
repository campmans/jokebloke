# jokebloke
JokeBloke: Co-creative comedy experience

to generate requirements file enter:
pip freeze > requirements.txt

# Installation instructions

# install conda if not yet installed

Install conda or miniconda, if not yet installed:
https://www.anaconda.com/docs/getting-started/miniconda/main

# update conda to the most recent stable version

conda update -n base -c conda-forge conda

# create and activate conda environment

conda create -n jokebloke         # creates new virtual env
conda activate jokebloke    

# install dependencies

conda install ipykernel #probably not needed
pip install -r requirements.txt

# to run in browser:
voila jokebloke.ipynb