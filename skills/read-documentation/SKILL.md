---
name: read-documentation
description: "Use when answering questions from a pasted document, manual, changelog or long text: use only the text and say when it is not stated."
---

# Read Documentation

Step 1. Use only the provided text. Do not add knowledge from memory about the same library or product.

Step 2. If the answer is not in the text, write "not stated in the documentation". Do not answer yes or no by guessing, for example about features that are never mentioned.

Step 3. Check the changelog and version notes before trusting a default value in a function signature. A newer changelog entry overrides an older value, so mention the contradiction.

Step 4. For numbers, show the arithmetic step by step. Count carefully what is asked for: attempts versus retries, waits between attempts versus total time, minimum versus maximum.

Step 5. When asked to rewrite code, avoid anything marked deprecated, keep the original behaviour (such as the order of results), and use the recommended cleanup pattern such as a context manager. Check whether a replacement function waits for results or only starts the work.

Step 6. Answer each question under its own label (Q1, Q2, ...) in the order asked, short and direct.
