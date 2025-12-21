#!/usr/bin/env python3
"""
Script to extract filenames from a _info file.
- Reads lines starting with 'F'
- Extracts the filename after 'F ', removes the suffix (extension)
- Stores in a list and prints each filename on a new line
"""

import sys
import os

def main():
    if len(sys.argv) != 2:
        print("Usage: python extract_files.py <path_to__info>")
        sys.exit(1)

    info_path = sys.argv[1]
    info_path = os.path.abspath(info_path)

    if not os.path.isfile(info_path):
        print(f"Error: File '{info_path}' not found.")
        sys.exit(1)

    files = []

    try:
        with open(info_path, 'r') as f:
            for line in f:
                line = line.strip()
                if line.startswith('F'):
                    # Extract filename after 'F'
                    filename = line[1:].strip()
                    if filename:
                        # Remove suffix (extension)
                        name_without_ext = os.path.splitext(os.path.basename(filename))[0]
                        files.append(name_without_ext)
    except Exception as e:
        print(f"Error reading file: {e}")
        sys.exit(1)

    # Display the array one line at a time
    for file in files:
        print(file)

if __name__ == "__main__":
    main()