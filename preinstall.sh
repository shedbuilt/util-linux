#!/bin/bash
declare -A SHED_PKG_LOCAL_OPTIONS=${SHED_PKG_OPTIONS_ASSOC}
if [ -n "${SHED_PKG_LOCAL_OPTIONS[bootstrap]}" ]; then
    # Remove temporary symlinks created earlier in the bootstrap
    for SHED_PKG_LOCAL_UTILLIB in blkid mount uuid
    do
        rm -v /usr/lib/lib${SHED_PKG_LOCAL_UTILLIB}.so*
    done
    rm -vf /usr/include/{blkid,libmount,uuid}
fi
