#!/bin/bash

# for each md file in the directory
for file in *.md
  do
    # convert each file to html and place it in the html directory
    # --gfm == use github flavoured markdown
    marked -o pages/$file.html $file --gfm
done
