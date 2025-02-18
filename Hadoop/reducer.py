#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys

current_word = None
languages = set()

for line in sys.stdin:
    line = line.strip()
    word, language = line.split("\t")

    if word == current_word:
        # Add language to the set for the word
        languages.add(language)
    else:
        if current_word and len(languages) == 2:
            # If both 'français' and 'english' appear for the current word
            print(f"{current_word}\t0")
        
        # Update current word and reset languages set
        current_word = word
        languages = {language}

# Don't forget to output the last word if it has both languages
if current_word and len(languages) == 2:
    print(f"{current_word}\t0")
