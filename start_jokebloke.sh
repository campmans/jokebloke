#!/bin/bash

# JokeBloke Voilà Launcher
# This script starts the JokeBloke web application using Voilà

# Activate conda environment if it exists
if [ -d "$HOME/miniconda3/envs/jokebloke" ] || [ -d "$HOME/anaconda3/envs/jokebloke" ]; then
    echo "Activating jokebloke conda environment..."
    eval "$(conda shell.bash hook)"
    conda activate jokebloke
fi

# Check if GEMINI_API_KEY is set
if [ -z "$GEMINI_API_KEY" ]; then
    echo "⚠️  Warning: GEMINI_API_KEY environment variable is not set!"
    echo "Please set it with: export GEMINI_API_KEY='your-api-key'"
    echo "Get your API key from: https://aistudio.google.com/apikey"
    echo ""
    read -p "Press Enter to continue anyway, or Ctrl+C to exit..."
fi

# Start Voilà
echo "🎭 Starting JokeBloke web application..."
echo "📱 The app will open in your browser automatically"
echo "🛑 Press Ctrl+C to stop the server"
echo ""

voila jokebloke.ipynb \
    --template=lab \
    --theme=dark \
    --no-browser \
    --port=8866 \
    --Voila.ip='0.0.0.0' \
    --VoilaConfiguration.file_whitelist="['.*']" \
    --enable_nbextensions=True &

# Wait for server to start
sleep 3

# Open browser
if command -v xdg-open > /dev/null; then
    xdg-open http://localhost:8866
elif command -v open > /dev/null; then
    open http://localhost:8866
else
    echo "🌐 Open your browser to: http://localhost:8866"
fi

# Wait for Voilà process
wait
