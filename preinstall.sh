#!/bin/bash
declare -A SHED_PKG_LOCAL_OPTIONS=${SHED_PKG_OPTIONS_ASSOC}
if [ -n "${SHED_PKG_LOCAL_OPTIONS[bootstrap]}" ]; then
    # Remove temporary symlinks created earlier in the bootstrap
    rm -vf /usr/include/{blkid,libmount,uuid}
fi
