#!/bin/bash

HTML_FILE="index.html"

# Extract tasks and test data and store it into local variables
TODO_TASKS=$(grep -A 10000 "ToDo Tasks:" "$1" | sed '1d; /Done Tasks:/,$d')
DONE_TASKS=$(awk '/Done Tasks:/{flag=1; next} flag && NF {print}' "$1")
UNIT_TEST_RESULTS=$(cat "$2")

# function to update the pre-tag with section data
update_pre() {
    perl -i -0777 -pe 's{<pre id="'"$1"'">.*?</pre>}{<pre id="'"$1"'">\n'"$2"'\n</pre>}gs' "$3"
}

update_pre "pending" "$TODO_TASKS" "$HTML_FILE"
update_pre "completed" "$DONE_TASKS" "$HTML_FILE"
update_pre "unittest" "$UNIT_TEST_RESULTS" "$HTML_FILE"