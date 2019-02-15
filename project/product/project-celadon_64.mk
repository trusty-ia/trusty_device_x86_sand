# compiled from source
TRUSTY_ALL_USER_TASKS += \
        sand/hwcrypto \
        keymaster \
        gatekeeper \
        storage

# TAs for debug build
ifeq ($(LKDEBUG), 2)
TRUSTY_ALL_USER_TASKS += \
        sand/benchmark \
        sample/hwcrypto-unittest \
        sample/storage-unittest \
        sample/ipc-unittest/main \
        sample/ipc-unittest/srv

endif

TRUSTY_ALL_USER_TASKS += \
        sand/benchmark \
        sample/hwcrypto-unittest \
        sample/storage-unittest \
        sample/ipc-unittest/main \
        sample/ipc-unittest/srv

GLOBAL_DEFINES += PRINT_USE_MMIO=0
GLOBAL_DEFINES += APP_STORAGE_RPMB_BLOCK_COUNT=8192
GLOBAL_DEFINES += APP_STORAGE_RPMB_OFFSET=512
