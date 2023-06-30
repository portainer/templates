#!/bin/bash

if [ -n "$1" ]; then
    template_version="-$1"
else
    template_version=""
fi

metadata_directory="./containers ./stacks"
output_file="./templates${template_version}.json"
metadata_list=()

for dir in $metadata_directory; do
    # Iterate over each directory and file
    while IFS= read -r -d '' file; do
        if [[ $file == */metadata${template_version}.json ]]; then
            metadata=$(cat "$file")
            metadata_list+=("$metadata")
        fi
    done < <(find "$dir" -type f -name "metadata${template_version}.json" -print0)
done

# Combine metadata list into a single JSON array
metadata_json=$(printf '%s\n' "${metadata_list[@]}" | jq -s '.')

# Create the final JSON string with the desired format
if [ "$1" == "2.0" ]; then
    final_json=$(printf '{"version": "2","templates": %s}\n' "$metadata_json")
else
    final_json=$metadata_json
fi


# Write the combined metadata to the templates.json file
echo "$final_json" > "$output_file"
