---
name: data-analysis
description: "Use when analyzing a table, CSV, spreadsheet or numbers: inspect the data, compute with code, check results, report plainly."
---

# Data Analysis

Step 1. State the question being answered in one sentence. If the data or the question is unclear, ask what is missing before computing anything.

Step 2. Look at the data first: column names and types, number of rows, missing values, duplicates, and obviously wrong values such as negative ages or dates in the future. Report problems you find before analysing.

Step 3. Do the calculations with code (Python with pandas if available), not in your head. Never estimate sums, averages, percentages or counts by eye. If no code tool is available, work step by step and show every intermediate number.

Step 4. Keep the original data unchanged. Write cleaning steps as separate, visible steps and say how many rows each step changed.

Step 5. Sanity-check results: do parts add up to the total, are percentages between 0 and 100, does the result have a plausible size, does a second way of computing it give the same number?

Step 6. Be careful with conclusions. A correlation is not a cause. Small samples, outliers and missing data limit what you can say, so say how much you trust each result.

Step 7. Report: first the direct answer with the key numbers, then a short table or chart if it helps, then the method in two or three lines and the caveats. Round sensibly and keep units.

Step 8. If the user wants a file, produce a CSV or a clearly formatted table that can be pasted into a spreadsheet, and list the formulas used.
