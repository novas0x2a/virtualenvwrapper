#!/bin/sh

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    mkdir -p "$WORKON_HOME/hooks"
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
}

setUp () {
    echo
    rm -f "$test_dir/catch_output"
    rm -f "$WORKON_HOME/hooks/*"
}

test_virtualenvwrapper_initialize() {
    export VIRTUALENVWRAPPER_HOOK_DIR="$WORKON_HOME/hooks"
    source "$test_dir/../virtualenvwrapper.sh"
    for hook in premkvirtualenv postmkvirtualenv prermvirtualenv postrmvirtualenv preactivate postactivate predeactivate postdeactivate
    do
        assertTrue "Global $hook was not created" "[ -f $WORKON_HOME/hooks/$hook ]"
        assertTrue "Global $hook is not executable" "[ -x $WORKON_HOME/hooks/$hook ]"
    done
}

. "$test_dir/shunit2"
