#!/bin/bash

# Multi-Language Verification Script for JokeBloke
echo "🌍 JokeBloke Multi-Language Verificatie"
echo "========================================"
echo ""

# Check if both spaCy models are available
echo "📚 Checking spaCy models..."
echo ""

echo "🇳🇱 Nederlands (nl_core_news_sm):"
if python -c "import spacy; spacy.load('nl_core_news_sm')" 2>/dev/null; then
    echo "  ✅ Installed"
else
    echo "  ❌ Not installed - Run: python -m spacy download nl_core_news_sm"
fi

echo ""
echo "🇩🇪 Deutsch (de_core_news_sm):"
if python -c "import spacy; spacy.load('de_core_news_sm')" 2>/dev/null; then
    echo "  ✅ Installed"
else
    echo "  ❌ Not installed - Run: python -m spacy download de_core_news_sm"
fi

echo ""
echo "📝 Checking notebook configuration..."

# Check if LANGUAGE_CONFIG exists in notebook
if grep -q "LANGUAGE_CONFIG" jokebloke.ipynb; then
    echo "  ✅ LANGUAGE_CONFIG found in notebook"
else
    echo "  ❌ LANGUAGE_CONFIG not found"
fi

# Check if current_lang is used
if grep -q "current_lang\['spacy_model'\]" jokebloke.ipynb; then
    echo "  ✅ Dynamic language loading configured"
else
    echo "  ❌ Language configuration not properly set"
fi

# Check for both language codes
if grep -q "'nl':" jokebloke.ipynb && grep -q "'de':" jokebloke.ipynb; then
    echo "  ✅ Both Dutch and German configurations present"
else
    echo "  ❌ Language configurations incomplete"
fi

echo ""
echo "🎯 Current configuration:"
CURRENT_LANG=$(grep "^LANGUAGE = " jokebloke.ipynb | head -1 | sed "s/.*LANGUAGE = '\(.*\)'.*/\1/")
if [ ! -z "$CURRENT_LANG" ]; then
    echo "  Current language: $CURRENT_LANG"
    case $CURRENT_LANG in
        "nl")
            echo "  🇳🇱 Nederlands actief"
            ;;
        "de")
            echo "  🇩🇪 Deutsch aktiv"
            ;;
        *)
            echo "  ⚠️  Unknown language code"
            ;;
    esac
else
    echo "  ⚠️  Could not detect current language"
fi

echo ""
echo "========================================"
echo "✅ Verification complete!"
echo ""
echo "To change language:"
echo "  1. Open jokebloke.ipynb"
echo "  2. Change LANGUAGE = 'nl' or LANGUAGE = 'de' in cell 2"
echo "  3. Restart kernel"
echo "  4. Run ./start_jokebloke.sh"
echo ""
echo "Documentation: MULTI_LANGUAGE.md"
