#!/bin/bash
PORT=${PORT:-18789}
curl -sf http://localhost:$PORT/health && echo "OK" || exit 1
