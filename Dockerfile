FROM mcr.microsoft.com/playwright:v1.58.2-noble

COPY --from=oven/bun:1 /usr/local/bin/bun /usr/local/bin/bun
COPY --from=oven/bun:1 /usr/local/bin/bunx /usr/local/bin/bunx

ENV PATH="/root/.bun/bin:${PATH}"

RUN bun install -g @playwright/cli@latest
RUN bunx playwright install-deps chromium
RUN playwright-cli install-browser chromium
