# JokeBloke - Multi-Language Support / Mehrsprachige Unterstützung

## 🌍 Overzicht / Überblick / Overview

JokeBloke ondersteunt nu meerdere talen! / JokeBloke unterstützt jetzt mehrere Sprachen! / JokeBloke now supports multiple languages!

### Ondersteunde Talen / Unterstützte Sprachen / Supported Languages / Lingue Supportate:
- 🇳🇱 **Nederlands** (Dutch) - Standaard / Default
- 🇩🇪 **Deutsch** (German)
- 🇬🇧 **English (UK)** (British English)
- 🇮🇹 **Italiano** (Italian) - Nieuw! / Neu! / New! / Nuovo!

## 🚀 Taal Wijzigen / Sprache Ändern / Changing Language

### Stap 1 / Schritt 1 / Step 1: Open de Notebook
Open `jokebloke.ipynb` in Jupyter Lab of VS Code

### Stap 2 / Schritt 2 / Step 2: Wijzig de LANGUAGE Variabele
In **cel 2** (na de imports), vind je:

```python
# Configureer de gewenste taal hier / Configure desired language here
LANGUAGE = 'nl'  # Opties / Optionen / Options / Opzioni: 'nl', 'de', 'en-gb', 'it'
```

Wijzig naar / Ändern zu / Change to / Cambia a:
- Voor Nederlands: `LANGUAGE = 'nl'`
- Für Deutsch: `LANGUAGE = 'de'`
- For English (UK): `LANGUAGE = 'en-gb'`
- Per l'Italiano: `LANGUAGE = 'it'`

### Stap 3 / Schritt 3 / Step 3: Installeer spaCy Model
Installeer het juiste taalmodel / Installieren Sie das richtige Sprachmodell:

```bash
# Voor Nederlands / For Dutch:
python -m spacy download nl_core_news_sm

# Für Deutsch / For German:
python -m spacy download de_core_news_sm

# For English (UK):
python -m spacy download en_core_web_sm

# Per l'Italiano / For Italian:
python -m spacy download it_core_news_sm
```

### Stap 4 / Schritt 4 / Step 4: Herstart de Kernel
- In Jupyter: Kernel → Restart & Run All
- In VS Code: Restart notebook kernel

### Stap 5 / Schritt 5 / Step 5: Start Voilà
```bash
./start_jokebloke.sh
```

## 📋 Taalfuncties / Sprachfunktionen / Language Features

### Nederlands (nl) 🇳🇱

#### NLP Verwerking:
- **spaCy model**: `nl_core_news_sm`
- **Spraakherkenning**: `nl-NL`
- **Tekst-naar-spraak**: `nl`

#### UI Teksten:
- "Vind je dit leuk?"
- "Bedenk iets grappigs..."
- "Recorder klaar"
- "Transcriptie:", "Persoonlijkheid:", "Reactie:"
- "Dank je!" / "Wow, lastig publiek!"

#### Laadberichten (16):
- "Even geduld, ik werk eraan..."
- "Komedie kost tijd, anders dan het geduld van mijn ex..."
- "Mijn schrijvers staken weer..."
- En meer...

### Deutsch (de) 🇩🇪

#### NLP-Verarbeitung:
- **spaCy-Modell**: `de_core_news_sm`
- **Spracherkennung**: `de-DE`
- **Text-zu-Sprache**: `de`

#### UI-Texte:
- "Gefällt dir das?"
- "Denke mir etwas Lustiges aus..."
- "Recorder bereit"
- "Transkription:", "Persönlichkeit:", "Antwort:"
- "Danke!" / "Wow, hartes Publikum!"

#### Lademeldungen (16):
- "Einen Moment, ich arbeite daran..."
- "Comedy braucht Zeit, im Gegensatz zur Geduld meiner Ex..."
- "Meine Autoren streiken wieder..."
- Und mehr...

### English (UK) (en-gb) 🇬🇧

#### NLP Processing:
- **spaCy model**: `en_core_web_sm`
- **Speech recognition**: `en-GB`
- **Text-to-speech**: `en` with British accent (tld: co.uk)

#### UI Texts:
- "Do you like this?"
- "Thinking of something funny..."
- "Recorder ready"
- "Transcription:", "Personality:", "Response:"
- "Cheers!" / "Blimey, tough crowd!"

#### Loading Messages (16):
- "Hold on, I'm working on it..."
- "Comedy takes time, unlike my ex's patience..."
- "My writers are on strike again..."
- "Buffering humour... have you tried turning me off and on again?"
- And more...

### Italiano (it) 🇮🇹

#### Elaborazione NLP:
- **Modello spaCy**: `it_core_news_sm`
- **Riconoscimento vocale**: `it-IT`
- **Sintesi vocale**: `it`

#### Testi UI:
- "Ti piace?"
- "Sto pensando qualcosa di divertente..."
- "Registratore pronto"
- "Trascrizione:", "Personalità:", "Risposta:"
- "Grazie!" / "Mamma mia, che pubblico difficile!"

#### Messaggi di Caricamento (16):
- "Aspetta, ci sto lavorando..."
- "La commedia richiede tempo, a differenza della pazienza della mia ex..."
- "I miei autori sono di nuovo in sciopero..."
- "Buffering comicità... hai provato a spegnermi e riaccendermi?"
- E altro ancora...

## 🔧 Technische Implementatie / Technische Implementierung / Technical Implementation

### Taalconfiguratie Structuur / Sprachkonfigurationsstruktur:

```python
LANGUAGE_CONFIG = {
    'nl': {
        'name': 'Nederlands',
        'spacy_model': 'nl_core_news_sm',
        'speech_recognition': 'nl-NL',
        'tts_lang': 'nl',
        'ui': { ... },  # Alle UI teksten
        'loading_messages': [ ... ]  # 16 laadberichten
    },
    'de': {
        'name': 'Deutsch',
        'spacy_model': 'de_core_news_sm',
        'speech_recognition': 'de-DE',
        'tts_lang': 'de',
        'ui': { ... },  # Alle UI-Texte
        'loading_messages': [ ... ]  # 16 Lademeldungen
    },
    'en-gb': {
        'name': 'English (UK)',
        'spacy_model': 'en_core_web_sm',
        'speech_recognition': 'en-GB',
        'tts_lang': 'en',
        'tts_tld': 'co.uk',  # British accent
        'ui': { ... },  # All UI texts
        'loading_messages': [ ... ]  # 16 loading messages
    },
    'it': {
        'name': 'Italiano',
        'spacy_model': 'it_core_news_sm',
        'speech_recognition': 'it-IT',
        'tts_lang': 'it',
        'ui': { ... },  # Tutti i testi UI
        'loading_messages': [ ... ]  # 16 messaggi di caricamento
    }
}
```

### Dynamische Functie Aanroepen / Dynamische Funktionsaufrufe:

```python
# Spraakherkenning / Spracherkennung
text = recognizer.recognize_google(audio, 
    language=current_lang['speech_recognition'])

# Tekst-naar-spraak / Text-zu-Sprache
gTTS(text, lang=current_lang['tts_lang'])

# spaCy NLP
nlp = spacy.load(current_lang['spacy_model'])

# UI labels
text_label = widgets.Label(value=current_lang['ui']['like_question'])
```

## 🧪 Testen / Testen / Testing

### Nederlands Testen:
```bash
# Zet LANGUAGE = 'nl' in cel 2
# Spreek tegen JokeBloke:
- "Vertel me een grap"
- "Ik hou van komedie"
- "Maak me aan het lachen"
```

### Deutsch Testen:
```bash
# Setzen Sie LANGUAGE = 'de' in Zelle 2
# Sprechen Sie mit JokeBloke:
- "Erzähl mir einen Witz"
- "Ich liebe Comedy"
- "Bring mich zum Lachen"
```

### English (UK) Testing:
```bash
# Set LANGUAGE = 'en-gb' in cell 2
# Speak to JokeBloke:
- "Tell me a joke"
- "I love comedy"
- "Make me laugh"
```

### Italiano Testing / Test Italiano:
```bash
# Imposta LANGUAGE = 'it' nella cella 2
# Parla con JokeBloke:
- "Raccontami una barzelletta"
- "Amo la commedia"
- "Fammi ridere"
```

## 📦 Installatie / Installation

### Beide Talen Installeren / Beide Sprachen Installieren / Install All Languages:

```bash
# Installeer alle spaCy modellen / Install all spaCy models
python -m spacy download nl_core_news_sm
python -m spacy download de_core_news_sm
python -m spacy download en_core_web_sm
python -m spacy download it_core_news_sm

# Verifieer installatie
./verify_multilanguage.sh
```

## 🎯 Voorbeelden / Beispiele / Examples

### Voorbeeld 1: Wissel van Nederlands naar Duits

1. Open `jokebloke.ipynb`
2. Wijzig cel 2: `LANGUAGE = 'de'`
3. Herstart kernel
4. Start Voilà
5. Spreek Duits tegen JokeBloke!

### Beispiel 2: Wechsel von Deutsch zu Niederländisch / Example 3: Switch to English

1. Öffnen Sie `jokebloke.ipynb` / Open `jokebloke.ipynb`
2. Ändern Sie Zelle 2 / Change cell 2: `LANGUAGE = 'en-gb'`
3. Kernel neu starten / Restart kernel
4. Voilà starten / Start Voilà
5. Sprechen Sie Englisch mit JokeBloke! / Speak English to JokeBloke!

### Voorbeeld 3: Van Nederlands naar Engels / Example 3: Dutch to English

1. Open `jokebloke.ipynb`
2. Wijzig cel 2: `LANGUAGE = 'en-gb'`
3. Herstart kernel
4. Start Voilà
5. Spreek Engels tegen JokeBloke!

## 🆕 Nieuwe Talen Toevoegen / Neue Sprachen Hinzufügen / Adding New Languages

Om een nieuwe taal toe te voegen / Um eine neue Sprache hinzuzufügen:

1. **Voeg toe aan LANGUAGE_CONFIG**:
```python
'fr': {  # Frans / Französisch / French
    'name': 'Français',
    'spacy_model': 'fr_core_news_sm',
    'speech_recognition': 'fr-FR',
    'tts_lang': 'fr',
    'ui': {
        'title': 'JokeBloke',
        'instruction': '...',
        'like_question': 'Aimez-vous ça?',
        # ... alle vertalingen
    },
    'loading_messages': [ ... ]
}
```

2. **Installeer spaCy model**:
```bash
python -m spacy download fr_core_news_sm
```

3. **Test de nieuwe taal**:
```python
LANGUAGE = 'fr'
```

## 🔍 Veelgestelde Vragen / Häufig Gestellte Fragen / FAQ

### Q: Kan ik tussen talen wisselen zonder herstart?
**A**: Nee, je moet de kernel herstarten na het wijzigen van `LANGUAGE`.

### F: Kann ich zwischen Sprachen ohne Neustart wechseln?
**A**: Nein, Sie müssen den Kernel nach Änderung von `LANGUAGE` neu starten.

### Q: Welke taal wordt gebruikt in Voilà?
**A**: De taal die is ingesteld in `LANGUAGE` variabele (cel 2).

### F: Welche Sprache wird in Voilà verwendet?
**A**: Die in der `LANGUAGE`-Variable eingestellte Sprache (Zelle 2).

### Q: Werkt automatische taaldetectie?
**A**: Nee, je moet de taal handmatig instellen. Google Speech Recognition kan meerdere talen detecteren, maar de UI blijft in de gekozen taal.

### F: Funktioniert automatische Spracherkennung?
**A**: Nein, Sie müssen die Sprache manuell einstellen. Google Speech Recognition kann mehrere Sprachen erkennen, aber die UI bleibt in der gewählten Sprache.

## 📚 Documentatie / Dokumentation / Documentation

- [DUTCH_LANGUAGE.md](DUTCH_LANGUAGE.md) - Nederlandse documentatie
- [README.md](README.md) - Algemene informatie / Allgemein / NLP processing per language
- ✅ Spraakherkenning per taal / Spracherkennung pro Sprache / Speech recognition per language
- ✅ Tekst-naar-spraak per taal / Text-zu-Sprache pro Sprache / Text-to-speech per language
- ✅ UI in gekozen taal / UI in gewählter Sprache / UI in chosen language
- ✅ Dynamische laadberichten / Dynamische Lademeldungen / Dynamic loading messages
- ✅ Feedback systeem per taal / Feedback-System pro Sprache / Feedback system per language
- ✅ British accent support (en-gb)MPLETE

Ondersteunde functionaliteit / Unterstützte Funktionalität / Supported Features:
- ✅ NLP verwerking per taal / NLP-Verarbeitung pro Sprache
- ✅ Spraakherkenning per taal / Spracherkennung pro Sprache
- ✅ Tekst-naar-spraak per taal / Text-zu-Sprache pro Sprache
- ✅ UI in gekozen taal / UI in gewählter Sprache
- ✅ Dynamische laadberichten / Dynamische Lademeldungen
- ✅ Feedback systeem per taal / Feedback-System pro Sprache

## 🎭 Veel Plezier! / Viel Spaß! / Enjoy!
🇬🇧

---

**Implementatie datum / Implementierungsdatum / Implementation date**: 3 januari 2026
**Versie / Version**: 2.1 (Multi-Language + English UK)
**Talen / Sprachen / Languages**: Nederlands, Deutsch, English (UK)
**Talen / Sprachen / Languages**: Nederlands, Deutsch
