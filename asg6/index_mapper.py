import sys
import re

for line in sys.stdin:

    line = line.strip()

    if not line:
        continue

    parts = line.split(maxsplit=1)
    doc_id = parts[0]
    text = parts[1].lower() if len(parts) > 1 else ""

    words = re.findall(r"[a-z0-9’]+", text)

    for word in words:

        print(f"{word}\t{doc_id}")
