include $(NITROS9DIR)/rules.mak

dirs	= kq1 kq2 kq3 kq4 pq1 sq1 sq2 lsl

# Make all components
all:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*             Sierra Adventure Games             *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
	$(foreach dir, $(dirs), ($(CD) $(dir); make);)

# Clean all components
clean:	dskclean
	$(foreach dir, $(dirs), ($(CD) $(dir); make clean);)

# Create dsk images
dsk:
	$(foreach dir, $(dirs), ($(CD) $(dir); make dsk);)

# Copy dsk images
dskcopy: dsk
	$(foreach dir, $(dirs), ($(CD) $(dir); make dskcopy);)

# Clean dsk images
dskclean:
	$(foreach dir, $(dirs), ($(CD) $(dir); make dskclean);)
