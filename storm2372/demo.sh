#!/usr/bin/env bash

CWD=$(pwd)
MYDIR=$(dirname $0)
case "$MYDIR" in
/*)
    ;;
*)
    MYDIR=$CWD/$MYDIR
    ;;
esac

PS1="attacker-host:~ $ "

wait_enter()
{
    read x
}

wait_clear()
{
    read x
    clear
}

#-----------------------------------------------
# Scenario 1: Microsoft
#-----------------------------------------------
scenario_1()
{
    echo -n "$PS1"
    wait_clear
    echo "pwsh demo.ps1 -config demo.json"
    pwsh demo.ps1 -config demo.json
}

usage()
{
    if [[ -n "$@" ]]; then
        echo
        echo "$@"
    fi

    cat <<EOF

    usage: demo.sh 1

    1       Run Scenario 1: Microsoft. Default.

EOF
    exit 1
}

#--------
# Main
#--------

if [[ $1 = "-h" ]]; then
    usage 
fi

clear

while [[ "$@" ]]; do
    arg=$1
    shift
    case "$arg" in
    1)
        scenario_1
        ;;
    *)
        usage "Error: invalid scenario #: $arg"
        ;;
    esac
done

#--------
# End
#--------

wait_enter
