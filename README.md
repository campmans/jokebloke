# jokebloke
JokeBloke: Co-creative comedy experience

to generate requirements file enter:
pip freeze > requirements.txt

# Installation instructions

# update conda to the most recent stable version

conda update -n base -c conda-forge conda

# create and activate conda environment

conda create -n jokebloke         # creates new virtual env
conda activate jokebloke    

# install dependencies

conda install ipykernel
pip install -r requirements.txt