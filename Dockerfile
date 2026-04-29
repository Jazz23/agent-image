FROM ghcr.io/kelos-dev/opencode:latest

# Install bun and bunx
COPY --from=oven/bun:1 /usr/local/bin/bun /usr/local/bin/bun
COPY --from=oven/bun:1 /usr/local/bin/bunx /usr/local/bin/bunx

# Setup PATH for bun globals
ENV PATH="/home/agent/.bun/bin:${PATH}"

# Install playwright
ENV PLAYWRIGHT_BROWSERS_PATH=/ms-playwright

RUN bun install -g @playwright/cli@latest

USER root

RUN playwright-cli install-browser chrome-for-testing --with-deps \
    && mkdir -p /home/agent/.config/opencode /home/agent/.local/share/opencode /home/agent/.local/state \
    && chown -R agent:agent /ms-playwright /home/agent/.config /home/agent/.local

USER agent

COPY cli.config.json /home/agent/.playwright/cli.config.json

RUN bun install -g opencode-pilot@latest

ENTRYPOINT [""]
