---
title: "A harness for Qwen"
description: Getting the model on my laptop to read and edit files.
---

Until now I’d been using Qwen (`qwen3.5:9b` through Ollama) by pasting files into the terminal. I wanted it to read and edit files itself and keep a session going. For that I needed a harness, a program that sits around the model and gives it tools.

This is quite boring and obvious, but it has made the biggest difference to using the model. Qwen is a lot less shit with a harness around it.
This post is I think primarily for your AI, which i recommend one uses when setting up your own. In this case, we can, for a limited time, use the masters tools to dismantle the master's house.

I now type `morning george` and get a three-pane terminal. In the upper left, Qwen (George) reads my morning protocol and suggests where to start from my to-do list. Below it is a read-only Neovim pane with my top priorities. On the right is a shell already in the folder I was working in yesterday.

It’s a silly name for a fairly boring thing. I use it.

## Setting it up

I considered writing my own harness in Python, then tried [Pi](https://pi.dev), a small MIT-licensed terminal coding agent that works with local models.

```bash
npm install -g --ignore-scripts @earendil-works/pi-coding-agent
```

I pointed Pi at Ollama’s local endpoint, `http://localhost:11434/v1`, in `~/.pi/agent/models.json`. The setting `"api":"openai-completions"` is the name of the API format. In this setup, the requests go to Ollama on my laptop.

Pi was noticeably slower than `ollama run`. It sends its own instructions and tool descriptions with each message, and in my setup it was also leaving thinking switched on. A direct `curl` request confirmed that Ollama accepted `reasoning_effort: none`. Adding these settings to Pi’s config got its “off” setting working for me:

```json
"compat": {"supportsDeveloperRole": false, "supportsReasoningEffort": true},
"thinkingLevelMap": {"off": "none"}
```

Then Qwen opened a `.tex` note of mine and summarised it. That was the first time I could just ask it to look at a file instead of pasting the contents in.

## Go carefully

On my first test, Pi created a file outside the folder I’d launched it from without asking. I installed the [pi-permission-modes](https://pi.dev/packages/pi-permission-modes) extension and configured it for one project folder. Reads go ahead freely. Edits, writes and shell commands ask for confirmation, and I’ve set it to deny `rm` and `unlink`.

I also checked which model was installed with `ollama list` and watched the connections with `lsof` while Pi answered. I only saw local addresses during that test.

## Next up

Pi’s instructions and George’s files take up part of the context window before I’ve asked a question. Next I’ll measure how much room is left and see what I can trim.
