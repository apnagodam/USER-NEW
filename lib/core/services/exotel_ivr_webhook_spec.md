# Apna Godam - Exotel AI IVR Webhook & Voice Bot Specification

This document explains the end-to-end architecture and backend implementation for **Exotel AI IVR Calling** in Apna Godam.

---

## 1. How Exotel AI Voice Calling Works

```
1. User requests call in Flutter App
       │
       ▼
2. Flutter app calls Exotel API: POST /v1/Accounts/{SID}/Calls/connect.json
       │
       ▼
3. Exotel dials User's GSM/Mobile phone
       │
       ▼
4. User picks up phone ──> Exotel invokes Passthru Webhook (Your Server)
       │
       ▼
5. Webhook plays AI Greeting ("राम-राम सा! मैं अपना गोदाम AI...") 
   and records / gathers user's spoken voice query
       │
       ▼
6. Server transcribes user speech (ASR) & queries Apna Godam AI 
   (Claude 3.5 / Hugging Face Qwen 2.5 + Mandi Data + Business Glossary)
       │
       ▼
7. AI answer is synthesized into Indian voice audio (TTS: Hindi/Marwari)
       │
       ▼
8. Exotel plays audio response back into the active phone call
```

---

## 2. Exotel Dashboard Applet Setup

In your Exotel Dashboard (**App Bazaar > Create App**):

1. **Create a new Flow**: Name it `ApnaGodam_AI_IVR`.
2. Add a **Passthru Applet**:
   - **URL**: `https://api.apnagodam.com/ai/exotel-ivr-webhook`
   - **HTTP Method**: `POST`
   - **Timeout**: `10 seconds`
3. Add a **Gather Applet** (or Record Audio Applet) after Passthru:
   - Max recording time: 10 seconds
   - Finish on silence or keypress
4. Connect the **Flow App ID** to your Exotel Virtual Number (Exophone) or specify the App ID in `AppConfig.exotelAppId`.

---

## 3. Ready-to-use Backend Webhook (Node.js / Express Example)

```javascript
const express = require('express');
const axios = require('axios');
const app = express();
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// Exotel Passthru Webhook Endpoint
app.post('/ai/exotel-ivr-webhook', async (req, res) => {
  const { CallSid, From, To, CustomField, RecordingUrl, Digits } = req.body;
  
  let metadata = {};
  try {
    if (CustomField) metadata = JSON.parse(CustomField);
  } catch (e) {}

  const language = metadata.language || 'hi';
  const topic = metadata.topic || 'mandi_rates';
  const userQuery = metadata.query || '';

  // 1. Initial Greeting when call connects
  if (!RecordingUrl && !Digits) {
    const greetingText = language === 'mwr'
      ? 'राम-राम सा! मैं अपना गोदाम रो AI सहायक हूँ। आप मंडी भाव या वेयरहाउस बारै में पूछ सको हो।'
      : 'राम-राम! मैं अपना गोदाम AI सहायक हूँ। आप मंडी भाव, वेयरहाउस या व्यापार संबंधी कोई भी सवाल पूछ सकते हैं।';

    // Return Exotel Voice XML (ExoML)
    res.set('Content-Type', 'text/xml');
    return res.send(`
      <Response>
        <Say voice="female" language="hi-IN">${greetingText}</Say>
        <Record action="https://api.apnagodam.com/ai/exotel-ivr-process-audio" 
                maxLength="12" 
                finishOnKey="#" 
                playBeep="true" />
      </Response>
    `);
  }
});

// Audio Processing & AI Response Endpoint
app.post('/ai/exotel-ivr-process-audio', async (req, res) => {
  const { RecordingUrl, CallSid, From } = req.body;

  try {
    // 1. Download user audio & Transcribe (e.g. HuggingFace / OpenAI Whisper / Sarvam AI)
    // 2. Query Claude 3.5 / Hugging Face with Apna Godam Mandi Data & Q&A
    const aiResponseText = "आज खाटूश्यामजी मंडी में जौ का भाव ₹2230 प्रति क्विंटल चल रहा है।";

    // 3. Return response to play to the user
    res.set('Content-Type', 'text/xml');
    return res.send(`
      <Response>
        <Say voice="female" language="hi-IN">${aiResponseText}</Say>
        <Say language="hi-IN">क्या आपका कोई और सवाल है? बीप के बाद बोलें।</Say>
        <Record action="https://api.apnagodam.com/ai/exotel-ivr-process-audio" maxLength="10" />
      </Response>
    `);
  } catch (error) {
    res.set('Content-Type', 'text/xml');
    return res.send(`
      <Response>
        <Say language="hi-IN">क्षमा करें, तकनीकी समस्या के कारण मैं आपका उत्तर नहीं दे पाया। हमारे प्रतिनिधि आपसे जल्द संपर्क करेंगे।</Say>
        <Hangup />
      </Response>
    `);
  }
});

app.listen(3000, () => console.log('Apna Godam AI IVR Server running on port 3000'));
```

---

## 4. Python FastAPI Implementation

```python
from fastapi import FastAPI, Form, Response
import json

app = FastAPI()

@app.post("/ai/exotel-ivr-webhook")
async def handle_ivr(
    CallSid: str = Form(None),
    From: str = Form(None),
    CustomField: str = Form(None)
):
    metadata = {}
    if CustomField:
        try:
            metadata = json.loads(CustomField)
        except:
            pass

    greeting = "राम-राम सा! मैं अपना गोदाम AI सहायक हूँ। आप कृषि व्यापार, फसल भाव व वेयरहाउस की जानकारी पूछ सकते हैं।"
    
    xml_response = f"""<?xml version="1.0" encoding="UTF-8"?>
<Response>
    <Say voice="female" language="hi-IN">{greeting}</Say>
    <Record action="https://api.apnagodam.com/ai/exotel-ivr-process-audio" maxLength="12" playBeep="true" />
</Response>"""

    return Response(content=xml_response, media_type="text/xml")
```
