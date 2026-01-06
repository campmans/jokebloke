FROM python:3.12-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    portaudio19-dev \
    python3-pyaudio \
    git \
    libglib2.0-0 \
    libsdl2-2.0-0 \
    libsdl2-mixer-2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY requirements.txt .
COPY jokebloke.ipynb .
COPY prompts/ ./prompts/
COPY voila.json .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install spaCy models for all 4 languages
RUN python -m spacy download nl_core_news_sm && \
    python -m spacy download de_core_news_sm && \
    python -m spacy download en_core_web_sm && \
    python -m spacy download it_core_news_sm

# Expose port
EXPOSE 8866

# Set environment variable for API key
ENV ANTHROPIC_API_KEY=""

# Run Voilà
CMD ["voila", "jokebloke.ipynb", "--port=8866", "--no-browser", \
     "--Voila.ip=0.0.0.0", "--theme=dark", "--template=lab"]
