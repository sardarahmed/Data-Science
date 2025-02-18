#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys

# Read each line from stdin (each line is a language and word)
for line in sys.stdin:
    line = line.strip()
    parts = line.split()

    if len(parts) == 2:
        language, word = parts

        # Emit key-value pair (word, language)
        if language in ['français', 'english']:
            print(f"{word}\t{language}")
