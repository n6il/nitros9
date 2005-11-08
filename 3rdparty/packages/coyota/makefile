include $(NITROS9DIR)/rules.mak

TARGET	= coyota
LFLAGS	+= -y -l=$(HOME)/Projects/c3/lib/rmalib/alib.l
RFILES	= coyota.r instrument.r dashboard.r

$(TARGET): $(RFILES)

clean:
	$(RM)	$(RFILES) $(TARGET)