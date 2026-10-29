#!/usr/bin/env bash
set -euo pipefail

# Keep runtime dependencies outside the checkout.
runtime_root="${CANDY_AGENT_BROWSER_PREFIX:-/workspace/shared/tools/agent-browser}"
version="0.40.0"
command -v node >/dev/null
command -v npm >/dev/null
node -e 'if (Number(process.versions.node.split(".")[0]) < 24) { throw new Error("agent-browser requires Node.js >= 24"); }'

if [[ ! -x "$runtime_root/node_modules/.bin/agent-browser" ]] || \
   [[ "$("$runtime_root/node_modules/.bin/agent-browser" --version)" != "agent-browser $version" ]]; then
  mkdir -p "$runtime_root"
  npm install --prefix "$runtime_root" --no-audit --no-fund --save-exact "agent-browser@$version"
fi

"$runtime_root/node_modules/.bin/agent-browser" --version
browser_path="${AGENT_BROWSER_EXECUTABLE_PATH:-$(command -v chromium || true)}"
if [[ -z "$browser_path" || ! -x "$browser_path" ]]; then
  echo 'Chromium is required. Install it or set AGENT_BROWSER_EXECUTABLE_PATH to an existing browser.' >&2
  exit 1
fi
"$browser_path" --version
printf 'Runtime ready. Add %s/node_modules/.bin to PATH.\n' "$runtime_root"
