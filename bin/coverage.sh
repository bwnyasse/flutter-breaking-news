#!/usr/bin/env bash
#
# Script used to run test & code coverage in local or ci
#

set -e

CURRENT_DIR=$(pwd)

[[ ! -f "$CURRENT_DIR/pubspec.yaml" ]] && echo 'the script must be run into flutter root directory' && exit 1


################
## FLAG VAR  ##
###############
FLAGS="idh"

#Flag for ci
FLAG_CI=false

#Flag for dev env
FLAG_DEV=false


##############################
## FUNCTIONS DECLARATION  ###
#############################

usage() {
	cat <<-EOF
    Script used to perform coverage operation
	OPTIONS:
	========
      -i	  launch in ci env
      -d	  launch in dev env
      -h	  show this help
	EOF
}

launch_test(){
    # Effective test coverage
    # Why --no-test-assets : https://github.com/flutter/flutter/issues/35907
    flutter test --coverage --no-test-assets

    # Install https://pub.dev/packages/remove_from_coverage
    pub global activate remove_from_coverage

    export PATH="$PATH":"$HOME/.pub-cache/bin"

    # Remove Generate dart files
    remove_from_coverage -f coverage/lcov.info -r '.g.dart$'

    # Remove unused files
    remove_from_coverage -f coverage/lcov.info -r 'device_utils.dart$'
    remove_from_coverage -f coverage/lcov.info -r 'hack_flutter_settings.dart$'

    # Remove files cover by flutter drive test
    remove_from_coverage -f coverage/lcov.info -r 'drawer_ctl.dart$'
    remove_from_coverage -f coverage/lcov.info -r 'home_screen.dart$'
    remove_from_coverage -f coverage/lcov.info -r 'news_latest.dart$'
    remove_from_coverage -f coverage/lcov.info -r 'news_category.dart$'
    remove_from_coverage -f coverage/lcov.info -r 'settings_details.dart$'

}

code_coverage(){

    # Generate coverage info
    genhtml -o coverage coverage/lcov.info

    # Open to see coverage info
    open coverage/index.html

}



#############################
### Effectif Script build ###
############################


while getopts $FLAGS OPT;
do
    case $OPT in
        i)
            FLAG_CI=true
            ;;
        d)
            FLAG_DEV=true
            ;;
        *|h)
            usage
            exit 1
            ;;
    esac
done


if $FLAG_CI; then
    launch_test
fi

if $FLAG_DEV; then
    launch_test
    code_coverage
fi

