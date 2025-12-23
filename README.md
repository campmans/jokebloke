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

# create conda python <= 3.12

conda create -n "jokebloke" python=3.12.4 ipython
conda activate jokebloke    

# install dependencies

conda install ipykernel #probably not needed
pip install -r requirements.txt

# install spacy

python -m spacy download en_core_web_sm

# install npm locally

# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"

# Download and install Node.js:
nvm install 24

# Verify the Node.js version:
node -v # Should print "v24.12.0".

# Verify npm version:
npm -v # Should print "11.6.2".

# install command line CLI
npm install -g @google/gemini-cli

# install Gemini API key into user


# to run in browser:
voila jokebloke.ipynb