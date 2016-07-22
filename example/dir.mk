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

################################################################################
# Rules
################################################################################

$(call subdir-add,src)
$(call subdir-add,lib)

targets += example liblib.a

liblib.a: liblib.a($(lib/OBJECTS))

example: LDLIBS += liblib.a
example: $(src/OBJECTS) | liblib.a
	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@

-include $(ALL_OBJECTS:.o=.d)
