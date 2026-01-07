# Email Draft for Tony

**To:** tony@eurekaconnections.com  
**Subject:** JokeBloke Docker Image - Italian AI Comedy Assistant  

---

Hi Tony,

I'm sharing the JokeBloke Docker image with you. This is an AI-powered comedy assistant that generates jokes in Italian using Google Gemini API.

## Docker Image Details

- **Image Name:** jokebloke-jokebloke:latest
- **Size:** 1.35GB (compressed: 447MB)
- **Export File:** `jokebloke-docker-image.tar.gz`
- **Language:** Italian only
- **Theme:** Light mode
- **Port:** 8866

## Features

- Voice-controlled interface (Italian speech recognition)
- Multiple comedy personalities
- Contextual memory system
- User feedback learning (UCB algorithm)
- Italian text-to-speech output
- Voilà web interface

## Deployment Instructions

### Option 1: Load from Exported Image (if sharing the tar.gz file)

```bash
# Load the image
docker load < jokebloke-docker-image.tar.gz

# Run the container
docker run -d \
  --name jokebloke \
  -p 8866:8866 \
  -e GEMINI_API_KEY="your-api-key-here" \
  jokebloke-jokebloke:latest

# Access at http://localhost:8866
```

### Option 2: Build from Source (recommended)

```bash
# Clone the repository
git clone https://github.com/campmans/jokebloke.git
cd jokebloke

# Add your API key to .env file
echo "GEMINI_API_KEY=your-api-key-here" > .env

# Build and run with docker-compose
docker-compose up -d

# Access at http://localhost:8866
```

## Requirements

- Docker & Docker Compose
- Google Gemini API key (get one at https://makersuite.google.com/app/apikey)

## GitHub Repository

https://github.com/campmans/jokebloke

## Notes

- The application runs Voilà with tracebacks enabled for debugging
- Uses Italian spaCy model (it_core_news_sm)
- Includes SDL dummy audio driver for headless environments
- All interface text is in Italian

Let me know if you need any help with deployment or have questions!

Best regards

---

## File Sharing Options

Since the compressed image is 447MB, you can share it via:
1. **Cloud Storage:** Upload to Google Drive, Dropbox, or OneDrive and share the link
2. **WeTransfer:** Free for files up to 2GB
3. **GitHub Release:** Attach to a repository release (if under 2GB)
4. **Docker Hub:** Push the image to Docker Hub (recommended for easy deployment)

### To push to Docker Hub:
```bash
docker tag jokebloke-jokebloke:latest yourusername/jokebloke:latest
docker push yourusername/jokebloke:latest
```
