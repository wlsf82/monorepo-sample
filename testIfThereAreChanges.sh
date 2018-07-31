#!/bin/bash -e
testIfThereAreChanges() {
  echo "detecting changes for this build"
  directory=`git diff --name-only origin/master $1 | sort -u | awk 'BEGIN {FS="/"} {print $1}' | uniq`
  export changed_components=$directory
}

run_tests() {
  for component in $changed_components
  do
    echo "--------------------------------------------------------------------"
    echo "$component has changed"
    echo "------------------- Running tests for $component ---------------------"
    cd "$component"
    npm i
    npm t
  done
}

testIfThereAreChanges $1
run_tests
