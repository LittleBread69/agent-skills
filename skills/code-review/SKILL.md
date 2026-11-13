---
name: code-review
description: Use when writing, reviewing or debugging code (Python, C++, C#, JavaScript and others), or when the user pastes code, a diff or a pull request: checks the spec, correctness, edge cases, language traps, standards and security, and reports findings by severity.
---

# Code Review

This skill reviews code on separate axes and reports every finding with evidence. It combines three ideas: review against what was asked (Spec), review against the rules of the codebase (Standards), and review of whether the code is actually correct (Correctness). Findings are hypotheses to be checked, not verdicts.

## Phase 0. Fix the scope
- Identify exactly what is under review: a pasted file, a snippet, or a diff. For a diff, review the changed lines first, then the code around them that they call or that calls them. Do not review code that was not shown.
- You cannot run git, tests or the code. Never say "tests pass", "this compiles" or "this runs" as a fact. Say what you traced by hand.
- If the user refers to a repository, branch, issue or file you cannot see, say which one and ask for the diff or the text. Do not invent its contents.
- If the change is very large (roughly more than 400 changed lines or many unrelated files), say so, recommend splitting it, and review it file by file.
- Fresh eyes: if the code was written earlier in this same chat, re-read it as a stranger would, and say that an independent review in a new chat is stronger.

## Phase 1. Understand the intent (the Spec)
- Find what the code is supposed to do, in this order: the user's own request, an issue or ticket text pasted by the user, a docstring or comment, test names, then the code itself.
- State the intent in one or two lines. If you had to guess it, write "Assumed intent:" and mark every Spec finding as lower confidence.
- Spec axis questions: Does the code do everything that was asked? Does it do anything that was not asked (extra behaviour, scope creep, unrelated edits)? Are the stated edge cases handled? Does the behaviour match the examples given?

## Phase 2. Correctness (trace it)
- Trace the code by hand with one small concrete input, line by line, writing the value of each variable. Do this before claiming what it prints or returns. Pay attention to evaluation order and operator precedence.
- Then trace a second input that is an edge case: empty, zero, one element, negative, very large, wrong type, None or null, whitespace, strings that look valid but are not, duplicates, unsorted data.
- Check loop bounds (off by one), integer overflow and division, floating point comparison, and unit or timezone mix-ups.
- Check error handling: swallowed exceptions, bare except, errors returned but not checked, resources not released on the error path, partial failure leaving inconsistent state.
- Check concurrency when threads, async code or shared state appear: races, missing locks, blocking calls inside async code, shared mutable state.
- Language traps:
  - Python: mutable default arguments are created once and shared; lambdas or closures in a loop look up the variable when called (late binding); is versus ==; modifying a list while iterating it; regex fullmatch versus match; integer versus true division; a generator can be consumed only once; missing await.
  - C++: push_back or insert can reallocate a vector and invalidate iterators, pointers and references; dangling reference to a temporary; use after move; object slicing; missing virtual destructor; uninitialized variables; signed and unsigned comparison; rule of three or five; raw new without a matching delete or smart pointer.
  - C#: LINQ is lazy, so it runs at enumeration time and may run more than once; modifying a collection during foreach; async void; missing await; IDisposable without using; string comparison culture; null reference with nullable types; captured loop variables.
  - JavaScript or TypeScript: == versus ===; this binding; async functions without await; floating point; mutating shared objects; array sort without a comparator sorts as strings.
  - SQL or shell if present: injection through string building, unquoted variables, missing WHERE on update or delete.
- For new code, also check: type hints or types present, a docstring or comment saying why, and asserts or validation at the input boundary.

## Phase 3. Security
Check input that comes from outside: injection (SQL, shell, template), path traversal, unsafe deserialization, hard-coded secrets or keys, missing authorization checks, logging of sensitive data, unsafe randomness for secrets, unbounded input size.

## Phase 4. Standards (the codebase rules)
- If the user pasted or described conventions (style guide, lint rules, project notes, naming rules), those are the standard. Cite the rule by its wording for every Standards finding.
- If there are none, say so and use this baseline of common code smells (Fowler style): long function, large class, duplicated code, long parameter list, feature envy, primitive obsession, data clumps, shotgun surgery, divergent change, speculative generality, message chains, dead code, misleading names, and comments that explain what instead of why.
- Also check: naming, function size and single responsibility, consistency with the surrounding code, public API and backward compatibility, tests present for new behaviour and for the bug being fixed, and performance only where it is clearly wrong (a query in a loop, quadratic work on large input).

## Phase 5. Report
Use these severity labels:
- blocking: wrong result, crash, data loss, security hole or a broken requirement. Must be fixed.
- important: likely bug, fragile logic or a missing test for risky behaviour. Should be fixed.
- nit: style or small cleanup. Optional.
- suggestion: a better approach that is not required.
- learning: a short explanation that helps the author, not a defect.
- praise: something done well. Include at least one if it is true.

Format, with separate headings and no merged verdict:
1. Intent: one or two lines (mark as assumed if guessed).
2. Spec findings.
3. Correctness findings.
4. Security findings.
5. Standards findings.
6. Counts per severity, and the questions you could not answer because code or context was missing.

Every finding must have: severity, location (function name, line or quoted snippet), what is wrong, the evidence (the trace, the rule or the input that breaks it), and the smallest fix as a short code block. Add a confidence of high, medium or low. A finding without evidence must be dropped or marked low confidence.

## Rules
- Do not invent APIs, functions, library behaviour or line numbers. If unsure whether a library behaves a certain way, say you are unsure.
- Do not rewrite the whole program. Give the minimal fix for each finding.
- Do not pad the review. If a phase has no findings, write "none found" for that phase.
- The human decides. Do not approve or reject; give the findings and the counts.
- If sub-agents are available you may run the Spec and Standards passes separately, and you must tell any sub-agent not to call this skill again. On slow local models, do the passes yourself one after another instead.
