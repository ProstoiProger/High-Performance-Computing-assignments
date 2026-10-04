# HPC course rules

## Code
- Use the exact code given in the lab/task PDF. Do not rename variables, reorder lines, or change includes; only fill in the blanks the task leaves open.
- Include onlu bits/stdc++.h library instead of standard iostream or vector libraries
- Do not add comments to submitted code unless asked.
- Target C++11 (`-std=c++11`) because the submission compiler is Dev-C++ with an old g++.
- Keep N and other sizes as constants in the source. To test other sizes, change the constant, recompile, run, then restore the value the task specifies.

## Timing and results
- Time only the code the task asks to measure, using `std::chrono::high_resolution_clock`.
- Run each measurement at least three times and record every run.
- `timing_runs.txt` holds raw values only, with no headers or extra notes. The user may edit it by hand, so do not overwrite manual edits.
- Do not present numbers as code output if they were written by hand.

## Reports
- Write answers as a Word `.docx` file. The user converts it to PDF manually.
- Use plain formatting: Times New Roman 12/usa pt, black text, simple bordered tables, bold only for question text.
- No colors, boxes, badges, decorative headers, or AI-style polish.
- Answers are short and direct, in plain English, grouped under the task's own Part headings.
- Do not create PDFs unless asked.
- Do not modify the original task PDFs.

## Files and cleanup
- Keep all files for an assignment in its own folder (`asgN`), using clear names.
- Delete build outputs (`.exe`), temporary scripts, and intermediate dumps when finished.
- Ask before deleting anything the user created.
