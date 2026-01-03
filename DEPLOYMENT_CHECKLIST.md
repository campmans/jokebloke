# 🚀 Quick Deployment Checklist - jokebloke.campmans.com

## ✅ Pre-Deployment Checklist

- [ ] Server met Ubuntu 20.04+ of vergelijkbaar
- [ ] Docker en Docker Compose geïnstalleerd op server
- [ ] SSH toegang tot server
- [ ] Nginx geïnstalleerd (`sudo apt install nginx`)
- [ ] Certbot geïnstalleerd (`sudo apt install certbot python3-certbot-nginx`)
- [ ] DNS A-record: `jokebloke.campmans.com` → `[SERVER_IP]`
- [ ] Anthropic API key beschikbaar
- [ ] Poorten 80, 443, 8866 open in firewall

## 📋 Deployment Steps (5 minuten)

### 1. Login op Server
```bash
ssh user@your-server.com
```

### 2. Clone Repository
```bash
cd /opt  # of een andere gewenste locatie
git clone https://github.com/campmans/jokebloke.git
cd jokebloke
```

### 3. Configureer Environment
```bash
nano .env
```

Voeg toe:
```
ANTHROPIC_API_KEY=sk-ant-your-actual-key-here
```

Sla op met `Ctrl+X`, `Y`, `Enter`

### 4. Start Docker Container
```bash
docker-compose up -d
```

Wacht 2-3 minuten voor spaCy models download (4 talen: nl, de, en, it)

### 5. Controleer Status
```bash
# Check of container draait
docker-compose ps

# Bekijk logs
docker-compose logs -f

# Stop logs bekijken met Ctrl+C
```

Je zou moeten zien:
```
[Voila] Voilà is running at:
http://0.0.0.0:8866/
```

### 6. Setup Nginx Reverse Proxy
```bash
# Kopieer Nginx config
sudo cp nginx.conf /etc/nginx/sites-available/jokebloke.campmans.com

# Enable site
sudo ln -s /etc/nginx/sites-available/jokebloke.campmans.com /etc/nginx/sites-enabled/

# Test configuratie
sudo nginx -t

# Herstart Nginx
sudo systemctl restart nginx
```

### 7. Setup SSL Certificate
```bash
sudo certbot --nginx -d jokebloke.campmans.com
```

Volg de prompts:
- Voer email in
- Accepteer terms (Y)
- Kies redirect HTTP naar HTTPS (optie 2)

### 8. Test de Deployment
```bash
# Test HTTP → HTTPS redirect
curl -I http://jokebloke.campmans.com

# Test HTTPS
curl -I https://jokebloke.campmans.com
```

## 🌐 Open in Browser

Ga naar: **https://jokebloke.campmans.com**

Je zou nu JokeBloke moeten zien! 🎭

## 🔧 Beheer Commando's

### Logs bekijken
```bash
cd /opt/jokebloke
docker-compose logs -f
```

### Container herstarten
```bash
docker-compose restart
```

### Container stoppen
```bash
docker-compose down
```

### Applicatie updaten
```bash
git pull
docker-compose down
docker-compose up -d --build
```

### Status checken
```bash
docker-compose ps
docker stats jokebloke
```

## 🐛 Troubleshooting

### Container start niet
```bash
docker-compose logs
docker-compose down
docker-compose up  # zonder -d om logs te zien
```

### Poort 8866 al in gebruik
```bash
sudo lsof -i :8866
sudo kill <PID>
docker-compose restart
```

### Nginx fout
```bash
sudo nginx -t
sudo systemctl status nginx
sudo tail -f /var/log/nginx/error.log
```

### SSL certificaat problemen
```bash
sudo certbot certificates
sudo certbot renew
```

### Disk space issues
```bash
docker system prune -a
```

## 🔒 Security Checklist

- [ ] Firewall actief (`sudo ufw enable`)
- [ ] Alleen poorten 22, 80, 443 open
- [ ] SSL certificaat actief
- [ ] API key veilig opgeslagen in .env
- [ ] .env in .gitignore
- [ ] Regular updates: `apt update && apt upgrade`

## 📊 Monitoring

### Server Resources
```bash
# CPU en Memory
htop

# Disk usage
df -h

# Docker stats
docker stats
```

### Application Logs
```bash
# Live logs
docker-compose logs -f

# Last 100 lines
docker-compose logs --tail=100

# Specific service
docker-compose logs jokebloke
```

## 🌍 Multi-Language Features

Alle 4 talen zijn automatisch geïnstalleerd:

- 🇳🇱 **Nederlands** (standaard)
  - spaCy: nl_core_news_sm
  - Speech: nl-NL
  
- 🇩🇪 **Deutsch**
  - spaCy: de_core_news_sm
  - Speech: de-DE
  
- 🇬🇧 **English (UK)**
  - spaCy: en_core_web_sm
  - Speech: en-GB
  - British accent TTS
  
- 🇮🇹 **Italiano**
  - spaCy: it_core_news_sm
  - Speech: it-IT

## 🎉 Success!

Als alles werkt:
- ✅ https://jokebloke.campmans.com is bereikbaar
- ✅ SSL certificaat is actief (groene slot)
- ✅ Container draait: `docker-compose ps` toont "Up"
- ✅ Logs tonen geen errors
- ✅ Alle 4 talen werken

**Gefeliciteerd! JokeBloke is live! 🎭🇳🇱🇩🇪🇬🇧🇮🇹**

---

📚 **Meer info:**
- Volledige gids: [PRODUCTION_DEPLOYMENT.md](PRODUCTION_DEPLOYMENT.md)
- Multi-language: [MULTI_LANGUAGE.md](MULTI_LANGUAGE.md)
- Italian: [ITALIAN_ADDED.md](ITALIAN_ADDED.md)
