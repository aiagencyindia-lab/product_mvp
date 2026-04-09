FROM node:24-slim

# Install system dependencies for audio processing
RUN apt-get update && apt-get install -y \
    curl \
    git \
    ffmpeg \
    python3 \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install OpenClaw globally
RUN npm install -g openclaw@latest

# Set working directory
WORKDIR /app

# Copy config and agents to staging area (NOT directly to /root/.openclaw)
COPY config/openclaw.json ./config/openclaw.json
COPY agents/ ./agents/

# Copy scripts
COPY scripts/ ./scripts/
RUN chmod +x ./scripts/*.sh

# Expose the Railway-assigned port
EXPOSE ${PORT:-18789}

# Health check endpoint
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:${PORT:-18789}/health || exit 1

# Copy config at runtime (so persistent volume doesn't shadow it), then start gateway
CMD ["sh", "-c", "\
  mkdir -p /root/.openclaw/workspace/skills && \
  cp -f /app/config/openclaw.json /root/.openclaw/openclaw.json && \
  cp -rf /app/agents/* /root/.openclaw/workspace/skills/ && \
  openclaw gateway --port ${PORT:-18789} --verbose \
"]

