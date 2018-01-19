#!/bin/bash
if [ "$SHED_BUILDMODE" == 'bootstrap' ]; then
    # Remove temporary symlinks created earlier in the bootstrap
    for UTILLIB in blkid mount uuid
    do
        rm -v /usr/lib/lib${UTILLIB}.so*
    done
    rm -vf /usr/include/{blkid,libmount,uuid}
fi
