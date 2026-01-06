# JokeBloke
JokeBloke: Co-creative comedy experience. Talk to the system, and it automatically replies in a funny way.

# Installation

1. Install anaconda (or miniconda on windows)
2. `conda env create -f environment.yml`
3. `conda activate jokebloke`
4. `python -m spacy download en_core_web_sm`

To use the Gemini API:
1. Get your free API key on the gemini website and select the smallest gemini model that has the free tier
1. In `jokebloke.ipynb`, replace `joker_agent = LLMCLIJokerAgent(os.getcwd()/Path("prompts"))`, with `joker_agent = LLMAPIJokerAgent(os.getcwd()/Path("prompts"), YOUR_API_KEY_HERE)`

To use the Gemini CLI if you have Gemini Pro:
1. Install the gemini CLI https://geminicli.com/docs/get-started/

Only use the Gemini CLI if you have a Gemini pro subscription to use the large token limits.

# Running JokeBloke

```py
voila jokebloke.ipynb
```