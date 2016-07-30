targets := libfoo.a
objects := foo.o

$(eval CPPFLAGS += -I$(source_dir))

$(@/TARGETS): $(@/TARGETS)($(@/OBJECTS))

$(@/TARGETS)($(@/OBJECTS)): $(@/OBJECTS)
