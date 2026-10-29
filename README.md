# Candy 项目技能

图片中的 10 个技能及 3 个共享依赖已安装到 `.agents/skills/`，各技能的内容与下载时的上游版本保持一致。

## 调用方法

使用包含本次提交的仓库版本开启新的 Codex 任务。在支持项目技能发现的会话里输入：

```text
使用 $frontend-design，为这个项目设计一个登录页面。
```

若会话未自动发现技能，可显式给出路径：

```text
请先读取 .agents/skills/frontend-design/SKILL.md，再按该技能完成任务。
```

部分技能只允许显式调用；`agent-browser` 的上游入口还带有 `hidden: true`，不保证在技能选择菜单中显示。可通过路径显式加载。新任务中的自动发现与实际技能执行结果尚需在新会话中确认。

## 已安装技能

| 图片序号 | 技能 | 上游仓库 |
| --- | --- | --- |
| 1 | find-skills | vercel-labs/skills |
| 2 | grill-me | mattpocock/skills |
| 3 | grill-with-docs | mattpocock/skills |
| 4 | improve-codebase-architecture | mattpocock/skills |
| 5 | agent-browser | vercel-labs/agent-browser |
| 6 | tdd | mattpocock/skills |
| 7 | setup-matt-pocock-skills | mattpocock/skills |
| 8 | frontend-design | anthropics/skills |
| 9 | handoff | mattpocock/skills |
| 10 | triage | mattpocock/skills |

同时安装 `grilling`、`domain-modeling`、`codebase-design`，供其他技能调用。来源提交、文件哈希与安装路径记录在 `.agents/skill-sources.json`，相关许可证保留在 `.agents/skill-licenses/`。

## agent-browser 运行依赖

此云环境已有 Node.js 24 和 `/usr/bin/chromium`。运行下面的脚本可安装或检查固定版本的 CLI；依赖放在仓库外，不会改动项目依赖文件。

```bash
cd /workspace/candy
bash scripts/setup-agent-browser.sh
export PATH="/workspace/shared/tools/agent-browser/node_modules/.bin:$PATH"
export AGENT_BROWSER_EXECUTABLE_PATH=/usr/bin/chromium
agent-browser skills get core
```

使用已有 Chromium，无需额外下载浏览器。未来任务需要重新设置上述 PATH 与浏览器路径；云环境启动说明也会保存这些步骤。浏览器会话不会随环境快照保留。

`setup-matt-pocock-skills` 是项目配置技能，不是文件安装器；需要时再显式调用它配置任务跟踪、标签和领域文档。本次未执行这些项目配置，也未运行其他技能去改动代码或外部服务。
