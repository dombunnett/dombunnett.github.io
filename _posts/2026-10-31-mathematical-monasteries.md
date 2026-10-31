---
title: "Mathematical monasteries"
description: My own small steps towards independence from the AI companies, and why mathematicians should start organising.
---

Since the last post, the model on my laptop (still Qwen 3.5 9B) has become part of how I work. It does pretty well at coding, and it’s nowhere near good enough for serious maths. But for proofreading, grammar checking, debugging and writing small functions, I’m enjoying some mild freedom from OpenAI and Anthropic.

It’s a tiny step, and I’ve been doing maths rather than working on this, but most of the time I don’t open a chat at all. I have two shortcuts in my shell settings. To add them, open `~/.zshrc` in a text editor and paste in:

```bash
alias q='ollama run qwen3.5:9b --think=false'

cmd () {
	ollama run qwen3.5:9b --think=false "I am on a Mac using Terminal. Reply with only the terminal command that does the following, nothing else: no explanation, no backticks. Task: $*"
}
```

Then run `source ~/.zshrc`, or open a new Terminal window. `--think=false` switches off Qwen’s thinking step, so it answers straight away.

`q "why does this sentence sound wrong: …"` asks a single question and prints the answer. `cmd "find every PDF in this folder bigger than 10MB"` replies with just the command, which I read before running it.

Both are context-free. Every call starts from nothing, with no memory of what I asked before, so each question has to contain everything the model needs. (Typing `q` on its own opens a normal chat, which does remember until you type `/bye`.)

More memory means a bigger model, and in the next few weeks I plan to get DeepSeekMath-V2 running on the TU’s computing cluster. That’s already very good at graduate-level exercises in algebraic geometry. I’m taking these steps on my own, but I’m not the only one: more and more people in Berlin and beyond are talking about how to get some independence from these companies.

I’ve hit one wall, and it’s a predictable one: searching the internet. Literature searching is what I enjoy most about Claude or ChatGPT. I ask a question and it reads twenty websites in the time it would take me to read three or four. Something that can do that on my own machine is the natural next step. Once it exists, better hardware will make it very useful very quickly.

## The monasteries

There will be monasteries of mathematics, where people gather to do maths without any help from LLMs. They’ll be rare and, in the medium term, very hard to get into. I can picture groups forming around a few prominent mathematicians, where you arrive and take an oath to produce only “organic” maths. The first signs are already there. Leaders in my field debated where all this is heading on a [panel at this year’s Heidelberg Laureate Forum](https://www.youtube.com/watch?v=H7_d_sgui6o), and some of them have taken the strictest pledge offered by the [Association for Human Mathematics](https://www.ahmath.org/statements): its AI-free caucus, whose members don’t use AI models in their research at all.

But for most of us, the resistance won’t last. The technology exists and it’s very helpful. You can’t stop people using calculators.

## What do I tell my students?

I’m teaching algebraic geometry this semester, mostly to first-year grads and final-year undergrads, and most of them ask me the same thing. If I do a PhD, what will it look like? Will it still be something I enjoy?

It’s a big, unanswerable question. A lot of what’s said about it feels hyperbolic to me, but some of it is accurate. Talk of proofs turning into raw data is more an analogy than the truth, but things will go that way as the models get better.

For now, though, ask one of these models to formalise a sophisticated research-level argument in algebraic geometry and it will eat through even a $200-a-month token limit very quickly. For the average working mathematician, without unlimited access to a frontier model, this isn’t reality yet. It will be, and formalisation still has a lot to figure out, but it will happen at unprecedented speed.

## An out-of-touch argument

Some of the prominent people rallying against this technology warn that it will widen the gap between poorer countries and affluent institutions in Europe, China, India and North America. I find this frustrating. Where was this concern before? Have you been to a maths department in a country left underdeveloped by colonialism? Next to that, the idea that unequal access to AI is the serious issue is wildly out of touch. It’s a shame, because it undermines the many valid points they make.

## A political moment

Still, this is a political moment for mathematicians, and we should take it. Maths attracts smart people, and most of us end up fairly politicised. We should organise: first to work out how to build these technologies for ourselves, and later, I hope, to decide more concretely what we want our academia and our intellectual output to serve.
