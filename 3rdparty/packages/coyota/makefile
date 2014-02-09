include $(NITROS9DIR)/rules.mak

TARGET	= coyota
OBJS	= coyota.o instrument.o dashboard.o bin_dec32.o
LFLAGS	+= -lalib -lnos96809l2 -L$(NOSLIB)
DSK	= $(TARGET).dsk

$(TARGET): $(OBJS)

dsk: $(TARGET)
	$(OS9FORMAT) -q $(DSK)
	$(MAKDIR) $(DSK),CMDS
	$(OS9COPY) $(TARGET) $(DSK),CMDS
	$(OS9ATTR) -e $(DSK),CMDS/$(TARGET)
	
dskclean:
	$(RM) $(DSK)

clean: dskclean
	$(RM) $(OBJS) $(TARGET)
