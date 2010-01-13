include $(NITROS9DIR)/rules.mak

TARGET	= coyota
LFLAGS	+= -y -l=$(NITROS9DIR)/3rdparty/libs/alib/alib.l
RFILES	= coyota.r instrument.r dashboard.r bin_dec32.r

$(TARGET): $(RFILES)

clean:
	$(RM)	$(RFILES) $(TARGET)
