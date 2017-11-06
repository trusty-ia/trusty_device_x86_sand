# compiled from source
TRUSTY_ALL_USER_TASKS += \
        sample/skel \
        sample/skel2

GLOBAL_DEFINES += PRINT_USE_MMIO=1
GLOBAL_DEFINES += APP_STORAGE_RPMB_BLOCK_COUNT=8192
