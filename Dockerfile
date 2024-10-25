# Build stage
FROM caddy:2-builder AS builder

RUN xcaddy build \
  --with github.com/caddy-dns/cloudflare

# Final stage
FROM caddy:2

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Add labels for better container identification
LABEL maintainer="Adrian Goodyer" \
  description="Caddy with Cloudflare DNS module" \
  org.opencontainers.image.source="https://github.com/adegoodyer/caddy-cloudflare"

# Expose ports
EXPOSE 80 443 443/udp 2019

# Set up volumes for Caddy
VOLUME /data
VOLUME /config