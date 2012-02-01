include $(NITROS9DIR)/rules.mak

RFILES	= main90.r board90.r caged90.r check90.r ghosts90.r movpac90.r \
	score90.r scrns90.r setup90.r

pacos9: $(RFILES)
	rlink  $(RFILES) -o=pacos9 -l=$(C3BASE)/lib/sys.l

clean:
	$(RM) $(RFILES) pacos9

info:
