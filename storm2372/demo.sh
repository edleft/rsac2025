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

[[ -f ~/lib/demo-magic.sh ]] && . ~/lib/demo-magic.sh
[[ -f ./demo-magic.sh ]] && . ./demo-magic.sh
NO_WAIT=true

TYPE_SPEED=200
# DEMO_PROMPT="victim-host:${CYAN}\W $ "
DEMO_PROMPT="attacker-host:${CYAN}~ $ "

wait_enter()
{
    NO_WAIT=false
    p ""
    NO_WAIT=true
}

wait_clear()
{
    NO_WAIT=false
    pe "clear"
    NO_WAIT=true
}

#-----------------------------------------------
# Scenario 1: Microsoft
#-----------------------------------------------
scenario_1()
{
    wait_clear
    # p "python phishme.py -config demo.json"
    p "pwsh demo.ps1 -config demo.json"
    pwsh demo.ps1 -config demo.json
}

#----------------------------------------
# Scenario 2: Google
#----------------------------------------
scenario_2()
{
    wait_clear
    pwsh demo.ps1 -config doit_gcp.json
}

usage()
{
    if [[ -n "$@" ]]; then
        echo
        echo "$@"
    fi

    cat <<EOF

    usage: demo.sh ( 1 | 2 )

    1       Run Scenario 1: Microsoft

    2       Run Scenario 2: Google


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
    ""|1)
        scenario_1
        ;;
    2)
        scenario_2
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
