include $(NITROS9DIR)/rules.mak

OBJS = main90.o board90.o caged90.o check90.o ghosts90.o movpac90.o \
       score90.o scrns90.o setup90.o

pacos9: $(OBJS)
	$(LINKER) $^ -opacos9 -L$(NITROS9DIR)/lib -lnos96809l2

clean:
	$(RM) $(OBJS) pacos9

info:
