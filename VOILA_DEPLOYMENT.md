# JokeBloke Voilà Deployment Guide

## What is Voilà?

Voilà transforms Jupyter notebooks into standalone web applications. For JokeBloke, this means:
- ✅ Clean user interface with no code visible
- ✅ Only interactive widgets and markdown are shown
- ✅ Users can interact with JokeBloke without seeing implementation
- ✅ Perfect for demos and production deployments

## Quick Start

### Local Deployment
```bash
./start_jokebloke.sh
```

Or manually:
```bash
voila jokebloke.ipynb --template=lab --theme=dark --port=8866
```

The app will be available at: http://localhost:8866

### Configuration

The Voilà configuration is in [voila.json](voila.json):
- **Theme**: Dark mode for better aesthetics
- **Template**: Lab template for modern UI
- **Extensions**: Enabled for widget support

### What Gets Hidden in Voilà?

The following cells are hidden in the Voilà web interface (code only, not output):
1. Cell 1: Imports and setup
2. Cell 2: spaCy demo (development only)
3. Cell 3: Cockpit demo (development only)
4. Cell 4: Agent class definitions
5. Cell 5: Agent initialization
6. Cell 6: Agent re-initialization

### What Gets Shown?

Users see:
- **Cell 7**: Markdown instructions on how to use JokeBloke
- **Cell 8**: Interactive UI components:
  - Audio recorder widget
  - Status output
  - Like/dislike feedback buttons
  - Loading indicators

## Production Deployment Options

### 1. Voilà Server
```bash
voila jokebloke.ipynb \
    --port=8866 \
    --Voila.ip='0.0.0.0' \
    --no-browser
```

### 2. Binder (Free Cloud Hosting)
The notebook is already configured for Binder with:
- [requirements.txt](requirements.txt) - All dependencies
- Compatible with Python 3.10

Click the "launch binder" badge in README to deploy.

### 3. Docker Container
```dockerfile
FROM python:3.10
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
RUN python -m spacy download en_core_web_sm
COPY . .
ENV GEMINI_API_KEY=""
EXPOSE 8866
CMD ["voila", "jokebloke.ipynb", "--port=8866", "--Voila.ip=0.0.0.0", "--no-browser"]
```

Build and run:
```bash
docker build -t jokebloke .
docker run -p 8866:8866 -e GEMINI_API_KEY="your-key" jokebloke
```

### 4. Cloud Platforms
Deploy to:
- **Heroku**: Use `Procfile` with voila command
- **Google Cloud Run**: Use Docker container
- **AWS EC2**: Run voila server
- **DigitalOcean**: Deploy Docker container

## Environment Variables

Required:
- `GEMINI_API_KEY`: Your Google Gemini API key

Optional:
- `VOILA_PORT`: Port for web server (default: 8866)
- `VOILA_IP`: IP address to bind (default: 0.0.0.0)

## Troubleshooting

### Audio Not Working
**Issue**: Audio recorder or playback fails in Voilà
**Solution**: 
- Voilà requires a browser environment with WebAudio API
- Ensure browser permissions for microphone access
- Check that `ipyaudioworklet` is properly installed

### Widgets Not Displaying
**Issue**: Interface doesn't show up
**Solution**:
```bash
jupyter nbextension enable --py widgetsnbextension
jupyter labextension install @jupyter-widgets/jupyterlab-manager
```

### API Key Errors
**Issue**: 403 PERMISSION_DENIED or API key not found
**Solution**:
- Set `GEMINI_API_KEY` environment variable
- Get new key at: https://aistudio.google.com/apikey
- Restart Voilà server after setting the variable

### Import Errors
**Issue**: Module not found errors
**Solution**:
```bash
pip install -r requirements.txt
python -m spacy download en_core_web_sm
```

## Performance Tips

1. **Preload Models**: Initialize spaCy and other models at startup (already done in Cell 5)
2. **Memory Management**: Set `memory.max_memory_length` appropriately (default: 10)
3. **Concurrent Users**: Use nginx/gunicorn for multiple users
4. **Caching**: Cache joke responses to reduce API calls

## Security Considerations

⚠️ **Important for Production**:

1. **Never commit API keys** to version control
2. **Use environment variables** for all secrets
3. **Implement rate limiting** to prevent API abuse
4. **Add authentication** for public deployments
5. **Monitor API usage** to control costs

## Customization

### Change Theme
Edit [voila.json](voila.json):
```json
{
  "VoilaConfiguration": {
    "theme": "light"  // or "dark"
  }
}
```

### Change Port
```bash
voila jokebloke.ipynb --port=9000
```

### Custom CSS
Add custom styling to Cell 8 in the notebook under `STYLE_SHEET_CONTENT`.

## Monitoring

Track application health:
- **User Feedback**: Check `feedback.positive_feedbacks` and `feedback.negative_feedbacks`
- **API Usage**: Monitor Gemini API dashboard
- **Memory Usage**: Use `memory.get_full_memory_summary()` to inspect conversation state

## Support

For issues or questions:
- Check troubleshooting section above
- Review Voilà documentation: https://voila.readthedocs.io/
- Check widget documentation: https://ipywidgets.readthedocs.io/

## License

See [LICENSE](LICENSE) file for terms.
