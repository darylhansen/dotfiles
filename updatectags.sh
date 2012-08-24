#!/usr/bin/env bash

tags_file="${HOME}/.tags"

base_dir="${HOME}/git"

# Remove the old tags file if it exists.
if [ -f $tags_file ]; then
  echo "Deleting old tags file $tags_file"
  rm $tags_file
fi

# Generate the tags file using exuberant-ctags
echo "Creating new tags file $tags_file from sources in $base_dir"
find "$base_dir" -name *.java | xargs ctags -a -R -f $tags_file
find "$base_dir" -name *.scala | xargs ctags -a -R -f $tags_file
