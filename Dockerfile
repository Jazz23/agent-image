FROM ghcr.io/kelos-dev/opencode:latest

COPY --from=oven/bun:1 /usr/local/bin/bun /usr/local/bin/bun
COPY --from=oven/bun:1 /usr/local/bin/bunx /usr/local/bin/bunx

ENV PATH="/home/agent/.bun/bin:${PATH}"

USER root
RUN bunx playwright install-deps chromium
USER agent

RUN bun install -g @playwright/cli@latest
RUN playwright-cli install-browser chromium
