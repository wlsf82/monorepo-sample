#!/bin/bash -e
export IGNORE_FILES_AND_DOT_SEMAPHORE_DIRECTORY=$(ls -p | grep -v /):.semaphore

detect_changed_folders() {
  echo "detecting changes for this build"
  folders=`git diff --name-only origin/master | sort -u | awk 'BEGIN {FS="/"} {print $1}' | uniq`
  export changed_components=$folders
}

run_tests() {
  for component in $changed_components
  do
    echo "--------------------------------------------------------------------"
    echo "$component has changed"
    if ! [[ " ${IGNORE_FILES_AND_DOT_SEMAPHORE_DIRECTORY[@]} " =~ "$component" ]]; then
      echo "------------------- Running tests for $component ---------------------"
      cd "$component"
      ../runTests.sh "$component"
      cd ..
    else
      echo "Ignoring this change"
    fi
  done
}

detect_changed_folders
run_tests
