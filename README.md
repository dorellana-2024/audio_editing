# 🎧 Audio Diarization Project (pyannote.audio)

Proyecto para diarización de hablantes usando pyannote.audio y modelos de Hugging Face, orientado a procesamiento de audio infantil/adulto en archivos .wav.

## 📌 Descripción

Este proyecto utiliza el pipeline pyannote/speaker-diarization-3.0 para:
- detectar segmentos de voz
- identificar hablantes distintos
- preparar el audio para cortes posteriores

Está configurado para funcionar correctamente en Windows, evitando problemas comunes con:
- symlinks
- permisos
- versiones incompatibles de Torch / Pyannote

## 🧱 Requisitos del sistema

- Windows 10 / 11
- Python 3.10.11
- Git
- Cuenta en Hugging Face con acceso a modelos pyannote/
- FFmpeg instalado y disponible en PATH
    - https://www.gyan.dev/ffmpeg/builds/
    - Download: ffmpeg-release-essentials.zip

## 🐍 Entorno virtual

Crear entorno virtual
```bash
py -3.10 -m venv venv
```
Activar entorno
```bash
venv\Scripts\activate
```
Verificar:
```bash
python --version
# Python 3.10.11
```

## 📦 Dependencias
```txt
# requirements.in
pyannote.audio==3.1.1
torch==2.1.2
torchaudio==2.1.2

onnxruntime==1.16.3

pydub
numpy<2.0

ipywidgets>=8,<9
python-dotenv>=1.0.0,<2.0
huggingface-hub==0.19.4
```

Instalar dependencias

```bash
pip install --upgrade pip
pip install pip-tools
pip-compile requirements.in
pip install -r requirements.txt
```

💡 requirements.txt debe generarse con pip-compile si se usa pip-tools.

## 🔐 Token de Hugging Face

1. Crear token

👉 https://huggingface.co/settings/tokens

Permisos necesarios: READ

2. Aceptar modelos (una sola vez)
- https://huggingface.co/pyannote/speaker-diarization-3.0
- https://huggingface.co/pyannote/segmentation-3.0

Debe decir:
✅ You have been granted access to this model

## 🌱 Variables de entorno

Crear archivo .env en la raíz del proyecto:

```.env
PYANNOTE_HF_TOKEN=hf_xxxxxxxxxxxxxxxxxxxxx
```

## 🧠 Código base (main.ipynb)
```py
import os

# --- Windows / Hugging Face fixes ---
os.environ["HF_HUB_DISABLE_SYMLINKS"] = "1"
os.environ["HF_HUB_DISABLE_SYMLINKS_WARNING"] = "1"
os.environ["SPEECHBRAIN_CACHE_STRATEGY"] = "copy"

from dotenv import load_dotenv
from pydub import AudioSegment
from pyannote.audio import Pipeline

# Widgets (opcional, Jupyter)
import ipywidgets as widgets
widgets.IntSlider()

# Load env variables
load_dotenv()

HF_TOKEN = os.getenv("PYANNOTE_HF_TOKEN")
assert HF_TOKEN, "PYANNOTE_HF_TOKEN not defined."

# Load diarization pipeline
pipeline = Pipeline.from_pretrained(
    "pyannote/speaker-diarization-3.0",
    use_auth_token=HF_TOKEN
)
```

## ⚠️ Advertencias esperadas (NO errores)

```terminal
UserWarning: torchaudio._backend.get_audio_backend has been deprecated
UserWarning: speechbrain.pretrained was deprecated
UserWarning: AudioMetaData has been moved
```

## 🧹 Estructura del proyecto
```txt
audio_editing/
│
├─ notebooks/
│   └─ main.ipynb
│
├─ audios/
│   └─ input.wav
│
├─ output/
│
├─ .env
├─ requirements.in
├─ requirements.txt
├─ README.md
└─ venv_py3.10/
```
