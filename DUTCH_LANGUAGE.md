# JokeBloke - Nederlandse Taalconfiguratie

## Overzicht

JokeBloke is nu volledig geconfigureerd met **Nederlands** als standaardtaal. Dit omvat alle onderdelen van het systeem:

### ✅ Geïmplementeerde Nederlandse Onderdelen

#### 1. **Natural Language Processing (NLP)**
- **spaCy Model**: `nl_core_news_sm` (Nederlands)
- **Taalanalyse**: Extractie van Nederlandse grammaticale kenmerken
- **Entiteitsherkenning**: Detectie van Nederlandse namen, plaatsen, organisaties

#### 2. **Spraakherkenning (Speech Recognition)**
- **Taal**: `nl-NL` (Nederlands - Nederland)
- **Service**: Google Speech Recognition API
- **Transcriptie**: Gesproken Nederlands wordt omgezet naar tekst

#### 3. **Tekst-naar-Spraak (Text-to-Speech)**
- **gTTS Taal**: `nl` (Nederlands)
- **Stem**: Nederlandse spraaksynthese
- **Output**: JokeBloke spreekt antwoorden in het Nederlands

#### 4. **Gebruikersinterface**
- **Labels**: "Vind je dit leuk?"
- **Knoppen**: ": )" en ": ("
- **Statusindicatoren**: "Bedenk iets grappigs..."
- **Status**: "Recorder klaar"

#### 5. **Laadberichten**
Grappige Nederlandse berichten tijdens het genereren van grappen:
- "Even geduld, ik werk eraan..."
- "Komedie kost tijd, anders dan het geduld van mijn ex..."
- "Mijn schrijvers staken weer..."
- "De clou zit vast in het verkeer..."
- En meer!

#### 6. **Feedback Berichten**
- **Positief**: "Dank je!" / "Je vond dit leuk!"
- **Negatief**: "Wow, lastig publiek!" / "Je vond dit niet leuk!"
- **Persoonlijkheid**: "Persoonlijkheid: [naam]"
- **Reactie**: "Reactie: [grap]"

#### 7. **Instructies**
Markdown cel met Nederlandse gebruikersinstructies:
> "Druk op `boot recorder` om hem wakker te maken. Druk vervolgens op `record` om tegen hem te praten. Als je klaar bent met praten, druk dan op `stop` en wacht geduldig op zijn reactie."

## Installatie

### 1. Download Nederlands spaCy Model
```bash
python -m spacy download nl_core_news_sm
```

### 2. Verifieer Installatie
```bash
./test_voila_setup.sh
```

Dit controleert:
- ✓ Python versie
- ✓ Voilà installatie
- ✓ Kernpakketten (spacy, pygame, ipywidgets, voila)
- ✓ Nederlands spaCy model (nl_core_news_sm)
- ✓ API key configuratie

### 3. Start JokeBloke
```bash
./start_jokebloke.sh
```

Of handmatig:
```bash
voila jokebloke.ipynb --template=lab --theme=dark --port=8866
```

## Gebruik

### Stap 1: Recorder Initialiseren
Klik op **"Boot Recorder"** om de microfoon te activeren.

### Stap 2: Opname Starten
Klik op **"Record"** en begin te praten in het Nederlands.

### Stap 3: Opname Stoppen
Klik op **"Stop"** wanneer je klaar bent met praten.

### Stap 4: Wachten op Reactie
JokeBloke verwerkt je spraak en genereert een grap. Je ziet grappige laadberichten zoals:
- "Humor aan het laden... even geduld alstublieft"
- "Bijna klaar... comedy goud groeit niet op bomen"

### Stap 5: Feedback Geven
Nadat JokeBloke zijn grap heeft verteld:
- Klik op **": )"** als je de grap leuk vond
- Klik op **": ("** als je de grap niet leuk vond

Het systeem leert van je feedback en past de persoonlijkheidsselectie aan!

## Technische Details

### Gewijzigde Bestanden

1. **jokebloke.ipynb**
   - Cel 1: Imports (ongewijzigd)
   - Cel 2: spaCy demo met `nl.examples.sentences` en `nl_core_news_sm`
   - Cel 5: `nlp = spacy.load("nl_core_news_sm")`
   - Cel 7: Nederlandse markdown instructies
   - Cel 8: Nederlandse UI labels, laadberichten, feedback

2. **requirements.txt**
   - Alle pakketten compatibel met Nederlandse taalverwerking
   - spacy==3.7.6 (ondersteunt nl_core_news_sm)

3. **README.md**
   - Taalnotitie toegevoegd
   - spaCy download opdracht gewijzigd naar nl_core_news_sm

4. **test_voila_setup.sh**
   - Controleert nl_core_news_sm model

### Code Voorbeelden

#### Speech Recognition (Nederlands)
```python
text = recognizer.recognize_google(audio, language='nl-NL')
print("Transcriptie:", text)
```

#### Text-to-Speech (Nederlands)
```python
gTTS(text, lang='nl').save(filename)
```

#### spaCy NLP (Nederlands)
```python
nlp = spacy.load("nl_core_news_sm")
doc = nlp("Dit is een Nederlandse zin.")
```

## Testen

### Test Spraakherkenning
Spreek in het Nederlands:
- "Vertel me een grap"
- "Ik hou van komedie"
- "Maak me aan het lachen"

### Test Feedback Systeem
Het systeem leert welke persoonlijkheden je leuk vindt:
- Geef positieve feedback (": )") voor grappen die je leuk vindt
- Het UCB-algoritme zal die persoonlijkheden vaker kiezen

### Test spaCy NLP
De MemoryAgent extraheert Nederlandse grammaticale kenmerken:
- Onderwerpen (subj)
- Lijdend voorwerpen (obj)
- Werkwoorden (verbs)
- Bijvoeglijke naamwoorden (adjectives)
- Named entities (entiteiten)

## Veelgestelde Vragen

### Kan ik terug naar Engels?
Ja! Wijzig de volgende onderdelen:
1. spaCy model: `en_core_web_sm`
2. Speech recognition: `language='en-US'`
3. gTTS: `lang='en'`
4. UI labels en berichten naar Engels

### Werkt dit met Belgisch Nederlands?
Ja, de spraakherkenning ondersteunt `nl-BE` (Belgisch Nederlands). Wijzig in de notebook:
```python
text = recognizer.recognize_google(audio, language='nl-BE')
```

### Ondersteunt het andere Nederlandse dialecten?
De gTTS en spaCy modellen gebruiken standaard Nederlands (ABN - Algemeen Beschaafd Nederlands). Voor regionale varianten kun je aangepaste spaCy modellen trainen.

## Probleemoplossing

### "ModuleNotFoundError: No module named 'spacy'"
```bash
pip install -r requirements.txt
python -m spacy download nl_core_news_sm
```

### "OSError: [E050] Can't find model 'nl_core_news_sm'"
```bash
python -m spacy download nl_core_news_sm
```

### Spraakherkenning werkt niet
- Controleer microfoon permissies in je browser
- Zorg dat je duidelijk spreekt in het Nederlands
- Controleer internet verbinding (Google Speech API vereist dit)

### TTS werkt niet
Als er geen audio device is (zoals in containers):
- De tekst wordt afgedrukt met: "🔊 JokeBloke says: [tekst]"
- Dit is normaal gedrag in headless omgevingen

## Ondersteuning

Voor problemen of vragen:
1. Controleer [README.md](README.md) voor algemene instructies
2. Bekijk [VOILA_DEPLOYMENT.md](VOILA_DEPLOYMENT.md) voor deployment info
3. Test met `./test_voila_setup.sh`

## Licentie

Zie [LICENSE](LICENSE) bestand.

---

**Veel plezier met JokeBloke in het Nederlands! 🎭🇳🇱**
