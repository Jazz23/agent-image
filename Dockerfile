FROM ghcr.io/kelos-dev/opencode:latest

COPY --from=oven/bun:1 /usr/local/bin/bun /usr/local/bin/bun
COPY --from=oven/bun:1 /usr/local/bin/bunx /usr/local/bin/bunx

ENV PATH="/home/agent/.bun/bin:${PATH}"
ENV PLAYWRIGHT_BROWSERS_PATH=/ms-playwright

RUN bun install -g @playwright/cli@latest

USER root

RUN playwright-cli install-browser chrome-for-testing --with-deps \
    && chown -R agent:agent /ms-playwright

USER agent

COPY cli.config.json /home/agent/.playwright/cli.config.json
