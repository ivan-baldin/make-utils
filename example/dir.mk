$(call subdir-add-all)

targets += example

example: $(eval CPPFLAGS += -I$(source_dir)lib)

example: $$(src/OBJECTS) $$(lib/TARGETS)
	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@
