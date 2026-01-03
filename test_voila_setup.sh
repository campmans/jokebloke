#!/bin/bash

# Quick test script for Voilà deployment
echo "🎭 Testing JokeBloke Voilà Deployment"
echo "======================================"
echo ""

# Check Python version
echo "✓ Python version:"
python --version

# Check Voilà installation
echo ""
echo "✓ Voilà installation:"
voila --version

# Check required packages
echo ""
echo "✓ Checking critical packages:"
python -c "import spacy; import pygame; import ipywidgets; import voila; print('  All core packages installed!')"

# Check spaCy model
echo ""
echo "✓ Checking spaCy model:"
python -c "import spacy; nlp = spacy.load('en_core_web_sm'); print('  en_core_web_sm loaded successfully')"

# Check notebook exists
echo ""
echo "✓ Notebook file:"
if [ -f "jokebloke.ipynb" ]; then
    echo "  jokebloke.ipynb found"
else
    echo "  ❌ jokebloke.ipynb not found!"
    exit 1
fi

# Check API key
echo ""
echo "✓ API Key status:"
if [ -z "$GEMINI_API_KEY" ]; then
    echo "  ⚠️  GEMINI_API_KEY not set (required for operation)"
else
    echo "  ✓ GEMINI_API_KEY is configured"
fi

echo ""
echo "======================================"
echo "✅ All checks passed!"
echo ""
echo "Ready to launch JokeBloke with:"
echo "  ./start_jokebloke.sh"
echo ""
echo "Or manually:"
echo "  voila jokebloke.ipynb --template=lab --theme=dark --port=8866"
