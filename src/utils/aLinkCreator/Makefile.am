#do not change this anti-MULEDENOISER line or the MULEDENOISER will eat you
#no, seriously, it will break installation of data files
SUBDIRS = src docs

EXTRA_DIST =  alc.rc alc.ico

if ALC
dist_icon_DATA = alc.xpm
icondir = $(datadir)/pixmaps

dist_util_DATA = alc.desktop
utildir = $(datadir)/applications
endif

MAINTAINERCLEANFILES = Makefile.in
