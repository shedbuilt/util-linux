#!/bin/bash
if [ "$SHED_BUILD_MODE" == 'bootstrap' ]; then
    # Remove temporary symlinks created earlier in the bootstrap
    for SHDPKG_UTILLIB in blkid mount uuid
    do
        rm -v /usr/lib/lib${SHDPKG_UTILLIB}.so*
    done
    rm -vf /usr/include/{blkid,libmount,uuid}
fi
