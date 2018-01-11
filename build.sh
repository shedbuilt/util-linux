#!/bin/bash
# For FHS compliance, use /var/lib/hwclock for adjtime
mkdir -pv "${SHED_FAKEROOT}/var/lib/hwclock"
./configure ADJTIME_PATH=/var/lib/hwclock/adjtime \
            --docdir=/usr/share/doc/util-linux-2.31.1 \
            --disable-chfn-chsh \
            --disable-login \
            --disable-nologin \
            --disable-su \
            --disable-setpriv \
            --disable-runuser \
            --disable-pylibmount \
            --disable-static \
            --without-python || return 1
make -j $SHED_NUMJOBS || return 1
make DESTDIR="$SHED_FAKEROOT" install || return 1
