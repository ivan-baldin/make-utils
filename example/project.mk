SOURCE_DIR := $(dir $(MAKEFILE_LIST))

include $(SOURCE_DIR)mk/utils.mk
include $(SOURCE_DIR)mk/gcc.mk

# Set source directory for project sources
SOURCE_SUFFIXES := $(C_SUFFIXES) $(CXX_SUFFIXES) $(ASM_SUFFIXES)
$(call vpath-add,$(SOURCE_SUFFIXES),$(SOURCE_DIR))

################################################################################
# Flags
################################################################################

# Preprocessor Flags
CPPFLAGS += -Wall -Wextra -Wpedantic

# C Flags
CFLAGS += -std=c11
CFLAGS += -MMD

# C++ Flags
CXXFLAGS += -std=c++11
CXXFLAGS += -MMD

# Archive Flags
ARFLAGS := rcsU

################################################################################
# Rules
################################################################################

$(.DEFAULT_GOAL): example

$(call add-subdir,src)
$(call add-subdir,lib)

example: $(src/TARGETS) $(lib/TARGETS)
	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@

-include $(DEPENDS)
