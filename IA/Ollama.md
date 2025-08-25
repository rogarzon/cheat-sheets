# How to call an Ollama‑hosted model over HTTP

Ollama ships a tiny HTTP server that listens on port 11434 by default (you can change it with `--port` or an environment variable).
Once the server is running you can hit its REST endpoints just like any other API.

## 1. Start the Ollama server

```bash
# Install Ollama first (skip if already installed)
curl -fsSL https://ollama.com/install.sh | sh

# Start the server (it will stay running in the foreground)
ollama serve
```

If you want the server to listen on another port:

```bash
OLLAMA_PORT=12345 ollama serve
```

## 2. Choose the right endpoint

| Endpoint      | Purpose                                   | Typical request body                                                           |
|---------------|-------------------------------------------|--------------------------------------------------------------------------------|
| /api/generate | Prompt‑only generation (old API)          | {"model":"<name>","prompt":"…", "stream":false}                                |
| /api/predict  | Prompt‑only generation (new API)          | {"model":"<name>","prompt":"…", "stream":false}                                |
| /api/chat     | Chat (system / user / assistant messages) | {"model":"<name>", "messages":[{"role":"user","content":"…"}], "stream":false} |

**Why two “prompt” endpoints?**
`predict` is the newer, more consistent API; `generate` is kept for backward compatibility.
They both accept the same JSON schema for the non‑streaming case.

## 3. What the request must contain

* Content‑Type: application/json
* Body: a JSON object with at least a model field.
    - Depending on the endpoint you also need:
        - prompt (string) or messages (array of {role, content})
        - stream (boolean) – true streams the answer token‑by‑token, false returns a single body.
        - (optional) temperature, top_k, top_p, max_tokens, etc.
          Example 1 – Prompt‑only (no streaming)

# Set Ollama to listen on all interfaces

Set the `OLLAMA_HOST` environment variable in `/etc/systemd/system/ollama.service` file under the `[Service]` section, adding a line like this:

```
[Service]
.....
Environment="OLLAMA_HOST=0.0.0.0:11434"
```

Then reload the systemd configuration and restart the Ollama service:

```bash
  sudos systemctl daemon-reload
  sudos systemctl restart ollama
```