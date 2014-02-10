include $(NITROS9DIR)/rules.mak

TARGET = pacos9
OBJS = main90.o board90.o caged90.o check90.o ghosts90.o movpac90.o \
       score90.o scrns90.o setup90.o
LFLAGS += -L$(NITROS9DIR)/lib -lnos96809l2

DSK = $(TARGET).dsk

$(TARGET): $(OBJS)
	$(LINKER) $(LFLAGS) $^ -o$@

dsk: $(DSK)

$(DSK): $(TARGET)
	$(OS9FORMAT) -q $(DSK) -n"Larry Olson's Pacos9"
	$(MAKDIR) $(DSK),CMDS
	$(OS9COPY) $(TARGET) $(DSK),CMDS
	$(OS9ATTR) -e $(DSK),CMDS/$(TARGET)

dskcopy: $(DSK)
	$(CP) $^ $(DSKDIR)

dskclean:
	$(RM) $(DSK)

clean: dskclean
	$(RM) $(OBJS) $(TARGET)

info:
	@echo "*** Larry Olson's Pacos9 game ***"
	@echo $(DSK)
