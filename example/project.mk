SOURCE_DIR := $(dir $(MAKEFILE_LIST))

include $(SOURCE_DIR)mk/utils.mk
include $(SOURCE_DIR)mk/gcc.mk

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

$(call vpath-add-list,$(VPATH_SUFFIXES),$(SOURCE_DIR))

################################################################################
# Rules
################################################################################

$(.DEFAULT_GOAL): example

$(call add-subdir,src)
$(call add-subdir,lib)

example: $(src/TARGETS) $(lib/TARGETS)
	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@

-include $(DEPENDS)
