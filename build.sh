#!/bin/bash
mkdir -pv ${SHED_FAKEROOT}/var/lib/hwclock
./configure ADJTIME_PATH=/var/lib/hwclock/adjtime \
            --docdir=/usr/share/doc/util-linux-2.30.1 \
            --disable-chfn-chsh \
            --disable-login \
            --disable-nologin \
            --disable-su \
            --disable-setpriv \
            --disable-runuser \
            --disable-pylibmount \
            --disable-static \
            --without-python
make -j $SHED_NUMJOBS
make DESTDIR=${SHED_FAKEROOT} install
