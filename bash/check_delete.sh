git checkout $@ --quiet

files=$(git diff --name-status master HEAD | grep -E "^(A|M)" | cut -f 2)
 
grep -H -n "delete_survey([^,)]\+)" $files
