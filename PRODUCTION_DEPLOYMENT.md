# JokeBloke Production Deployment Guide

## 🌐 Deploying to jokebloke.campmans.com

This guide explains how to deploy JokeBloke to a production server with a custom domain.

## 📋 Prerequisites

- A server (VPS, cloud instance, or dedicated server)
- Ubuntu 20.04+ or similar Linux distribution
- Domain name: jokebloke.campmans.com
- SSH access to your server
- Sudo privileges

## 🚀 Deployment Options

### Option 1: Docker Deployment (Recommended)

#### 1. Create Dockerfile

```dockerfile
FROM python:3.12-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    portaudio19-dev \
    python3-pyaudio \
    git \
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

# Install spaCy models for all languages
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
```

#### 2. Create docker-compose.yml

```yaml
version: '3.8'

services:
  jokebloke:
    build: .
    container_name: jokebloke
    restart: unless-stopped
    ports:
      - "8866:8866"
    environment:
      - ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY}
    volumes:
      - ./jokebloke.ipynb:/app/jokebloke.ipynb
      - ./prompts:/app/prompts
```

#### 3. Deploy with Docker

```bash
# On your server
git clone https://github.com/campmans/jokebloke.git
cd jokebloke

# Set your API key
echo "ANTHROPIC_API_KEY=your_api_key_here" > .env

# Build and run
docker-compose up -d

# Check logs
docker-compose logs -f
```

### Option 2: Systemd Service (Direct Installation)

#### 1. Install Dependencies on Server

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Python and dependencies
sudo apt install -y python3.12 python3-pip python3-venv \
    portaudio19-dev python3-pyaudio git nginx certbot python3-certbot-nginx

# Clone repository
cd /opt
sudo git clone https://github.com/campmans/jokebloke.git
cd jokebloke

# Create virtual environment
sudo python3 -m venv venv
sudo ./venv/bin/pip install -r requirements.txt

# Install spaCy models
sudo ./venv/bin/python -m spacy download nl_core_news_sm
sudo ./venv/bin/python -m spacy download de_core_news_sm
sudo ./venv/bin/python -m spacy download en_core_web_sm
sudo ./venv/bin/python -m spacy download it_core_news_sm
```

#### 2. Create Systemd Service

```bash
sudo nano /etc/systemd/system/jokebloke.service
```

Add this content:

```ini
[Unit]
Description=JokeBloke Voilà Application
After=network.target

[Service]
Type=simple
User=www-data
WorkingDirectory=/opt/jokebloke
Environment="ANTHROPIC_API_KEY=your_api_key_here"
ExecStart=/opt/jokebloke/venv/bin/voila jokebloke.ipynb --port=8866 --no-browser --Voila.ip=127.0.0.1 --theme=dark --template=lab
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

#### 3. Start Service

```bash
# Reload systemd
sudo systemctl daemon-reload

# Enable service to start on boot
sudo systemctl enable jokebloke

# Start service
sudo systemctl start jokebloke

# Check status
sudo systemctl status jokebloke
```

## 🌐 Nginx Reverse Proxy Configuration

### 1. Create Nginx Configuration

```bash
sudo nano /etc/nginx/sites-available/jokebloke.campmans.com
```

Add this content:

```nginx
server {
    listen 80;
    server_name jokebloke.campmans.com;

    location / {
        proxy_pass http://127.0.0.1:8866;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        
        # WebSocket support
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        
        # Timeouts for long-running requests
        proxy_read_timeout 300s;
        proxy_connect_timeout 75s;
    }
}
```

### 2. Enable Site

```bash
# Create symbolic link
sudo ln -s /etc/nginx/sites-available/jokebloke.campmans.com /etc/nginx/sites-enabled/

# Test configuration
sudo nginx -t

# Restart Nginx
sudo systemctl restart nginx
```

## 🔒 SSL/HTTPS Setup with Let's Encrypt

```bash
# Get SSL certificate
sudo certbot --nginx -d jokebloke.campmans.com

# Follow prompts to:
# 1. Enter email address
# 2. Agree to terms
# 3. Choose redirect HTTP to HTTPS (recommended)

# Auto-renewal is configured automatically
# Test renewal:
sudo certbot renew --dry-run
```

## 📡 DNS Configuration

Configure your DNS to point to your server:

```
Type: A Record
Name: jokebloke
Value: YOUR_SERVER_IP
TTL: 3600
```

Or if using a subdomain:

```
Type: CNAME
Name: jokebloke
Value: your-server.example.com
TTL: 3600
```

## 🔧 Environment Variables

### Set API Key Securely

For systemd service:
```bash
sudo systemctl edit jokebloke
```

Add:
```ini
[Service]
Environment="ANTHROPIC_API_KEY=your_actual_api_key"
```

For Docker:
```bash
# Create .env file
echo "ANTHROPIC_API_KEY=your_actual_api_key" > .env
```

## 🔄 Updating the Application

### Docker Deployment
```bash
cd /path/to/jokebloke
git pull
docker-compose down
docker-compose up -d --build
```

### Systemd Deployment
```bash
cd /opt/jokebloke
sudo git pull
sudo systemctl restart jokebloke
```

## 📊 Monitoring

### Check Application Logs

Docker:
```bash
docker-compose logs -f jokebloke
```

Systemd:
```bash
sudo journalctl -u jokebloke -f
```

Nginx:
```bash
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log
```

## 🛡️ Security Recommendations

1. **Firewall Configuration**
   ```bash
   sudo ufw allow 22/tcp    # SSH
   sudo ufw allow 80/tcp    # HTTP
   sudo ufw allow 443/tcp   # HTTPS
   sudo ufw enable
   ```

2. **Rate Limiting in Nginx**
   Add to nginx config:
   ```nginx
   limit_req_zone $binary_remote_addr zone=jokebloke:10m rate=10r/s;
   
   location / {
       limit_req zone=jokebloke burst=20 nodelay;
       # ... rest of config
   }
   ```

3. **Fail2ban**
   ```bash
   sudo apt install fail2ban
   sudo systemctl enable fail2ban
   sudo systemctl start fail2ban
   ```

4. **Regular Updates**
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

## 🧪 Testing

After deployment, test the site:

```bash
# Test HTTP to HTTPS redirect
curl -I http://jokebloke.campmans.com

# Test HTTPS
curl -I https://jokebloke.campmans.com

# Test WebSocket connection
curl -i -N -H "Connection: Upgrade" -H "Upgrade: websocket" \
     https://jokebloke.campmans.com
```

## 📱 Multi-Language Support

All 4 languages are included in the deployment:
- 🇳🇱 Nederlands (default)
- 🇩🇪 Deutsch
- 🇬🇧 English (UK)
- 🇮🇹 Italiano

To change the default language, edit `jokebloke.ipynb` before deployment:
```python
LANGUAGE = 'nl'  # Change to 'de', 'en-gb', or 'it'
```

## 🚨 Troubleshooting

### Port Already in Use
```bash
sudo lsof -i :8866
sudo kill -9 <PID>
```

### Service Won't Start
```bash
sudo journalctl -u jokebloke -n 50 --no-pager
```

### Nginx Configuration Error
```bash
sudo nginx -t
```

### SSL Certificate Issues
```bash
sudo certbot certificates
sudo certbot renew --force-renewal
```

## 📞 Support

- Documentation: See README.md, MULTI_LANGUAGE.md
- Issues: https://github.com/campmans/jokebloke/issues

## 🎉 Success!

Once deployed, access JokeBloke at:
```
https://jokebloke.campmans.com
```

Enjoy your multi-language AI comedy assistant! 🎭🇳🇱🇩🇪🇬🇧🇮🇹
