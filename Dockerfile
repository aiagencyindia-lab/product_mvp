FROM node:24-slim

# Install system dependencies for audio processing
RUN apt-get update && apt-get install -y \
    curl \
    git \
    ffmpeg \
    python3 \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install OpenAI CLI (optional, for direct API testing)
# RUN npm install -g openai@latest

# Install OpenClaw globally
RUN npm install -g openclaw@latest

# Set working directory
WORKDIR /app

# Copy config files
COPY config/openclaw.json /root/.openclaw/openclaw.json
COPY agents/ /root/.openclaw/workspace/skills/

# Copy scripts
COPY scripts/ ./scripts/
RUN chmod +x ./scripts/*.sh

# Expose the Railway-assigned port
EXPOSE $PORT

# Health check endpoint
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:${PORT:-18789}/health || exit 1

# Start OpenClaw gateway
CMD ["sh", "-c", "openclaw gateway --port ${PORT:-18789} --host 0.0.0.0 --verbose"]
