#!/bin/bash
#set -eEuxo pipefail
set -eEuo pipefail

#
# utility functions
#

function now_datetime() {
    echo $(date +'%Y-%m-%d %H:%M:%S')
}

function now_date() {
    echo $(date +'%Y%m%d')
}

function log_info() {
    echo "$(now_datetime) - INFO - ${1}"
}

function log_error() {
    echo "$(now_datetime) - ERROR - ${1}" 1>&2
}

#
# application functions
#

function usage() {
    echo 'NAME'
    echo '        BATCH -- bash batch skelton'
    echo 'SYNOPSIS'
    echo '        bash.sh [-abhv]'
    echo 'DESCRIPTION'
    echo '        -a | --aaa        Sample parameter'
    echo '        -b | --bbb        Sample parameter'
    echo '        -h | --help       Show this help message'
    echo '        -v | --verbose    Run script in verbose mode'
    exit 1
}

function sig_handler() {
    log_error "caught sig: line.$(caller)"
}

function error_handler() {
    log_error "failed: line.$(caller)"
}

function do_x() {
    log_info "do_x: ${1}"
}

function do_y() {
    log_info "do_y: ${1}"
}

#
# main
#

# set trap
trap 'sig_handler' SIGINT SIGTERM
trap 'error_handler' ERR

# default parameters
VERBOSE='false'
PARAM_A='aaa'
PARAM_B='bbb'

# parse args
set +u
while [ "x${1}" != 'x' ]
do
    case $1 in
        -h | --help)
            usage
            ;;
        -v | -verbose)
            VERBOSE='true'
            shift
            ;;
        -a | --aaa)
            shift
            PARAM_A=$1
            shift
            ;;
        -b | --bbb)
            shift
            PARAM_B=$1
            shift
            ;;
        *)
            log_error "undefined parameter: ${1}"
            usage
            ;;
    esac
done
set -u

# execute process
log_info 'start'
do_x $PARAM_A
do_y $PARAM_B
log_info 'success'
