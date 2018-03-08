# top level project rules for the sand-x86-64 project
#
LOCAL_DIR := $(GET_LOCAL_DIR)

# Default SMP_MAX_CPUS of *sand is 4 processors.
# If WITH_SMP flag enabled in rule.mk, SMP_MAX_CPUS
# to 4, if not, equals to 1
SMP_MAX_CPUS ?= 4
ARCH := x86
SUBARCH := x86-64
TARGET := sand

WITH_LINKER_GC := 1

MODULES += \
	lib/trusty \
	lib/sm \
	lib/memlog \

# SUBARCH will be set as final user application architecture
TRUSTY_USER_ARCH := x86

# do not relocate kernel in physical memory
GLOBAL_DEFINES += WITH_NO_PHYS_RELOCATION=1

# limit heap grows
GLOBAL_DEFINES += HEAP_GROW_SIZE=65536

#Disable trace application info, since it might leads LK crash till now
#GLOBAL_DEFINES += DEBUG_LOAD_TRUSTY_APP=1

# prebuilt
TRUSTY_PREBUILT_USER_TASKS :=

# compiled from source
TRUSTY_ALL_USER_TASKS :=

WITH_TRUSTY_IPC := true

STACK_PROTECTOR ?= true
ASLR_OF_TA ?= true

EPT_DEBUG ?= false
ifeq (true,$(call TOBOOL,$(EPT_DEBUG)))
GLOBAL_DEFINES += \
	EPT_DEBUG=1
endif

ENABLE_STATIC_LIB ?= true

WITH_CUSTOMIZED_SYSCALL ?= true

EXTRA_BUILDRULES += app/trusty/user-tasks.mk

include  $(LOCAL_DIR)/product/$(TARGET_PRODUCT).mk
