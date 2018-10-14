#!/bin/bash
declare -A SHED_PKG_LOCAL_OPTIONS=${SHED_PKG_OPTIONS_ASSOC}
# Configure
if [ -n "${SHED_PKG_LOCAL_OPTIONS[toolchain]}" ]; then
    SHED_PKG_DOCS_INSTALL_DIR="/tools/share/doc/${SHED_PKG_NAME}-${SHED_PKG_VERSION}"
    ./configure --prefix=/tools \
                --docdir="$SHED_PKG_DOCS_INSTALL_DIR" \
                --without-python                  \
                --disable-makeinstall-chown       \
                --without-systemdsystemunitdir    \
                --without-ncurses                 \
                PKG_CONFIG="" || exit 1
else
    # For FHS compliance, use /var/lib/hwclock for adjtime
    mkdir -pv "${SHED_FAKE_ROOT}/var/lib/hwclock" &&
    ./configure ADJTIME_PATH=/var/lib/hwclock/adjtime \
        --docdir="$SHED_PKG_DOCS_INSTALL_DIR" \
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
    rm -rf "${SHED_FAKE_ROOT}${SHED_PKG_DOCS_INSTALL_DIR}"
fi
