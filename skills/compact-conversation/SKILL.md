---
name: compact-conversation
description: "Use when the user says compact, /compact, summarize this chat, the conversation is getting long or slow, or wants to continue in a new chat without losing context."
---

# Compact Conversation

This skill does what /compact does in Claude Code: it turns the whole conversation into a handoff summary that the user can paste as the first message of a fresh chat. A skill cannot erase this chat's history by itself, so say that in one line at the end and tell the user to start a new chat.

If the user wrote a focus after the command, for example "compact, focus on the database schema", keep that topic in full detail and compress the rest harder.

Step 1. Re-read the whole conversation from the start. List every user request, every decision, every fact the user gave, and every piece of code, command, path, number or name that was produced.

Step 2. Write the summary with exactly these headings, in this order:
- Goal: what the user is trying to achieve overall, in one or two sentences.
- Current state: what is finished, what is half finished, what is broken right now.
- Decisions made: each decision with the reason, so it is not argued again.
- Exact details: names, file paths, ports, versions, settings, numbers, error messages and commands, copied character for character. Never paraphrase these.
- Code and text produced: the latest working version of every piece of code or text in full, in code blocks. Do not shorten code. If a version was replaced, keep only the newest.
- Things that failed: approaches that were tried and did not work, with the reason, so they are not tried again.
- User preferences and rules: standing instructions about style, tools, language or format.
- Open questions and next steps: what must happen next, in order.

Step 3. Rules for quality:
- Lossless beats short. Keep everything that a new chat would need to continue without asking again. Only drop greetings, repeated explanations and dead ends that taught nothing.
- Never invent. If something was uncertain or unverified in the chat, mark it "unverified".
- Keep dates, times and the order of events when they matter.
- Do not add new advice or new ideas. Only record what happened.

Step 4. Put the whole summary inside one code block so it can be copied in one click. After the block, write one line: the summary replaces this chat, so open a new chat and paste it as the first message, then continue with "Continue from this summary."
