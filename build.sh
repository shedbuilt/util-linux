#!/bin/bash
case "$SHED_BUILD_MODE" in
    toolchain)
        ./configure --prefix=/tools                \
                    --without-python               \
                    --disable-makeinstall-chown    \
                    --without-systemdsystemunitdir \
                    --without-ncurses              \
                    PKG_CONFIG="" || exit 1
        ;;
    *)
        # For FHS compliance, use /var/lib/hwclock for adjtime
        mkdir -pv "${SHED_FAKE_ROOT}/var/lib/hwclock"
        ./configure ADJTIME_PATH=/var/lib/hwclock/adjtime \
                --docdir=/usr/share/doc/util-linux-2.32 \
                --disable-chfn-chsh \
                --disable-login \
                --disable-nologin \
                --disable-su \
                --disable-setpriv \
                --disable-runuser \
                --disable-pylibmount \
                --disable-static \
                --without-python || exit 1
        ;;
esac
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install
