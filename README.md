# 🌌 Orion — Voice Multi-Agent Assistant

> A voice-commanded multi-agent personal assistant powered by **OpenClaw + OpenAI GPT-4o**, deployed on **Railway**.

Orion gives you a team of AI agents you can talk to — an **Accountant**, a **Social Media Manager**, and a **Project Manager** — all accessible via voice, Slack, Discord, Telegram, or web chat.

---

## ⚡ Quick Start

### 1. Clone & configure

```bash
git clone <your-repo-url> orion
cd orion
cp .env.example .env
```

### 2. Fill in your environment variables

Open `.env` and set at minimum:

| Variable | Required | Description |
|---|---|---|
| `OPENAI_API_KEY` | ✅ | Your OpenAI API key |
| `OPENCLAW_GATEWAY_PASSWORD` | ✅ | Password to protect the gateway |
| `ELEVENLABS_API_KEY` | Optional | For voice TTS responses |
| `ELEVENLABS_VOICE_ID` | Optional | ElevenLabs voice to use |
| `SLACK_BOT_TOKEN` | Optional | Slack bot OAuth token |
| `SLACK_APP_TOKEN` | Optional | Slack app-level token |
| `DISCORD_BOT_TOKEN` | Optional | Discord bot token |
| `TELEGRAM_BOT_TOKEN` | Optional | Telegram bot token |

### 3. Run locally with Docker

```bash
docker compose up --build
```

The gateway will be available at `http://localhost:18789`.

### 4. Verify health

```bash
curl http://localhost:18789/health
```

---

## 🚀 Deploy to Railway

```bash
# Install Railway CLI if you haven't
npm install -g @railway/cli

# Login & deploy
railway login
railway init
railway up
```

Then set your environment variables in the **Railway Dashboard → Variables** tab.

---

## 🎙️ Voice Commands

### 💰 Accountant Agent

| Command | Action |
|---|---|
| "Orion, create invoice for [client] for [amount]" | Generate invoice file |
| "Orion, what's my budget status?" | Voice summary of spend vs budget |
| "Orion, log expense: [amount] for [category]" | Append to expenses ledger |
| "Orion, send invoice to [email]" | Compose and send via Gmail |

### 📱 Social Media Manager Agent

| Command | Action |
|---|---|
| "Orion, write a LinkedIn post about [topic]" | Draft + show for approval |
| "Orion, what should I post today?" | Pull from calendar, suggest content |
| "Orion, schedule content for this week on [theme]" | Generate 5-day plan |
| "Orion, how did my last post do?" | Scrape public engagement metrics |

### 📋 Project Manager Agent

| Command | Action |
|---|---|
| "Orion, add task: [description] due [date]" | Append to backlog |
| "Orion, what's blocking us?" | Scan for overdue/flagged tasks |
| "Orion, run standup" | Generate standup, post to Slack |
| "Orion, close task [id or name]" | Mark complete and log |
| "Orion, weekly report" | Summarise sprint progress |

---

## ⏰ Scheduled Jobs (Cron)

| Job | Schedule | Agent |
|---|---|---|
| Morning Briefing | 8:00 AM daily | Project Manager |
| End-of-Day Summary | 6:00 PM Mon–Fri | Accountant |

---

## 📱 Connect macOS/iOS for Voice Wake

To use Orion with voice wake on your Mac or iPhone:

1. **macOS**: Use the OpenClaw desktop companion app or connect via the webchat interface at `https://your-railway-url.up.railway.app`
2. **iOS**: Use the OpenClaw mobile app and pair it with your gateway URL
3. **Voice wake**: Configure your device's voice assistant to trigger OpenClaw via a Shortcut (Siri → "Hey Orion" → forwards to gateway)

### Pairing a mobile node

```bash
# On your gateway, generate a pairing code
openclaw pair --generate

# On your mobile app, enter the pairing code to connect
```

---

## 🏗️ Project Structure

```
orion/
├── .railway/config.json        # Railway environment config
├── agents/
│   ├── accountant/SKILL.md     # Accountant agent skills
│   ├── social-manager/SKILL.md # Social media agent skills
│   └── project-manager/SKILL.md# Project manager agent skills
├── config/openclaw.json        # OpenClaw gateway configuration
├── scripts/
│   ├── setup.sh                # Workspace initialisation
│   └── health-check.sh         # Health check for Docker
├── Dockerfile                  # Railway-optimised container
├── docker-compose.yml          # Local development
├── railway.json                # Railway deployment config
├── .env.example                # Environment variable template
└── .gitignore                  # Git ignore rules
```

---

## 🔒 Security

- **Never commit `.env`** — it's in `.gitignore`
- Gateway is password-protected via `OPENCLAW_GATEWAY_PASSWORD`
- All API keys are injected as environment variables
- Credentials directory is excluded from version control

---

## 📄 License

MIT
