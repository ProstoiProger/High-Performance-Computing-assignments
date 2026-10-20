import sys

current_word = None
current_docs = []

for line in sys.stdin:

    line = line.strip()

    word, doc_id = line.split("\t")

    if word == current_word:

        if doc_id not in current_docs:
            current_docs.append(doc_id)

    else:

        if current_word is not None:
            print(f"{current_word}\t{','.join(current_docs)}")

        current_word = word
        current_docs = [doc_id]

if current_word is not None:
    print(f"{current_word}\t{','.join(current_docs)}")
