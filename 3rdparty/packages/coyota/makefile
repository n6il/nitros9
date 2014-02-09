include $(NITROS9DIR)/rules.mak

TARGET	= coyota
OBJS	= coyota.o instrument.o dashboard.o bin_dec32.o
LFLAGS	+= -lalib -lnos96809l2 -L$(NOSLIB)

$(TARGET): $(OBJS)

clean:
	$(RM) $(OBJS) $(TARGET)
