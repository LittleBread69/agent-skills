---
name: frontend-design
description: "Use when building a web page, UI, landing page or HTML/CSS/JS component: clean layout, real design choices, working code in one file."
---

# Frontend Design

Step 1. Decide what the page is for and who uses it, in one sentence. Pick one clear visual direction (for example calm and minimal, bold and playful, or technical and dense) and stay consistent with it.

Step 2. Deliver one self-contained HTML file with inline CSS and JavaScript unless the user asks for a framework. It must run when opened in a browser, with no build step and no missing files.

Step 3. Define colors, spacing and font sizes once as CSS variables at the top. Use a small palette: one background, one text color, one accent. Make sure text has enough contrast.

Step 4. Layout: use flexbox or grid, a readable maximum width for text, generous spacing, and a clear hierarchy of headings. Make it work on a phone (narrow screen) and on a desktop. Avoid horizontal scrolling.

Step 5. Typography: use a system font stack by default. Limit yourself to two font sizes for body text and a few for headings.

Step 6. Avoid generic template looks: no default purple gradients, no stock hero text, no empty placeholder sections. Use real, sensible content for the topic.

Step 7. Interactive parts (buttons, forms, tabs) must really work, give feedback on hover and focus, and be reachable with the keyboard. Use semantic tags (header, main, nav, button, label).

Step 8. Before answering, re-read the code for unclosed tags, wrong quotes and undefined variables. Then give the full file in one code block and say in two sentences what it does.
