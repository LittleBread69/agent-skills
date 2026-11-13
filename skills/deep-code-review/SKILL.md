---
name: deep-code-review
description: "Use when reviewing, checking or debugging code, a diff, a branch or a pull request (Python, C++, C#, JavaScript and others): checks the spec, correctness, edge cases, language traps, security and standards, runs the tests where possible, and reports findings by severity."
---

# Deep Code Review

This skill reviews code on separate axes and reports every finding with evidence. It combines three ideas: review against what was asked (Spec), review against the rules of the codebase (Standards), and review of whether the code is actually correct (Correctness). Findings are hypotheses to be checked, not verdicts.

## Phase 0. Fix the scope
- Identify exactly what is under review: files, a diff, a branch or a pull request. For a diff, use `git diff` (or `git diff <base>...HEAD`) and review the changed lines first, then the code around them that they call or that calls them.
- Use the grep and glob tools to find callers and definitions instead of reading whole folders. Keep search results short.
- You can run commands. Run the existing tests (and a linter or type checker if the project has one) before and after reasoning about the code, and report exactly which commands you ran and their result. Never claim that tests pass or that code compiles without having run it; if you could not run it, say so and say what you traced by hand instead.
- Do not modify, commit or push anything during a review unless the user asked for fixes.
- If the change is very large (roughly more than 400 changed lines or many unrelated files), say so, recommend splitting it, and review it file by file.
- Fresh eyes: if the code was written earlier in this same conversation, re-read it as a stranger would, and say that an independent review in a new conversation is stronger.

## Phase 1. Understand the intent (the Spec)
- Find what the code is supposed to do, in this order: the user's own request, the issue or pull request text, AGENTS.md or project docs, a docstring or comment, test names, then the code itself.
- State the intent in one or two lines. If you had to guess it, write "Assumed intent:" and mark every Spec finding as lower confidence.
- Spec questions: Does the code do everything that was asked? Does it do anything that was not asked (extra behaviour, scope creep, unrelated edits)? Are the stated edge cases handled? Does the behaviour match the examples given?

## Phase 2. Correctness (trace it, then test it)
- Trace the code by hand with one small concrete input, line by line, writing the value of each variable. Pay attention to evaluation order and operator precedence. Where possible, confirm the trace by running a small snippet or test.
- Then check a second input that is an edge case: empty, zero, one element, negative, very large, wrong type, None or null, whitespace, strings that look valid but are not, duplicates, unsorted data.
- Check loop bounds (off by one), integer overflow and division, floating point comparison, and unit or timezone mix-ups.
- Check error handling: swallowed exceptions, bare except, errors returned but not checked, resources not released on the error path, partial failure leaving inconsistent state.
- Check concurrency when threads, async code or shared state appear: races, missing locks, blocking calls inside async code, shared mutable state.
- Language traps:
  - Python: mutable default arguments are created once and shared; lambdas or closures in a loop look up the variable when called (late binding); is versus ==; modifying a list while iterating it; regex fullmatch versus match; integer versus true division; a generator can be consumed only once; missing await.
  - C++: push_back or insert can reallocate a vector and invalidate iterators, pointers and references; dangling reference to a temporary; use after move; object slicing; missing virtual destructor; uninitialized variables; signed and unsigned comparison; rule of three or five; raw new without a matching delete or smart pointer.
  - C#: LINQ is lazy, so it runs at enumeration time and may run more than once; modifying a collection during foreach; async void; missing await; IDisposable without using; string comparison culture; null reference with nullable types; captured loop variables.
  - JavaScript or TypeScript: == versus ===; this binding; async functions without await; floating point; mutating shared objects; array sort without a comparator sorts as strings.
  - SQL or shell if present: injection through string building, unquoted variables, missing WHERE on update or delete.
- For new code, also check: type hints or types present, a docstring or comment saying why, and validation at the input boundary.

## Phase 3. Security
Check input that comes from outside: injection (SQL, shell, template), path traversal, unsafe deserialization, hard-coded secrets or keys, missing authorization checks, logging of sensitive data, unsafe randomness for secrets, unbounded input size. Never print the values of secrets or tokens found in the environment or in files.

## Phase 4. Standards (the codebase rules)
- If the repository has conventions (AGENTS.md, a style guide, linter config, contributing notes), those are the standard. Cite the rule by its wording for every Standards finding.
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
2. Commands run and their results (tests, linters), or "not run" with the reason.
3. Spec findings.
4. Correctness findings.
5. Security findings.
6. Standards findings.
7. Counts per severity, and the questions you could not answer because code or context was missing.

Every finding must have: severity, location (file and function, line or quoted snippet), what is wrong, the evidence (the trace, the failing test, the rule or the input that breaks it), and the smallest fix as a short code block. Add a confidence of high, medium or low. A finding without evidence must be dropped or marked low confidence.

## Rules
- Do not invent APIs, functions, library behaviour or line numbers. If unsure whether a library behaves a certain way, say you are unsure or check it in the installed package source.
- Do not rewrite the whole program. Give the minimal fix for each finding.
- Do not pad the review. If a phase has no findings, write "none found" for that phase.
- The human decides. Do not approve or reject; give the findings and the counts.
