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
        sample/ipc-unittest/main \
        sample/ipc-unittest/srv

GLOBAL_DEFINES += PRINT_USE_MMIO=0
GLOBAL_DEFINES += PRINT_USE_IO_PORT=1
GLOBAL_DEFINES += TARGET_SERIAL_IO_BASE=0x3f8
GLOBAL_DEFINES += APP_STORAGE_RPMB_BLOCK_COUNT=8192
GLOBAL_DEFINES += APP_STORAGE_RPMB_OFFSET=512
GLOBAL_DEFINES += RETRIEVE_ATTKB_FROM_RAW_RPMB
GLOBAL_DEFINES += RPMB_BLOCK_INFO_INDEX=10
