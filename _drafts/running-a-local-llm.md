---
title: "Buying chalk from BAE Systems"
description: I'm running a language model on my laptop, with on 16GB of memory and it's fine.
---

After OpenAI’s most recent “math dump”, I realised, along with many of my colleagues, that the way we do research mathematics is going to change fundamentally. Listening to an interview with the Fields medallist Martin Hairer also brought home how little reason we have to expect the current honeymoon period to last. OpenAI has already announced an increase from US$200 to US$500 a month for its Pro service, alongside usage cuts for lower tiers. Becoming dependent on these tools means becoming dependent on companies that can change the terms of access whenever they choose.

I use these tools myself. I feel that I need to use them to stay competitive, and until I have a permanent job, I don’t feel I can afford to be principled about it. That is an uncomfortable position to be in, and part of what has prompted this project.

Alongside the cost and the privacy concerns, I have a fairly basic animosity towards these enormous, amoral corporations. I don’t want my working life to depend entirely on products from companies whose technologies are also used in military operations in Palestine, ICE enforcement in the US, and other horrendously violent systems. From a moral perspective, it feels like buying chalk from BAE Systems.

There is also the question of autonomy. We are building these products into our working lives without much control over their availability, their behaviour or what happens to the information we give them. We pour our research ideas into them. When we use them to help navigate bureaucracy, we hand over extraordinary amounts of personal information too. I find these tools useful enough to keep doing this, but I want a way to work that I feel more comfortable with.

So I have started experimenting with running a language model on my own laptop. I want to understand how to run these models, adapt them and make them useful for my own work. As open-source models and the systems around them improve, I want to be ready to use them.

Universities, or individual mathematics departments, seem like reasonable places to host models that researchers can use collectively. Perhaps it will take five or six years before the hardware and energy requirements make that realistic for every department. In the meantime, we can start developing the knowledge needed to run them and make decisions about how we want to use them.

This blog will record my attempts to learn some of that: what I can run on the computer I already own, how I set it up, what works and what doesn’t. The first step is modest: getting a model running on a laptop with 16GB of memory.

## What fits in 16GB

My machine is a MacBook Pro with Apple silicon and 16GB of unified memory. That one
number decides almost everything.

On Apple silicon the memory is shared between the system and the GPU. After macOS and
whatever else is running, a realistic budget for the model itself is roughly 9–10GB.
My original plan was a 27-billion-parameter Qwen model. Even compressed to about 4 bits
per weight it is around 17GB, more than the machine has in total. So that was out.

| Model | Size (4-bit) | Fits? |
|---|---|---|
| Qwen 3.6 27B | ~17 GB | No |
| Qwen 3.5 9B | ~6.6 GB | Yes, for chatting |
| Qwen 3.5 4B | ~3.4 GB | Yes, and small enough to train on |

## Installing it

The tool I use to run the model is [Ollama](https://ollama.com). Installing it and
downloading the model takes a few commands:

```bash
brew install ollama
ollama serve              # starts Ollama; leave this terminal open
```

and then, in a second terminal,

```bash
ollama pull qwen3.5:9b    # downloads the model, about 6.6GB
```

after which

```bash
ollama run qwen3.5:9b
```

opens a chat in the terminal.
