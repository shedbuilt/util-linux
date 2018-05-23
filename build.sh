#!/bin/bash
declare -A SHED_PKG_LOCAL_OPTIONS=${SHED_PKG_OPTIONS_ASSOC}
SHED_PKG_LOCAL_PREFIX='/usr'
if [ -n "${SHED_PKG_LOCAL_OPTIONS[toolchain]}" ]; then
    SHED_PKG_LOCAL_PREFIX='/tools'
fi
SHED_PKG_LOCAL_DOCDIR=${SHED_PKG_LOCAL_PREFIX}/share/doc/${SHED_PKG_NAME}-${SHED_PKG_VERSION}
# Configure
if [ -n "${SHED_PKG_LOCAL_OPTIONS[toolchain]}" ]; then
    ./configure --prefix=${SHED_PKG_LOCAL_PREFIX} \
                --docdir=${SHED_PKG_LOCAL_DOCDIR} \
                --without-python                  \
                --disable-makeinstall-chown       \
                --without-systemdsystemunitdir    \
                --without-ncurses                 \
                PKG_CONFIG="" || exit 1
else
    # For FHS compliance, use /var/lib/hwclock for adjtime
    mkdir -pv "${SHED_FAKE_ROOT}/var/lib/hwclock" &&
    ./configure ADJTIME_PATH=/var/lib/hwclock/adjtime \
        --prefix=${SHED_PKG_LOCAL_PREFIX} \
        --docdir=${SHED_PKG_LOCAL_DOCDIR} \
        --disable-chfn-chsh \
        --disable-login \
        --disable-nologin \
        --disable-su \
        --disable-setpriv \
        --disable-runuser \
        --disable-pylibmount \
        --disable-static \
        --without-python || exit 1
fi

# Build and Install
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install || exit 1

# Prune Documentation
if [ -z "${SHED_PKG_LOCAL_OPTIONS[docs]}" ]; then
    rm -rf "${SHED_FAKE_ROOT}${SHED_PKG_LOCAL_DOCDIR}"
fi
