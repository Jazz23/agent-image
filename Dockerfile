FROM mcr.microsoft.com/playwright:v1.58.2-noble

COPY --from=oven/bun:1 /usr/local/bin/bun /usr/local/bin/bun
COPY --from=oven/bun:1 /usr/local/bin/bunx /usr/local/bin/bunx

ENV SHELL="/bin/bash"
ENV PATH="/root/.opencode/bin:/root/.bun/bin:${PATH}"

RUN apt-get update && apt-get install -y --no-install-recommends ripgrep fzf && rm -rf /var/lib/apt/lists/*
RUN touch /root/.bashrc && curl -fsSL https://raw.githubusercontent.com/opencode-ai/opencode/refs/heads/main/install | bash
RUN bun install -g @playwright/cli@latest
RUN bunx playwright install-deps chromium
RUN playwright-cli install-browser chromium
