#!/usr/bin/env sh
# This script is needed to allow lf to use bat as a pager via $PAGER.

bat --pager="less" "$@"
