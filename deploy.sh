#!/bin/bash

# JokeBloke Production Deployment Script
# For deploying to jokebloke.campmans.com

set -e

echo "🚀 JokeBloke Production Deployment"
echo "===================================="
echo ""

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo "❌ This script must be run as root (use sudo)"
   exit 1
fi

# Configuration
DOMAIN="jokebloke.campmans.com"
APP_DIR="/opt/jokebloke"
SERVICE_NAME="jokebloke"

echo "📋 Configuration:"
echo "   Domain: $DOMAIN"
echo "   App Directory: $APP_DIR"
echo "   Service: $SERVICE_NAME"
echo ""

# Step 1: Install system dependencies
echo "📦 Step 1: Installing system dependencies..."
apt update
apt install -y python3.12 python3-pip python3-venv \
    portaudio19-dev python3-pyaudio git nginx certbot python3-certbot-nginx

echo "✅ System dependencies installed"
echo ""

# Step 2: Clone or update repository
echo "📥 Step 2: Setting up application..."
if [ -d "$APP_DIR" ]; then
    echo "   Updating existing installation..."
    cd $APP_DIR
    git pull
else
    echo "   Cloning repository..."
    git clone https://github.com/campmans/jokebloke.git $APP_DIR
    cd $APP_DIR
fi

echo "✅ Application code ready"
echo ""

# Step 3: Setup Python environment
echo "🐍 Step 3: Setting up Python environment..."
if [ ! -d "$APP_DIR/venv" ]; then
    python3 -m venv venv
fi

source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

echo "✅ Python environment ready"
echo ""

# Step 4: Install spaCy models
echo "📚 Step 4: Installing spaCy language models..."
python -m spacy download nl_core_news_sm
python -m spacy download de_core_news_sm
python -m spacy download en_core_web_sm
python -m spacy download it_core_news_sm

echo "✅ All language models installed (🇳🇱🇩🇪🇬🇧🇮🇹)"
echo ""

# Step 5: Configure API key
echo "🔑 Step 5: API Key Configuration"
read -sp "   Enter your Anthropic API key: " API_KEY
echo ""

if [ -z "$API_KEY" ]; then
    echo "⚠️  No API key provided. You'll need to configure it manually."
else
    # Update systemd service file with API key
    sed -i "s/your_api_key_here/$API_KEY/g" jokebloke.service
    echo "✅ API key configured"
fi
echo ""

# Step 6: Setup systemd service
echo "⚙️  Step 6: Setting up systemd service..."
cp jokebloke.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable $SERVICE_NAME
systemctl restart $SERVICE_NAME

sleep 3

if systemctl is-active --quiet $SERVICE_NAME; then
    echo "✅ Service is running"
else
    echo "❌ Service failed to start. Check logs with: journalctl -u $SERVICE_NAME"
    exit 1
fi
echo ""

# Step 7: Configure Nginx
echo "🌐 Step 7: Configuring Nginx..."
cp nginx.conf /etc/nginx/sites-available/$DOMAIN
ln -sf /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled/

# Test Nginx configuration
if nginx -t; then
    systemctl restart nginx
    echo "✅ Nginx configured and running"
else
    echo "❌ Nginx configuration error"
    exit 1
fi
echo ""

# Step 8: SSL Certificate
echo "🔒 Step 8: SSL Certificate Setup"
echo "   Would you like to setup SSL with Let's Encrypt? (y/n)"
read -r SETUP_SSL

if [[ $SETUP_SSL == "y" || $SETUP_SSL == "Y" ]]; then
    echo "   Setting up SSL certificate..."
    certbot --nginx -d $DOMAIN --non-interactive --agree-tos --register-unsafely-without-email || \
    certbot --nginx -d $DOMAIN
    echo "✅ SSL certificate installed"
else
    echo "⏭️  Skipping SSL setup. You can run 'certbot --nginx -d $DOMAIN' later."
fi
echo ""

# Step 9: Firewall
echo "🛡️  Step 9: Firewall Configuration"
if command -v ufw &> /dev/null; then
    ufw allow 22/tcp
    ufw allow 80/tcp
    ufw allow 443/tcp
    ufw --force enable
    echo "✅ Firewall configured"
else
    echo "⚠️  UFW not installed. Consider setting up a firewall."
fi
echo ""

# Final checks
echo "🎉 Deployment Complete!"
echo "======================="
echo ""
echo "📊 Status Check:"
systemctl status $SERVICE_NAME --no-pager | head -5
echo ""
echo "🌐 Access your application at:"
echo "   http://$DOMAIN"
if [[ $SETUP_SSL == "y" || $SETUP_SSL == "Y" ]]; then
    echo "   https://$DOMAIN (with SSL)"
fi
echo ""
echo "🌍 Supported Languages: 🇳🇱 🇩🇪 🇬🇧 🇮🇹"
echo ""
echo "📝 Useful Commands:"
echo "   Check logs:    journalctl -u $SERVICE_NAME -f"
echo "   Restart app:   systemctl restart $SERVICE_NAME"
echo "   Stop app:      systemctl stop $SERVICE_NAME"
echo "   Update app:    cd $APP_DIR && git pull && systemctl restart $SERVICE_NAME"
echo ""
echo "✅ JokeBloke is ready! 🎭"
