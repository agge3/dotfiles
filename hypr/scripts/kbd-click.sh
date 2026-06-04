#!/usr/bin/env bash

usage() {
	echo "Usage: $(basename "$0"): " 2>&1
}

if [[ $# -lt 0 || -z "xxx" ]]; then
	usage
	exit 1
fi


