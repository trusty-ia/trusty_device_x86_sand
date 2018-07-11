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

# LK_DEBUGLEVEL=$(DEBUG), set DEBUG level as 1 to reduce logs
# default DEBUG level is 2
DEBUG = 1

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

WITH_CUSTOMIZED_BOOTSTRAP := true
# 1 page reserved for platform data, please consult hypervisor for more info
KERNEL_LOAD_OFFSET=0x1000

CLANGBUILD := false

# Overwrite toolchain prefix, plan to remove this marco in mixin of P dessert
ARCH_x86_64_TOOLCHAIN_PREFIX :=

EXTRA_BUILDRULES += app/trusty/user-tasks.mk

ALL_PRODUCTS = $(shell ls $(LOCAL_DIR)/product/)
PRODUCTS = $(foreach t,$(ALL_PRODUCTS),$(basename $(t)))

define PRINT_AVAILABLE_PRODUCTS
    $(info )
    $(info CAUTION!!!)
    $(info Available products: $(PRODUCTS))
    $(error Please use 'export TRUSTY_REF_TARGET=xxx' to specify product name)
    $(info )
    $(info )
endef

ifeq ($(TRUSTY_REF_TARGET),)
    $(PRINT_AVAILABLE_PRODUCTS)
else
ifeq ($(findstring $(TRUSTY_REF_TARGET),$(PRODUCTS)),)
    $(info product $(TRUSTY_REF_TARGET) not support)
    $(PRINT_AVAILABLE_PRODUCTS)
endif
endif

include  $(LOCAL_DIR)/product/$(TRUSTY_REF_TARGET).mk
