FROM n8nio/n8n:latest

USER root

# Install additional dependencies if needed
RUN apk add --no-cache \
    python3 \
    py3-pip \
    git \
    curl \
    && rm -rf /var/cache/apk/*

# Create necessary directories
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n

USER node

# Expose port
EXPOSE 5678

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:5678/healthz || exit 1

# Set working directory
WORKDIR /home/node

# Entry point is already set in base image