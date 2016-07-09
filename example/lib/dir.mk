objects += lib.o
targets += liblib.a

$(output_dir)liblib.a: $$($(output_dir)OBJECTS)
	$(AR) $(ARFLAGS) $@ $^
