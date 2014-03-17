#
#   appweb-vxworks-static.mk -- Makefile to build Embedthis Appweb for vxworks
#

NAME                  := appweb
VERSION               := 5.0.0-rc0
PROFILE               ?= static
ARCH                  ?= $(shell echo $(WIND_HOST_TYPE) | sed 's/-.*//')
CPU                   ?= $(subst X86,PENTIUM,$(shell echo $(ARCH) | tr a-z A-Z))
OS                    ?= vxworks
CC                    ?= cc$(subst x86,pentium,$(ARCH))
LD                    ?= ld
CONFIG                ?= $(OS)-$(ARCH)-$(PROFILE)
LBIN                  ?= $(CONFIG)/bin
PATH                  := $(LBIN):$(PATH)

ME_EXT_CGI            ?= 0
ME_EXT_EJS            ?= 0
ME_EXT_ESP            ?= 1
ME_EXT_EST            ?= 1
ME_EXT_MATRIXSSL      ?= 0
ME_EXT_MDB            ?= 1
ME_EXT_NANOSSL        ?= 0
ME_EXT_OPENSSL        ?= 0
ME_EXT_PCRE           ?= 1
ME_EXT_PHP            ?= 0
ME_EXT_SQLITE         ?= 0
ME_EXT_SSL            ?= 1
ME_EXT_ZLIB           ?= 1

ME_EXT_COMPILER_PATH  ?= cc$(subst x86,pentium,$(ARCH))
ME_EXT_DOXYGEN_PATH   ?= doxygen
ME_EXT_DSI_PATH       ?= dsi
ME_EXT_ESP_PATH       ?= src/paks/esp/esp.me
ME_EXT_EST_PATH       ?= src/paks/est/estLib.c
ME_EXT_GZIP_PATH      ?= gzip
ME_EXT_HTMLMIN_PATH   ?= htmlmin
ME_EXT_HTTP_PATH      ?= src/paks/http/http.me
ME_EXT_LIB_PATH       ?= ar
ME_EXT_LINK_PATH      ?= ld
ME_EXT_MAN_PATH       ?= man
ME_EXT_MAN2HTML_PATH  ?= man2html
ME_EXT_MATRIXSSL_PATH ?= /usr/src/matrixssl
ME_EXT_MDB_PATH       ?= src/mdb.c
ME_EXT_MPR_PATH       ?= src/paks/mpr/mpr.me
ME_EXT_NANOSSL_PATH   ?= /usr/src/nanossl
ME_EXT_NGMIN_PATH     ?= ngmin
ME_EXT_OPENSSL_PATH   ?= /usr/src/openssl
ME_EXT_OSDEP_PATH     ?= src/paks/osdep/osdep.me
ME_EXT_PAK_PATH       ?= pak
ME_EXT_PCRE_PATH      ?= src/paks/pcre/pcre.me
ME_EXT_PMAKER_PATH    ?= [function Function]
ME_EXT_RECESS_PATH    ?= recess
ME_EXT_UGLIFYJS_PATH  ?= uglifyjs
ME_EXT_UTEST_PATH     ?= utest
ME_EXT_VXWORKS_PATH   ?= $(WIND_BASE)
ME_EXT_ZIP_PATH       ?= zip

export WIND_HOME      ?= $(WIND_BASE)/..
export PATH           := $(WIND_GNU_PATH)/$(WIND_HOST_TYPE)/bin:$(PATH)

CFLAGS                += -fno-builtin -fno-defer-pop -fvolatile -w
DFLAGS                += -DVXWORKS -DRW_MULTI_THREAD -D_GNU_TOOL -DCPU=PENTIUM $(patsubst %,-D%,$(filter ME_%,$(MAKEFLAGS))) -DME_EXT_CGI=$(ME_EXT_CGI) -DME_EXT_EJS=$(ME_EXT_EJS) -DME_EXT_ESP=$(ME_EXT_ESP) -DME_EXT_EST=$(ME_EXT_EST) -DME_EXT_MATRIXSSL=$(ME_EXT_MATRIXSSL) -DME_EXT_MDB=$(ME_EXT_MDB) -DME_EXT_NANOSSL=$(ME_EXT_NANOSSL) -DME_EXT_OPENSSL=$(ME_EXT_OPENSSL) -DME_EXT_PCRE=$(ME_EXT_PCRE) -DME_EXT_PHP=$(ME_EXT_PHP) -DME_EXT_SQLITE=$(ME_EXT_SQLITE) -DME_EXT_SSL=$(ME_EXT_SSL) -DME_EXT_ZLIB=$(ME_EXT_ZLIB) 
IFLAGS                += "-I$(CONFIG)/inc -I$(WIND_BASE)/target/h -I$(WIND_BASE)/target/h/wrn/coreip"
LDFLAGS               += '-Wl,-r'
LIBPATHS              += -L$(CONFIG)/bin
LIBS                  += -lgcc

DEBUG                 ?= debug
CFLAGS-debug          ?= -g
DFLAGS-debug          ?= -DME_DEBUG
LDFLAGS-debug         ?= -g
DFLAGS-release        ?= 
CFLAGS-release        ?= -O2
LDFLAGS-release       ?= 
CFLAGS                += $(CFLAGS-$(DEBUG))
DFLAGS                += $(DFLAGS-$(DEBUG))
LDFLAGS               += $(LDFLAGS-$(DEBUG))

ME_ROOT_PREFIX        ?= deploy
ME_BASE_PREFIX        ?= $(ME_ROOT_PREFIX)
ME_DATA_PREFIX        ?= $(ME_VAPP_PREFIX)
ME_STATE_PREFIX       ?= $(ME_VAPP_PREFIX)
ME_BIN_PREFIX         ?= $(ME_VAPP_PREFIX)
ME_INC_PREFIX         ?= $(ME_VAPP_PREFIX)/inc
ME_LIB_PREFIX         ?= $(ME_VAPP_PREFIX)
ME_MAN_PREFIX         ?= $(ME_VAPP_PREFIX)
ME_SBIN_PREFIX        ?= $(ME_VAPP_PREFIX)
ME_ETC_PREFIX         ?= $(ME_VAPP_PREFIX)
ME_WEB_PREFIX         ?= $(ME_VAPP_PREFIX)/web
ME_LOG_PREFIX         ?= $(ME_VAPP_PREFIX)
ME_SPOOL_PREFIX       ?= $(ME_VAPP_PREFIX)
ME_CACHE_PREFIX       ?= $(ME_VAPP_PREFIX)
ME_APP_PREFIX         ?= $(ME_BASE_PREFIX)
ME_VAPP_PREFIX        ?= $(ME_APP_PREFIX)
ME_SRC_PREFIX         ?= $(ME_ROOT_PREFIX)/usr/src/$(NAME)-$(VERSION)


ifeq ($(ME_EXT_ESP),1)
    TARGETS           += $(CONFIG)/bin/libmod_esp.a
endif
ifeq ($(ME_EXT_ESP),1)
    TARGETS           += $(CONFIG)/bin/esp.out
endif
ifeq ($(ME_EXT_ESP),1)
    TARGETS           += $(CONFIG)/bin/esp.conf
endif
ifeq ($(ME_EXT_ESP),1)
    TARGETS           += $(CONFIG)/paks
endif
ifeq ($(ME_EXT_EST),1)
    TARGETS           += $(CONFIG)/bin/libest.a
endif
TARGETS               += $(CONFIG)/bin/ca.crt
TARGETS               += $(CONFIG)/bin/http.out
TARGETS               += $(CONFIG)/bin/appman.out
ifeq ($(ME_EXT_ZLIB),1)
    TARGETS           += $(CONFIG)/bin/libzlib.a
endif
TARGETS               += src/slink.c
TARGETS               += $(CONFIG)/bin/libslink.a
ifeq ($(ME_EXT_SSL),1)
    TARGETS           += $(CONFIG)/bin/libmod_ssl.a
endif
TARGETS               += $(CONFIG)/bin/authpass.out
TARGETS               += $(CONFIG)/bin/appweb.out
TARGETS               += src/server/cache
TARGETS               += $(CONFIG)/bin/testAppweb.out

unexport CDPATH

ifndef SHOW
.SILENT:
endif

all build compile: prep $(TARGETS)

.PHONY: prep

prep:
	@echo "      [Info] Use "make SHOW=1" to trace executed commands."
	@if [ "$(CONFIG)" = "" ] ; then echo WARNING: CONFIG not set ; exit 255 ; fi
	@if [ "$(ME_APP_PREFIX)" = "" ] ; then echo WARNING: ME_APP_PREFIX not set ; exit 255 ; fi
	@if [ "$(WIND_BASE)" = "" ] ; then echo WARNING: WIND_BASE not set. Run wrenv.sh. ; exit 255 ; fi
	@if [ "$(WIND_HOST_TYPE)" = "" ] ; then echo WARNING: WIND_HOST_TYPE not set. Run wrenv.sh. ; exit 255 ; fi
	@if [ "$(WIND_GNU_PATH)" = "" ] ; then echo WARNING: WIND_GNU_PATH not set. Run wrenv.sh. ; exit 255 ; fi
	@[ ! -x $(CONFIG)/bin ] && mkdir -p $(CONFIG)/bin; true
	@[ ! -x $(CONFIG)/inc ] && mkdir -p $(CONFIG)/inc; true
	@[ ! -x $(CONFIG)/obj ] && mkdir -p $(CONFIG)/obj; true
	@[ ! -f $(CONFIG)/inc/osdep.h ] && cp src/paks/osdep/osdep.h $(CONFIG)/inc/osdep.h ; true
	@if ! diff $(CONFIG)/inc/osdep.h src/paks/osdep/osdep.h >/dev/null ; then\
		cp src/paks/osdep/osdep.h $(CONFIG)/inc/osdep.h  ; \
	fi; true
	@[ ! -f $(CONFIG)/inc/me.h ] && cp projects/appweb-vxworks-static-me.h $(CONFIG)/inc/me.h ; true
	@if ! diff $(CONFIG)/inc/me.h projects/appweb-vxworks-static-me.h >/dev/null ; then\
		cp projects/appweb-vxworks-static-me.h $(CONFIG)/inc/me.h  ; \
	fi; true
	@if [ -f "$(CONFIG)/.makeflags" ] ; then \
		if [ "$(MAKEFLAGS)" != " ` cat $(CONFIG)/.makeflags`" ] ; then \
			echo "   [Warning] Make flags have changed since the last build: "`cat $(CONFIG)/.makeflags`"" ; \
		fi ; \
	fi
	@echo $(MAKEFLAGS) >$(CONFIG)/.makeflags

clean:
	rm -f "$(CONFIG)/bin/libmod_esp.a"
	rm -f "$(CONFIG)/bin/esp.out"
	rm -f "$(CONFIG)/bin/esp.conf"
	rm -f "$(CONFIG)/bin/libest.a"
	rm -f "$(CONFIG)/bin/ca.crt"
	rm -f "$(CONFIG)/bin/libhttp.a"
	rm -f "$(CONFIG)/bin/http.out"
	rm -f "$(CONFIG)/bin/libmpr.a"
	rm -f "$(CONFIG)/bin/libmprssl.a"
	rm -f "$(CONFIG)/bin/appman.out"
	rm -f "$(CONFIG)/bin/makerom.out"
	rm -f "$(CONFIG)/bin/libpcre.a"
	rm -f "$(CONFIG)/bin/libzlib.a"
	rm -f "$(CONFIG)/bin/libappweb.a"
	rm -f "$(CONFIG)/bin/libslink.a"
	rm -f "$(CONFIG)/bin/libmod_ssl.a"
	rm -f "$(CONFIG)/bin/authpass.out"
	rm -f "$(CONFIG)/bin/appweb.out"
	rm -f "$(CONFIG)/bin/testAppweb.out"
	rm -f "$(CONFIG)/obj/espLib.o"
	rm -f "$(CONFIG)/obj/esp.o"
	rm -f "$(CONFIG)/obj/estLib.o"
	rm -f "$(CONFIG)/obj/httpLib.o"
	rm -f "$(CONFIG)/obj/http.o"
	rm -f "$(CONFIG)/obj/mprLib.o"
	rm -f "$(CONFIG)/obj/mprSsl.o"
	rm -f "$(CONFIG)/obj/manager.o"
	rm -f "$(CONFIG)/obj/makerom.o"
	rm -f "$(CONFIG)/obj/pcre.o"
	rm -f "$(CONFIG)/obj/zlib.o"
	rm -f "$(CONFIG)/obj/config.o"
	rm -f "$(CONFIG)/obj/convenience.o"
	rm -f "$(CONFIG)/obj/dirHandler.o"
	rm -f "$(CONFIG)/obj/fileHandler.o"
	rm -f "$(CONFIG)/obj/log.o"
	rm -f "$(CONFIG)/obj/server.o"
	rm -f "$(CONFIG)/obj/slink.o"
	rm -f "$(CONFIG)/obj/sslModule.o"
	rm -f "$(CONFIG)/obj/authpass.o"
	rm -f "$(CONFIG)/obj/appweb.o"
	rm -f "$(CONFIG)/obj/testAppweb.o"
	rm -f "$(CONFIG)/obj/testHttp.o"

clobber: clean
	rm -fr ./$(CONFIG)



#
#   version
#
version: $(DEPS_1)
	echo 5.0.0-rc0

#
#   mpr.h
#
$(CONFIG)/inc/mpr.h: $(DEPS_2)
	@echo '      [Copy] $(CONFIG)/inc/mpr.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/mpr/mpr.h $(CONFIG)/inc/mpr.h

#
#   me.h
#
$(CONFIG)/inc/me.h: $(DEPS_3)
	@echo '      [Copy] $(CONFIG)/inc/me.h'

#
#   osdep.h
#
$(CONFIG)/inc/osdep.h: $(DEPS_4)
	@echo '      [Copy] $(CONFIG)/inc/osdep.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/osdep/osdep.h $(CONFIG)/inc/osdep.h

#
#   mprLib.o
#
DEPS_5 += $(CONFIG)/inc/me.h
DEPS_5 += $(CONFIG)/inc/mpr.h
DEPS_5 += $(CONFIG)/inc/osdep.h

$(CONFIG)/obj/mprLib.o: \
    src/paks/mpr/mprLib.c $(DEPS_5)
	@echo '   [Compile] $(CONFIG)/obj/mprLib.o'
	 -c -o $(CONFIG)/obj/mprLib.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/mpr/mprLib.c

#
#   libmpr
#
DEPS_6 += $(CONFIG)/inc/mpr.h
DEPS_6 += $(CONFIG)/inc/me.h
DEPS_6 += $(CONFIG)/inc/osdep.h
DEPS_6 += $(CONFIG)/obj/mprLib.o

$(CONFIG)/bin/libmpr.a: $(DEPS_6)
	@echo '      [Link] $(CONFIG)/bin/libmpr.a'
	 -cr $(CONFIG)/bin/libmpr.a "$(CONFIG)/obj/mprLib.o"

#
#   pcre.h
#
$(CONFIG)/inc/pcre.h: $(DEPS_7)
	@echo '      [Copy] $(CONFIG)/inc/pcre.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/pcre/pcre.h $(CONFIG)/inc/pcre.h

#
#   pcre.o
#
DEPS_8 += $(CONFIG)/inc/me.h
DEPS_8 += $(CONFIG)/inc/pcre.h

$(CONFIG)/obj/pcre.o: \
    src/paks/pcre/pcre.c $(DEPS_8)
	@echo '   [Compile] $(CONFIG)/obj/pcre.o'
	 -c -o $(CONFIG)/obj/pcre.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/pcre/pcre.c

ifeq ($(ME_EXT_PCRE),1)
#
#   libpcre
#
DEPS_9 += $(CONFIG)/inc/pcre.h
DEPS_9 += $(CONFIG)/inc/me.h
DEPS_9 += $(CONFIG)/obj/pcre.o

$(CONFIG)/bin/libpcre.a: $(DEPS_9)
	@echo '      [Link] $(CONFIG)/bin/libpcre.a'
	 -cr $(CONFIG)/bin/libpcre.a "$(CONFIG)/obj/pcre.o"
endif

#
#   http.h
#
$(CONFIG)/inc/http.h: $(DEPS_10)
	@echo '      [Copy] $(CONFIG)/inc/http.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/http/http.h $(CONFIG)/inc/http.h

#
#   httpLib.o
#
DEPS_11 += $(CONFIG)/inc/me.h
DEPS_11 += $(CONFIG)/inc/http.h
DEPS_11 += $(CONFIG)/inc/mpr.h

$(CONFIG)/obj/httpLib.o: \
    src/paks/http/httpLib.c $(DEPS_11)
	@echo '   [Compile] $(CONFIG)/obj/httpLib.o'
	 -c -o $(CONFIG)/obj/httpLib.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/http/httpLib.c

#
#   libhttp
#
DEPS_12 += $(CONFIG)/inc/mpr.h
DEPS_12 += $(CONFIG)/inc/me.h
DEPS_12 += $(CONFIG)/inc/osdep.h
DEPS_12 += $(CONFIG)/obj/mprLib.o
DEPS_12 += $(CONFIG)/bin/libmpr.a
DEPS_12 += $(CONFIG)/inc/pcre.h
DEPS_12 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_EXT_PCRE),1)
    DEPS_12 += $(CONFIG)/bin/libpcre.a
endif
DEPS_12 += $(CONFIG)/inc/http.h
DEPS_12 += $(CONFIG)/obj/httpLib.o

$(CONFIG)/bin/libhttp.a: $(DEPS_12)
	@echo '      [Link] $(CONFIG)/bin/libhttp.a'
	 -cr $(CONFIG)/bin/libhttp.a "$(CONFIG)/obj/httpLib.o"

#
#   appweb.h
#
$(CONFIG)/inc/appweb.h: $(DEPS_13)
	@echo '      [Copy] $(CONFIG)/inc/appweb.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/appweb.h $(CONFIG)/inc/appweb.h

#
#   customize.h
#
$(CONFIG)/inc/customize.h: $(DEPS_14)
	@echo '      [Copy] $(CONFIG)/inc/customize.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/customize.h $(CONFIG)/inc/customize.h

#
#   config.o
#
DEPS_15 += $(CONFIG)/inc/me.h
DEPS_15 += $(CONFIG)/inc/appweb.h
DEPS_15 += $(CONFIG)/inc/pcre.h
DEPS_15 += $(CONFIG)/inc/mpr.h
DEPS_15 += $(CONFIG)/inc/http.h
DEPS_15 += $(CONFIG)/inc/customize.h

$(CONFIG)/obj/config.o: \
    src/config.c $(DEPS_15)
	@echo '   [Compile] $(CONFIG)/obj/config.o'
	 -c -o $(CONFIG)/obj/config.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/config.c

#
#   convenience.o
#
DEPS_16 += $(CONFIG)/inc/me.h
DEPS_16 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/convenience.o: \
    src/convenience.c $(DEPS_16)
	@echo '   [Compile] $(CONFIG)/obj/convenience.o'
	 -c -o $(CONFIG)/obj/convenience.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/convenience.c

#
#   dirHandler.o
#
DEPS_17 += $(CONFIG)/inc/me.h
DEPS_17 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/dirHandler.o: \
    src/dirHandler.c $(DEPS_17)
	@echo '   [Compile] $(CONFIG)/obj/dirHandler.o'
	 -c -o $(CONFIG)/obj/dirHandler.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/dirHandler.c

#
#   fileHandler.o
#
DEPS_18 += $(CONFIG)/inc/me.h
DEPS_18 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/fileHandler.o: \
    src/fileHandler.c $(DEPS_18)
	@echo '   [Compile] $(CONFIG)/obj/fileHandler.o'
	 -c -o $(CONFIG)/obj/fileHandler.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/fileHandler.c

#
#   log.o
#
DEPS_19 += $(CONFIG)/inc/me.h
DEPS_19 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/log.o: \
    src/log.c $(DEPS_19)
	@echo '   [Compile] $(CONFIG)/obj/log.o'
	 -c -o $(CONFIG)/obj/log.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/log.c

#
#   server.o
#
DEPS_20 += $(CONFIG)/inc/me.h
DEPS_20 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/server.o: \
    src/server.c $(DEPS_20)
	@echo '   [Compile] $(CONFIG)/obj/server.o'
	 -c -o $(CONFIG)/obj/server.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/server.c

#
#   libappweb
#
DEPS_21 += $(CONFIG)/inc/mpr.h
DEPS_21 += $(CONFIG)/inc/me.h
DEPS_21 += $(CONFIG)/inc/osdep.h
DEPS_21 += $(CONFIG)/obj/mprLib.o
DEPS_21 += $(CONFIG)/bin/libmpr.a
DEPS_21 += $(CONFIG)/inc/pcre.h
DEPS_21 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_EXT_PCRE),1)
    DEPS_21 += $(CONFIG)/bin/libpcre.a
endif
DEPS_21 += $(CONFIG)/inc/http.h
DEPS_21 += $(CONFIG)/obj/httpLib.o
DEPS_21 += $(CONFIG)/bin/libhttp.a
DEPS_21 += $(CONFIG)/inc/appweb.h
DEPS_21 += $(CONFIG)/inc/customize.h
DEPS_21 += $(CONFIG)/obj/config.o
DEPS_21 += $(CONFIG)/obj/convenience.o
DEPS_21 += $(CONFIG)/obj/dirHandler.o
DEPS_21 += $(CONFIG)/obj/fileHandler.o
DEPS_21 += $(CONFIG)/obj/log.o
DEPS_21 += $(CONFIG)/obj/server.o

$(CONFIG)/bin/libappweb.a: $(DEPS_21)
	@echo '      [Link] $(CONFIG)/bin/libappweb.a'
	 -cr $(CONFIG)/bin/libappweb.a "$(CONFIG)/obj/config.o" "$(CONFIG)/obj/convenience.o" "$(CONFIG)/obj/dirHandler.o" "$(CONFIG)/obj/fileHandler.o" "$(CONFIG)/obj/log.o" "$(CONFIG)/obj/server.o"

#
#   esp.h
#
$(CONFIG)/inc/esp.h: $(DEPS_22)
	@echo '      [Copy] $(CONFIG)/inc/esp.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/esp/esp.h $(CONFIG)/inc/esp.h

#
#   espLib.o
#
DEPS_23 += $(CONFIG)/inc/me.h
DEPS_23 += $(CONFIG)/inc/esp.h
DEPS_23 += $(CONFIG)/inc/pcre.h
DEPS_23 += $(CONFIG)/inc/http.h

$(CONFIG)/obj/espLib.o: \
    src/paks/esp/espLib.c $(DEPS_23)
	@echo '   [Compile] $(CONFIG)/obj/espLib.o'
	 -c -o $(CONFIG)/obj/espLib.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/esp/espLib.c

ifeq ($(ME_EXT_ESP),1)
#
#   libmod_esp
#
DEPS_24 += $(CONFIG)/inc/mpr.h
DEPS_24 += $(CONFIG)/inc/me.h
DEPS_24 += $(CONFIG)/inc/osdep.h
DEPS_24 += $(CONFIG)/obj/mprLib.o
DEPS_24 += $(CONFIG)/bin/libmpr.a
DEPS_24 += $(CONFIG)/inc/pcre.h
DEPS_24 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_EXT_PCRE),1)
    DEPS_24 += $(CONFIG)/bin/libpcre.a
endif
DEPS_24 += $(CONFIG)/inc/http.h
DEPS_24 += $(CONFIG)/obj/httpLib.o
DEPS_24 += $(CONFIG)/bin/libhttp.a
DEPS_24 += $(CONFIG)/inc/appweb.h
DEPS_24 += $(CONFIG)/inc/customize.h
DEPS_24 += $(CONFIG)/obj/config.o
DEPS_24 += $(CONFIG)/obj/convenience.o
DEPS_24 += $(CONFIG)/obj/dirHandler.o
DEPS_24 += $(CONFIG)/obj/fileHandler.o
DEPS_24 += $(CONFIG)/obj/log.o
DEPS_24 += $(CONFIG)/obj/server.o
DEPS_24 += $(CONFIG)/bin/libappweb.a
DEPS_24 += $(CONFIG)/inc/esp.h
DEPS_24 += $(CONFIG)/obj/espLib.o

$(CONFIG)/bin/libmod_esp.a: $(DEPS_24)
	@echo '      [Link] $(CONFIG)/bin/libmod_esp.a'
	 -cr $(CONFIG)/bin/libmod_esp.a "$(CONFIG)/obj/espLib.o"
endif

#
#   esp.o
#
DEPS_25 += $(CONFIG)/inc/me.h
DEPS_25 += $(CONFIG)/inc/esp.h

$(CONFIG)/obj/esp.o: \
    src/paks/esp/esp.c $(DEPS_25)
	@echo '   [Compile] $(CONFIG)/obj/esp.o'
	 -c -o $(CONFIG)/obj/esp.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/esp/esp.c

ifeq ($(ME_EXT_ESP),1)
#
#   espcmd
#
DEPS_26 += $(CONFIG)/inc/mpr.h
DEPS_26 += $(CONFIG)/inc/me.h
DEPS_26 += $(CONFIG)/inc/osdep.h
DEPS_26 += $(CONFIG)/obj/mprLib.o
DEPS_26 += $(CONFIG)/bin/libmpr.a
DEPS_26 += $(CONFIG)/inc/pcre.h
DEPS_26 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_EXT_PCRE),1)
    DEPS_26 += $(CONFIG)/bin/libpcre.a
endif
DEPS_26 += $(CONFIG)/inc/http.h
DEPS_26 += $(CONFIG)/obj/httpLib.o
DEPS_26 += $(CONFIG)/bin/libhttp.a
DEPS_26 += $(CONFIG)/inc/appweb.h
DEPS_26 += $(CONFIG)/inc/customize.h
DEPS_26 += $(CONFIG)/obj/config.o
DEPS_26 += $(CONFIG)/obj/convenience.o
DEPS_26 += $(CONFIG)/obj/dirHandler.o
DEPS_26 += $(CONFIG)/obj/fileHandler.o
DEPS_26 += $(CONFIG)/obj/log.o
DEPS_26 += $(CONFIG)/obj/server.o
DEPS_26 += $(CONFIG)/bin/libappweb.a
DEPS_26 += $(CONFIG)/inc/esp.h
DEPS_26 += $(CONFIG)/obj/espLib.o
DEPS_26 += $(CONFIG)/bin/libmod_esp.a
DEPS_26 += $(CONFIG)/obj/esp.o

LIBS_26 += -lappweb
LIBS_26 += -lhttp
LIBS_26 += -lmpr
ifeq ($(ME_EXT_PCRE),1)
    LIBS_26 += -lpcre
endif
LIBS_26 += -lmod_esp

$(CONFIG)/bin/esp.out: $(DEPS_26)
	@echo '      [Link] $(CONFIG)/bin/esp.out'
	 -o $(CONFIG)/bin/esp.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/esp.o" "$(CONFIG)/obj/espLib.o" $(LIBPATHS_26) $(LIBS_26) $(LIBS_26) $(LIBS) -Wl,-r 
endif

ifeq ($(ME_EXT_ESP),1)
#
#   esp.conf
#
DEPS_27 += src/paks/esp/esp.conf

$(CONFIG)/bin/esp.conf: $(DEPS_27)
	@echo '      [Copy] $(CONFIG)/bin/esp.conf'
	mkdir -p "$(CONFIG)/bin"
	cp src/paks/esp/esp.conf $(CONFIG)/bin/esp.conf
endif

ifeq ($(ME_EXT_ESP),1)
#
#   esp-paks
#
DEPS_28 += src/paks/angular
DEPS_28 += src/paks/angular/angular-animate.js
DEPS_28 += src/paks/angular/angular-csp.css
DEPS_28 += src/paks/angular/angular-route.js
DEPS_28 += src/paks/angular/angular.js
DEPS_28 += src/paks/angular/package.json
DEPS_28 += src/paks/ejs
DEPS_28 += src/paks/ejs/ejs.c
DEPS_28 += src/paks/ejs/ejs.es
DEPS_28 += src/paks/ejs/ejs.h
DEPS_28 += src/paks/ejs/ejs.me
DEPS_28 += src/paks/ejs/ejs.slots.h
DEPS_28 += src/paks/ejs/ejsByteGoto.h
DEPS_28 += src/paks/ejs/ejsc.c
DEPS_28 += src/paks/ejs/ejsLib.c
DEPS_28 += src/paks/ejs/LICENSE.md
DEPS_28 += src/paks/ejs/package.json
DEPS_28 += src/paks/ejs/README.md
DEPS_28 += src/paks/esp
DEPS_28 += src/paks/esp/bower.json
DEPS_28 += src/paks/esp/esp.c
DEPS_28 += src/paks/esp/esp.conf
DEPS_28 += src/paks/esp/esp.h
DEPS_28 += src/paks/esp/esp.me
DEPS_28 += src/paks/esp/espLib.c
DEPS_28 += src/paks/esp/LICENSE.md
DEPS_28 += src/paks/esp/package.json
DEPS_28 += src/paks/esp/README.md
DEPS_28 += src/paks/esp-angular
DEPS_28 += src/paks/esp-angular/esp-click.js
DEPS_28 += src/paks/esp-angular/esp-edit.js
DEPS_28 += src/paks/esp-angular/esp-field-errors.js
DEPS_28 += src/paks/esp-angular/esp-fixnum.js
DEPS_28 += src/paks/esp-angular/esp-format.js
DEPS_28 += src/paks/esp-angular/esp-input-group.js
DEPS_28 += src/paks/esp-angular/esp-input.js
DEPS_28 += src/paks/esp-angular/esp-resource.js
DEPS_28 += src/paks/esp-angular/esp-session.js
DEPS_28 += src/paks/esp-angular/esp-titlecase.js
DEPS_28 += src/paks/esp-angular/esp.js
DEPS_28 += src/paks/esp-angular/package.json
DEPS_28 += src/paks/esp-angular-mvc
DEPS_28 += src/paks/esp-angular-mvc/package.json
DEPS_28 += src/paks/esp-angular-mvc/templates
DEPS_28 += src/paks/esp-angular-mvc/templates/esp-angular-mvc
DEPS_28 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/appweb.conf
DEPS_28 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client
DEPS_28 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/app
DEPS_28 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/app/main.js
DEPS_28 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/assets
DEPS_28 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/assets/favicon.ico
DEPS_28 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css
DEPS_28 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css/all.css
DEPS_28 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css/all.less
DEPS_28 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css/app.less
DEPS_28 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css/fix.css
DEPS_28 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css/theme.less
DEPS_28 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/index.esp
DEPS_28 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/pages
DEPS_28 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/pages/splash.html
DEPS_28 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/controller-singleton.c
DEPS_28 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/controller.c
DEPS_28 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/controller.js
DEPS_28 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/edit.html
DEPS_28 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/list.html
DEPS_28 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/model.js
DEPS_28 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/start.me
DEPS_28 += src/paks/esp-html-mvc
DEPS_28 += src/paks/esp-html-mvc/package.json
DEPS_28 += src/paks/esp-html-mvc/templates
DEPS_28 += src/paks/esp-html-mvc/templates/esp-html-mvc
DEPS_28 += src/paks/esp-html-mvc/templates/esp-html-mvc/appweb.conf
DEPS_28 += src/paks/esp-html-mvc/templates/esp-html-mvc/client
DEPS_28 += src/paks/esp-html-mvc/templates/esp-html-mvc/client/assets
DEPS_28 += src/paks/esp-html-mvc/templates/esp-html-mvc/client/assets/favicon.ico
DEPS_28 += src/paks/esp-html-mvc/templates/esp-html-mvc/client/css
DEPS_28 += src/paks/esp-html-mvc/templates/esp-html-mvc/client/css/all.css
DEPS_28 += src/paks/esp-html-mvc/templates/esp-html-mvc/client/css/all.less
DEPS_28 += src/paks/esp-html-mvc/templates/esp-html-mvc/client/css/app.less
DEPS_28 += src/paks/esp-html-mvc/templates/esp-html-mvc/client/css/theme.less
DEPS_28 += src/paks/esp-html-mvc/templates/esp-html-mvc/client/index.esp
DEPS_28 += src/paks/esp-html-mvc/templates/esp-html-mvc/client/layouts
DEPS_28 += src/paks/esp-html-mvc/templates/esp-html-mvc/client/layouts/default.esp
DEPS_28 += src/paks/esp-html-mvc/templates/esp-html-mvc/controller-singleton.c
DEPS_28 += src/paks/esp-html-mvc/templates/esp-html-mvc/controller.c
DEPS_28 += src/paks/esp-html-mvc/templates/esp-html-mvc/edit.esp
DEPS_28 += src/paks/esp-html-mvc/templates/esp-html-mvc/list.esp
DEPS_28 += src/paks/esp-html-mvc/templates/esp-html-mvc/start.me
DEPS_28 += src/paks/esp-legacy-mvc
DEPS_28 += src/paks/esp-legacy-mvc/package.json
DEPS_28 += src/paks/esp-legacy-mvc/templates
DEPS_28 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc
DEPS_28 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/appweb.conf
DEPS_28 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/controller.c
DEPS_28 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/edit.esp
DEPS_28 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/layouts
DEPS_28 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/layouts/default.esp
DEPS_28 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/list.esp
DEPS_28 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/migration.c
DEPS_28 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/src
DEPS_28 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/src/app.c
DEPS_28 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static
DEPS_28 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/css
DEPS_28 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/css/all.css
DEPS_28 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/images
DEPS_28 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/images/banner.jpg
DEPS_28 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/images/favicon.ico
DEPS_28 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/images/splash.jpg
DEPS_28 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/index.esp
DEPS_28 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/js
DEPS_28 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/js/jquery.esp.js
DEPS_28 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/js/jquery.js
DEPS_28 += src/paks/esp-server
DEPS_28 += src/paks/esp-server/package.json
DEPS_28 += src/paks/esp-server/templates
DEPS_28 += src/paks/esp-server/templates/esp-server
DEPS_28 += src/paks/esp-server/templates/esp-server/appweb.conf
DEPS_28 += src/paks/esp-server/templates/esp-server/controller.c
DEPS_28 += src/paks/esp-server/templates/esp-server/migration.c
DEPS_28 += src/paks/esp-server/templates/esp-server/src
DEPS_28 += src/paks/esp-server/templates/esp-server/src/app.c
DEPS_28 += src/paks/est
DEPS_28 += src/paks/est/ca.crt
DEPS_28 += src/paks/est/est.h
DEPS_28 += src/paks/est/est.me
DEPS_28 += src/paks/est/estLib.c
DEPS_28 += src/paks/est/LICENSE.md
DEPS_28 += src/paks/est/package.json
DEPS_28 += src/paks/est/README.md
DEPS_28 += src/paks/http
DEPS_28 += src/paks/http/http.c
DEPS_28 += src/paks/http/http.h
DEPS_28 += src/paks/http/http.me
DEPS_28 += src/paks/http/httpLib.c
DEPS_28 += src/paks/http/LICENSE.md
DEPS_28 += src/paks/http/package.json
DEPS_28 += src/paks/http/README.md
DEPS_28 += src/paks/me-dev
DEPS_28 += src/paks/me-dev/dev.es
DEPS_28 += src/paks/me-dev/dev.me
DEPS_28 += src/paks/me-dev/package.json
DEPS_28 += src/paks/me-doc
DEPS_28 += src/paks/me-doc/doc.es
DEPS_28 += src/paks/me-doc/doc.me
DEPS_28 += src/paks/me-doc/package.json
DEPS_28 += src/paks/me-package
DEPS_28 += src/paks/me-package/manifest.me
DEPS_28 += src/paks/me-package/package.es
DEPS_28 += src/paks/me-package/package.json
DEPS_28 += src/paks/me-package/package.me
DEPS_28 += src/paks/mpr
DEPS_28 += src/paks/mpr/LICENSE.md
DEPS_28 += src/paks/mpr/makerom.c
DEPS_28 += src/paks/mpr/manager.c
DEPS_28 += src/paks/mpr/mpr.h
DEPS_28 += src/paks/mpr/mpr.me
DEPS_28 += src/paks/mpr/mprLib.c
DEPS_28 += src/paks/mpr/mprSsl.c
DEPS_28 += src/paks/mpr/package.json
DEPS_28 += src/paks/mpr/README.md
DEPS_28 += src/paks/osdep
DEPS_28 += src/paks/osdep/LICENSE.md
DEPS_28 += src/paks/osdep/osdep.h
DEPS_28 += src/paks/osdep/osdep.me
DEPS_28 += src/paks/osdep/package.json
DEPS_28 += src/paks/osdep/README.md
DEPS_28 += src/paks/pcre
DEPS_28 += src/paks/pcre/LICENSE.md
DEPS_28 += src/paks/pcre/package.json
DEPS_28 += src/paks/pcre/pcre.c
DEPS_28 += src/paks/pcre/pcre.h
DEPS_28 += src/paks/pcre/pcre.me
DEPS_28 += src/paks/pcre/README.md
DEPS_28 += src/paks/sqlite
DEPS_28 += src/paks/sqlite/LICENSE.md
DEPS_28 += src/paks/sqlite/package.json
DEPS_28 += src/paks/sqlite/README.md
DEPS_28 += src/paks/sqlite/sqlite.c
DEPS_28 += src/paks/sqlite/sqlite.me
DEPS_28 += src/paks/sqlite/sqlite3.c
DEPS_28 += src/paks/sqlite/sqlite3.h
DEPS_28 += src/paks/zlib
DEPS_28 += src/paks/zlib/LICENSE.md
DEPS_28 += src/paks/zlib/package.json
DEPS_28 += src/paks/zlib/README.md
DEPS_28 += src/paks/zlib/zlib.c
DEPS_28 += src/paks/zlib/zlib.h
DEPS_28 += src/paks/zlib/zlib.me

$(CONFIG)/paks: $(DEPS_28)
	( \
	cd src/paks; \
	mkdir -p "../../$(CONFIG)/paks/esp-angular/0.9.0" ; \
	cp esp-angular/esp-click.js ../../$(CONFIG)/paks/esp-angular/0.9.0/esp-click.js ; \
	cp esp-angular/esp-edit.js ../../$(CONFIG)/paks/esp-angular/0.9.0/esp-edit.js ; \
	cp esp-angular/esp-field-errors.js ../../$(CONFIG)/paks/esp-angular/0.9.0/esp-field-errors.js ; \
	cp esp-angular/esp-fixnum.js ../../$(CONFIG)/paks/esp-angular/0.9.0/esp-fixnum.js ; \
	cp esp-angular/esp-format.js ../../$(CONFIG)/paks/esp-angular/0.9.0/esp-format.js ; \
	cp esp-angular/esp-input-group.js ../../$(CONFIG)/paks/esp-angular/0.9.0/esp-input-group.js ; \
	cp esp-angular/esp-input.js ../../$(CONFIG)/paks/esp-angular/0.9.0/esp-input.js ; \
	cp esp-angular/esp-resource.js ../../$(CONFIG)/paks/esp-angular/0.9.0/esp-resource.js ; \
	cp esp-angular/esp-session.js ../../$(CONFIG)/paks/esp-angular/0.9.0/esp-session.js ; \
	cp esp-angular/esp-titlecase.js ../../$(CONFIG)/paks/esp-angular/0.9.0/esp-titlecase.js ; \
	cp esp-angular/esp.js ../../$(CONFIG)/paks/esp-angular/0.9.0/esp.js ; \
	cp esp-angular/package.json ../../$(CONFIG)/paks/esp-angular/0.9.0/package.json ; \
	mkdir -p "../../$(CONFIG)/paks/esp-angular-mvc/0.9.0" ; \
	cp esp-angular-mvc/package.json ../../$(CONFIG)/paks/esp-angular-mvc/0.9.0/package.json ; \
	mkdir -p "../../$(CONFIG)/paks/esp-angular-mvc/0.9.0/templates" ; \
	mkdir -p "../../$(CONFIG)/paks/esp-angular-mvc/0.9.0/templates/esp-angular-mvc" ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/appweb.conf ../../$(CONFIG)/paks/esp-angular-mvc/0.9.0/templates/esp-angular-mvc/appweb.conf ; \
	mkdir -p "../../$(CONFIG)/paks/esp-angular-mvc/0.9.0/templates/esp-angular-mvc/client" ; \
	mkdir -p "../../$(CONFIG)/paks/esp-angular-mvc/0.9.0/templates/esp-angular-mvc/client/app" ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/app/main.js ../../$(CONFIG)/paks/esp-angular-mvc/0.9.0/templates/esp-angular-mvc/client/app/main.js ; \
	mkdir -p "../../$(CONFIG)/paks/esp-angular-mvc/0.9.0/templates/esp-angular-mvc/client/assets" ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/assets/favicon.ico ../../$(CONFIG)/paks/esp-angular-mvc/0.9.0/templates/esp-angular-mvc/client/assets/favicon.ico ; \
	mkdir -p "../../$(CONFIG)/paks/esp-angular-mvc/0.9.0/templates/esp-angular-mvc/client/css" ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/css/all.css ../../$(CONFIG)/paks/esp-angular-mvc/0.9.0/templates/esp-angular-mvc/client/css/all.css ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/css/all.less ../../$(CONFIG)/paks/esp-angular-mvc/0.9.0/templates/esp-angular-mvc/client/css/all.less ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/css/app.less ../../$(CONFIG)/paks/esp-angular-mvc/0.9.0/templates/esp-angular-mvc/client/css/app.less ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/css/fix.css ../../$(CONFIG)/paks/esp-angular-mvc/0.9.0/templates/esp-angular-mvc/client/css/fix.css ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/css/theme.less ../../$(CONFIG)/paks/esp-angular-mvc/0.9.0/templates/esp-angular-mvc/client/css/theme.less ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/index.esp ../../$(CONFIG)/paks/esp-angular-mvc/0.9.0/templates/esp-angular-mvc/client/index.esp ; \
	mkdir -p "../../$(CONFIG)/paks/esp-angular-mvc/0.9.0/templates/esp-angular-mvc/client/pages" ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/pages/splash.html ../../$(CONFIG)/paks/esp-angular-mvc/0.9.0/templates/esp-angular-mvc/client/pages/splash.html ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/controller-singleton.c ../../$(CONFIG)/paks/esp-angular-mvc/0.9.0/templates/esp-angular-mvc/controller-singleton.c ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/controller.c ../../$(CONFIG)/paks/esp-angular-mvc/0.9.0/templates/esp-angular-mvc/controller.c ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/controller.js ../../$(CONFIG)/paks/esp-angular-mvc/0.9.0/templates/esp-angular-mvc/controller.js ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/edit.html ../../$(CONFIG)/paks/esp-angular-mvc/0.9.0/templates/esp-angular-mvc/edit.html ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/list.html ../../$(CONFIG)/paks/esp-angular-mvc/0.9.0/templates/esp-angular-mvc/list.html ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/model.js ../../$(CONFIG)/paks/esp-angular-mvc/0.9.0/templates/esp-angular-mvc/model.js ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/start.me ../../$(CONFIG)/paks/esp-angular-mvc/0.9.0/templates/esp-angular-mvc/start.me ; \
	mkdir -p "../../$(CONFIG)/paks/esp-html-mvc/0.9.0" ; \
	cp esp-html-mvc/package.json ../../$(CONFIG)/paks/esp-html-mvc/0.9.0/package.json ; \
	mkdir -p "../../$(CONFIG)/paks/esp-html-mvc/0.9.0/templates" ; \
	mkdir -p "../../$(CONFIG)/paks/esp-html-mvc/0.9.0/templates/esp-html-mvc" ; \
	cp esp-html-mvc/templates/esp-html-mvc/appweb.conf ../../$(CONFIG)/paks/esp-html-mvc/0.9.0/templates/esp-html-mvc/appweb.conf ; \
	mkdir -p "../../$(CONFIG)/paks/esp-html-mvc/0.9.0/templates/esp-html-mvc/client" ; \
	mkdir -p "../../$(CONFIG)/paks/esp-html-mvc/0.9.0/templates/esp-html-mvc/client/assets" ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/assets/favicon.ico ../../$(CONFIG)/paks/esp-html-mvc/0.9.0/templates/esp-html-mvc/client/assets/favicon.ico ; \
	mkdir -p "../../$(CONFIG)/paks/esp-html-mvc/0.9.0/templates/esp-html-mvc/client/css" ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/css/all.css ../../$(CONFIG)/paks/esp-html-mvc/0.9.0/templates/esp-html-mvc/client/css/all.css ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/css/all.less ../../$(CONFIG)/paks/esp-html-mvc/0.9.0/templates/esp-html-mvc/client/css/all.less ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/css/app.less ../../$(CONFIG)/paks/esp-html-mvc/0.9.0/templates/esp-html-mvc/client/css/app.less ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/css/theme.less ../../$(CONFIG)/paks/esp-html-mvc/0.9.0/templates/esp-html-mvc/client/css/theme.less ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/index.esp ../../$(CONFIG)/paks/esp-html-mvc/0.9.0/templates/esp-html-mvc/client/index.esp ; \
	mkdir -p "../../$(CONFIG)/paks/esp-html-mvc/0.9.0/templates/esp-html-mvc/client/layouts" ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/layouts/default.esp ../../$(CONFIG)/paks/esp-html-mvc/0.9.0/templates/esp-html-mvc/client/layouts/default.esp ; \
	cp esp-html-mvc/templates/esp-html-mvc/controller-singleton.c ../../$(CONFIG)/paks/esp-html-mvc/0.9.0/templates/esp-html-mvc/controller-singleton.c ; \
	cp esp-html-mvc/templates/esp-html-mvc/controller.c ../../$(CONFIG)/paks/esp-html-mvc/0.9.0/templates/esp-html-mvc/controller.c ; \
	cp esp-html-mvc/templates/esp-html-mvc/edit.esp ../../$(CONFIG)/paks/esp-html-mvc/0.9.0/templates/esp-html-mvc/edit.esp ; \
	cp esp-html-mvc/templates/esp-html-mvc/list.esp ../../$(CONFIG)/paks/esp-html-mvc/0.9.0/templates/esp-html-mvc/list.esp ; \
	cp esp-html-mvc/templates/esp-html-mvc/start.me ../../$(CONFIG)/paks/esp-html-mvc/0.9.0/templates/esp-html-mvc/start.me ; \
	mkdir -p "../../$(CONFIG)/paks/esp-legacy-mvc/0.9.0" ; \
	cp esp-legacy-mvc/package.json ../../$(CONFIG)/paks/esp-legacy-mvc/0.9.0/package.json ; \
	mkdir -p "../../$(CONFIG)/paks/esp-legacy-mvc/0.9.0/templates" ; \
	mkdir -p "../../$(CONFIG)/paks/esp-legacy-mvc/0.9.0/templates/esp-legacy-mvc" ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/appweb.conf ../../$(CONFIG)/paks/esp-legacy-mvc/0.9.0/templates/esp-legacy-mvc/appweb.conf ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/controller.c ../../$(CONFIG)/paks/esp-legacy-mvc/0.9.0/templates/esp-legacy-mvc/controller.c ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/edit.esp ../../$(CONFIG)/paks/esp-legacy-mvc/0.9.0/templates/esp-legacy-mvc/edit.esp ; \
	mkdir -p "../../$(CONFIG)/paks/esp-legacy-mvc/0.9.0/templates/esp-legacy-mvc/layouts" ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/layouts/default.esp ../../$(CONFIG)/paks/esp-legacy-mvc/0.9.0/templates/esp-legacy-mvc/layouts/default.esp ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/list.esp ../../$(CONFIG)/paks/esp-legacy-mvc/0.9.0/templates/esp-legacy-mvc/list.esp ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/migration.c ../../$(CONFIG)/paks/esp-legacy-mvc/0.9.0/templates/esp-legacy-mvc/migration.c ; \
	mkdir -p "../../$(CONFIG)/paks/esp-legacy-mvc/0.9.0/templates/esp-legacy-mvc/src" ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/src/app.c ../../$(CONFIG)/paks/esp-legacy-mvc/0.9.0/templates/esp-legacy-mvc/src/app.c ; \
	mkdir -p "../../$(CONFIG)/paks/esp-legacy-mvc/0.9.0/templates/esp-legacy-mvc/static" ; \
	mkdir -p "../../$(CONFIG)/paks/esp-legacy-mvc/0.9.0/templates/esp-legacy-mvc/static/css" ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/css/all.css ../../$(CONFIG)/paks/esp-legacy-mvc/0.9.0/templates/esp-legacy-mvc/static/css/all.css ; \
	mkdir -p "../../$(CONFIG)/paks/esp-legacy-mvc/0.9.0/templates/esp-legacy-mvc/static/images" ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/images/banner.jpg ../../$(CONFIG)/paks/esp-legacy-mvc/0.9.0/templates/esp-legacy-mvc/static/images/banner.jpg ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/images/favicon.ico ../../$(CONFIG)/paks/esp-legacy-mvc/0.9.0/templates/esp-legacy-mvc/static/images/favicon.ico ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/images/splash.jpg ../../$(CONFIG)/paks/esp-legacy-mvc/0.9.0/templates/esp-legacy-mvc/static/images/splash.jpg ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/index.esp ../../$(CONFIG)/paks/esp-legacy-mvc/0.9.0/templates/esp-legacy-mvc/static/index.esp ; \
	mkdir -p "../../$(CONFIG)/paks/esp-legacy-mvc/0.9.0/templates/esp-legacy-mvc/static/js" ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/js/jquery.esp.js ../../$(CONFIG)/paks/esp-legacy-mvc/0.9.0/templates/esp-legacy-mvc/static/js/jquery.esp.js ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/js/jquery.js ../../$(CONFIG)/paks/esp-legacy-mvc/0.9.0/templates/esp-legacy-mvc/static/js/jquery.js ; \
	mkdir -p "../../$(CONFIG)/paks/esp-server/0.9.0" ; \
	cp esp-server/package.json ../../$(CONFIG)/paks/esp-server/0.9.0/package.json ; \
	mkdir -p "../../$(CONFIG)/paks/esp-server/0.9.0/templates" ; \
	mkdir -p "../../$(CONFIG)/paks/esp-server/0.9.0/templates/esp-server" ; \
	cp esp-server/templates/esp-server/appweb.conf ../../$(CONFIG)/paks/esp-server/0.9.0/templates/esp-server/appweb.conf ; \
	cp esp-server/templates/esp-server/controller.c ../../$(CONFIG)/paks/esp-server/0.9.0/templates/esp-server/controller.c ; \
	cp esp-server/templates/esp-server/migration.c ../../$(CONFIG)/paks/esp-server/0.9.0/templates/esp-server/migration.c ; \
	mkdir -p "../../$(CONFIG)/paks/esp-server/0.9.0/templates/esp-server/src" ; \
	cp esp-server/templates/esp-server/src/app.c ../../$(CONFIG)/paks/esp-server/0.9.0/templates/esp-server/src/app.c ; \
	)
endif

#
#   est.h
#
$(CONFIG)/inc/est.h: $(DEPS_29)
	@echo '      [Copy] $(CONFIG)/inc/est.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/est/est.h $(CONFIG)/inc/est.h

#
#   estLib.o
#
DEPS_30 += $(CONFIG)/inc/me.h
DEPS_30 += $(CONFIG)/inc/est.h
DEPS_30 += $(CONFIG)/inc/osdep.h

$(CONFIG)/obj/estLib.o: \
    src/paks/est/estLib.c $(DEPS_30)
	@echo '   [Compile] $(CONFIG)/obj/estLib.o'
	 -c -o $(CONFIG)/obj/estLib.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/est/estLib.c

ifeq ($(ME_EXT_EST),1)
#
#   libest
#
DEPS_31 += $(CONFIG)/inc/est.h
DEPS_31 += $(CONFIG)/inc/me.h
DEPS_31 += $(CONFIG)/inc/osdep.h
DEPS_31 += $(CONFIG)/obj/estLib.o

$(CONFIG)/bin/libest.a: $(DEPS_31)
	@echo '      [Link] $(CONFIG)/bin/libest.a'
	 -cr $(CONFIG)/bin/libest.a "$(CONFIG)/obj/estLib.o"
endif

#
#   ca-crt
#
DEPS_32 += src/paks/est/ca.crt

$(CONFIG)/bin/ca.crt: $(DEPS_32)
	@echo '      [Copy] $(CONFIG)/bin/ca.crt'
	mkdir -p "$(CONFIG)/bin"
	cp src/paks/est/ca.crt $(CONFIG)/bin/ca.crt

#
#   mprSsl.o
#
DEPS_33 += $(CONFIG)/inc/me.h
DEPS_33 += $(CONFIG)/inc/mpr.h
DEPS_33 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/mprSsl.o: \
    src/paks/mpr/mprSsl.c $(DEPS_33)
	@echo '   [Compile] $(CONFIG)/obj/mprSsl.o'
	 -c -o $(CONFIG)/obj/mprSsl.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/mpr/mprSsl.c

#
#   libmprssl
#
DEPS_34 += $(CONFIG)/inc/mpr.h
DEPS_34 += $(CONFIG)/inc/me.h
DEPS_34 += $(CONFIG)/inc/osdep.h
DEPS_34 += $(CONFIG)/obj/mprLib.o
DEPS_34 += $(CONFIG)/bin/libmpr.a
DEPS_34 += $(CONFIG)/inc/est.h
DEPS_34 += $(CONFIG)/obj/estLib.o
ifeq ($(ME_EXT_EST),1)
    DEPS_34 += $(CONFIG)/bin/libest.a
endif
DEPS_34 += $(CONFIG)/obj/mprSsl.o

$(CONFIG)/bin/libmprssl.a: $(DEPS_34)
	@echo '      [Link] $(CONFIG)/bin/libmprssl.a'
	 -cr $(CONFIG)/bin/libmprssl.a "$(CONFIG)/obj/mprSsl.o"

#
#   http.o
#
DEPS_35 += $(CONFIG)/inc/me.h
DEPS_35 += $(CONFIG)/inc/http.h

$(CONFIG)/obj/http.o: \
    src/paks/http/http.c $(DEPS_35)
	@echo '   [Compile] $(CONFIG)/obj/http.o'
	 -c -o $(CONFIG)/obj/http.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/http/http.c

#
#   httpcmd
#
DEPS_36 += $(CONFIG)/inc/mpr.h
DEPS_36 += $(CONFIG)/inc/me.h
DEPS_36 += $(CONFIG)/inc/osdep.h
DEPS_36 += $(CONFIG)/obj/mprLib.o
DEPS_36 += $(CONFIG)/bin/libmpr.a
DEPS_36 += $(CONFIG)/inc/pcre.h
DEPS_36 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_EXT_PCRE),1)
    DEPS_36 += $(CONFIG)/bin/libpcre.a
endif
DEPS_36 += $(CONFIG)/inc/http.h
DEPS_36 += $(CONFIG)/obj/httpLib.o
DEPS_36 += $(CONFIG)/bin/libhttp.a
DEPS_36 += $(CONFIG)/inc/est.h
DEPS_36 += $(CONFIG)/obj/estLib.o
ifeq ($(ME_EXT_EST),1)
    DEPS_36 += $(CONFIG)/bin/libest.a
endif
DEPS_36 += $(CONFIG)/obj/mprSsl.o
DEPS_36 += $(CONFIG)/bin/libmprssl.a
DEPS_36 += $(CONFIG)/obj/http.o

LIBS_36 += -lhttp
LIBS_36 += -lmpr
ifeq ($(ME_EXT_PCRE),1)
    LIBS_36 += -lpcre
endif
LIBS_36 += -lmprssl
ifeq ($(ME_EXT_EST),1)
    LIBS_36 += -lest
endif

$(CONFIG)/bin/http.out: $(DEPS_36)
	@echo '      [Link] $(CONFIG)/bin/http.out'
	 -o $(CONFIG)/bin/http.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/http.o" $(LIBPATHS_36) $(LIBS_36) $(LIBS_36) $(LIBS) -Wl,-r 

#
#   manager.o
#
DEPS_37 += $(CONFIG)/inc/me.h
DEPS_37 += $(CONFIG)/inc/mpr.h

$(CONFIG)/obj/manager.o: \
    src/paks/mpr/manager.c $(DEPS_37)
	@echo '   [Compile] $(CONFIG)/obj/manager.o'
	 -c -o $(CONFIG)/obj/manager.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/mpr/manager.c

#
#   manager
#
DEPS_38 += $(CONFIG)/inc/mpr.h
DEPS_38 += $(CONFIG)/inc/me.h
DEPS_38 += $(CONFIG)/inc/osdep.h
DEPS_38 += $(CONFIG)/obj/mprLib.o
DEPS_38 += $(CONFIG)/bin/libmpr.a
DEPS_38 += $(CONFIG)/obj/manager.o

LIBS_38 += -lmpr

$(CONFIG)/bin/appman.out: $(DEPS_38)
	@echo '      [Link] $(CONFIG)/bin/appman.out'
	 -o $(CONFIG)/bin/appman.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/manager.o" $(LIBPATHS_38) $(LIBS_38) $(LIBS_38) $(LIBS) -Wl,-r 

#
#   zlib.h
#
$(CONFIG)/inc/zlib.h: $(DEPS_39)
	@echo '      [Copy] $(CONFIG)/inc/zlib.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/zlib/zlib.h $(CONFIG)/inc/zlib.h

#
#   zlib.o
#
DEPS_40 += $(CONFIG)/inc/me.h
DEPS_40 += $(CONFIG)/inc/zlib.h

$(CONFIG)/obj/zlib.o: \
    src/paks/zlib/zlib.c $(DEPS_40)
	@echo '   [Compile] $(CONFIG)/obj/zlib.o'
	 -c -o $(CONFIG)/obj/zlib.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/zlib/zlib.c

ifeq ($(ME_EXT_ZLIB),1)
#
#   libzlib
#
DEPS_41 += $(CONFIG)/inc/zlib.h
DEPS_41 += $(CONFIG)/inc/me.h
DEPS_41 += $(CONFIG)/obj/zlib.o

$(CONFIG)/bin/libzlib.a: $(DEPS_41)
	@echo '      [Link] $(CONFIG)/bin/libzlib.a'
	 -cr $(CONFIG)/bin/libzlib.a "$(CONFIG)/obj/zlib.o"
endif

#
#   slink.c
#
src/slink.c: $(DEPS_42)
	( \
	cd src; \
	[ ! -f slink.c ] && cp slink.empty slink.c ; true ; \
	)

#
#   slink.o
#
DEPS_43 += $(CONFIG)/inc/me.h
DEPS_43 += $(CONFIG)/inc/esp.h

$(CONFIG)/obj/slink.o: \
    src/slink.c $(DEPS_43)
	@echo '   [Compile] $(CONFIG)/obj/slink.o'
	 -c -o $(CONFIG)/obj/slink.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/slink.c

#
#   libslink
#
DEPS_44 += src/slink.c
DEPS_44 += $(CONFIG)/inc/mpr.h
DEPS_44 += $(CONFIG)/inc/me.h
DEPS_44 += $(CONFIG)/inc/osdep.h
DEPS_44 += $(CONFIG)/obj/mprLib.o
DEPS_44 += $(CONFIG)/bin/libmpr.a
DEPS_44 += $(CONFIG)/inc/pcre.h
DEPS_44 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_EXT_PCRE),1)
    DEPS_44 += $(CONFIG)/bin/libpcre.a
endif
DEPS_44 += $(CONFIG)/inc/http.h
DEPS_44 += $(CONFIG)/obj/httpLib.o
DEPS_44 += $(CONFIG)/bin/libhttp.a
DEPS_44 += $(CONFIG)/inc/appweb.h
DEPS_44 += $(CONFIG)/inc/customize.h
DEPS_44 += $(CONFIG)/obj/config.o
DEPS_44 += $(CONFIG)/obj/convenience.o
DEPS_44 += $(CONFIG)/obj/dirHandler.o
DEPS_44 += $(CONFIG)/obj/fileHandler.o
DEPS_44 += $(CONFIG)/obj/log.o
DEPS_44 += $(CONFIG)/obj/server.o
DEPS_44 += $(CONFIG)/bin/libappweb.a
DEPS_44 += $(CONFIG)/inc/esp.h
DEPS_44 += $(CONFIG)/obj/espLib.o
ifeq ($(ME_EXT_ESP),1)
    DEPS_44 += $(CONFIG)/bin/libmod_esp.a
endif
DEPS_44 += $(CONFIG)/obj/slink.o

$(CONFIG)/bin/libslink.a: $(DEPS_44)
	@echo '      [Link] $(CONFIG)/bin/libslink.a'
	 -cr $(CONFIG)/bin/libslink.a "$(CONFIG)/obj/slink.o"

#
#   sslModule.o
#
DEPS_45 += $(CONFIG)/inc/me.h
DEPS_45 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/sslModule.o: \
    src/modules/sslModule.c $(DEPS_45)
	@echo '   [Compile] $(CONFIG)/obj/sslModule.o'
	 -c -o $(CONFIG)/obj/sslModule.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/modules/sslModule.c

ifeq ($(ME_EXT_SSL),1)
#
#   libmod_ssl
#
DEPS_46 += $(CONFIG)/inc/mpr.h
DEPS_46 += $(CONFIG)/inc/me.h
DEPS_46 += $(CONFIG)/inc/osdep.h
DEPS_46 += $(CONFIG)/obj/mprLib.o
DEPS_46 += $(CONFIG)/bin/libmpr.a
DEPS_46 += $(CONFIG)/inc/pcre.h
DEPS_46 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_EXT_PCRE),1)
    DEPS_46 += $(CONFIG)/bin/libpcre.a
endif
DEPS_46 += $(CONFIG)/inc/http.h
DEPS_46 += $(CONFIG)/obj/httpLib.o
DEPS_46 += $(CONFIG)/bin/libhttp.a
DEPS_46 += $(CONFIG)/inc/appweb.h
DEPS_46 += $(CONFIG)/inc/customize.h
DEPS_46 += $(CONFIG)/obj/config.o
DEPS_46 += $(CONFIG)/obj/convenience.o
DEPS_46 += $(CONFIG)/obj/dirHandler.o
DEPS_46 += $(CONFIG)/obj/fileHandler.o
DEPS_46 += $(CONFIG)/obj/log.o
DEPS_46 += $(CONFIG)/obj/server.o
DEPS_46 += $(CONFIG)/bin/libappweb.a
DEPS_46 += $(CONFIG)/inc/est.h
DEPS_46 += $(CONFIG)/obj/estLib.o
ifeq ($(ME_EXT_EST),1)
    DEPS_46 += $(CONFIG)/bin/libest.a
endif
DEPS_46 += $(CONFIG)/obj/mprSsl.o
DEPS_46 += $(CONFIG)/bin/libmprssl.a
DEPS_46 += $(CONFIG)/obj/sslModule.o

$(CONFIG)/bin/libmod_ssl.a: $(DEPS_46)
	@echo '      [Link] $(CONFIG)/bin/libmod_ssl.a'
	 -cr $(CONFIG)/bin/libmod_ssl.a "$(CONFIG)/obj/sslModule.o"
endif

#
#   authpass.o
#
DEPS_47 += $(CONFIG)/inc/me.h
DEPS_47 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/authpass.o: \
    src/utils/authpass.c $(DEPS_47)
	@echo '   [Compile] $(CONFIG)/obj/authpass.o'
	 -c -o $(CONFIG)/obj/authpass.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/utils/authpass.c

#
#   authpass
#
DEPS_48 += $(CONFIG)/inc/mpr.h
DEPS_48 += $(CONFIG)/inc/me.h
DEPS_48 += $(CONFIG)/inc/osdep.h
DEPS_48 += $(CONFIG)/obj/mprLib.o
DEPS_48 += $(CONFIG)/bin/libmpr.a
DEPS_48 += $(CONFIG)/inc/pcre.h
DEPS_48 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_EXT_PCRE),1)
    DEPS_48 += $(CONFIG)/bin/libpcre.a
endif
DEPS_48 += $(CONFIG)/inc/http.h
DEPS_48 += $(CONFIG)/obj/httpLib.o
DEPS_48 += $(CONFIG)/bin/libhttp.a
DEPS_48 += $(CONFIG)/inc/appweb.h
DEPS_48 += $(CONFIG)/inc/customize.h
DEPS_48 += $(CONFIG)/obj/config.o
DEPS_48 += $(CONFIG)/obj/convenience.o
DEPS_48 += $(CONFIG)/obj/dirHandler.o
DEPS_48 += $(CONFIG)/obj/fileHandler.o
DEPS_48 += $(CONFIG)/obj/log.o
DEPS_48 += $(CONFIG)/obj/server.o
DEPS_48 += $(CONFIG)/bin/libappweb.a
DEPS_48 += $(CONFIG)/obj/authpass.o

LIBS_48 += -lappweb
LIBS_48 += -lhttp
LIBS_48 += -lmpr
ifeq ($(ME_EXT_PCRE),1)
    LIBS_48 += -lpcre
endif

$(CONFIG)/bin/authpass.out: $(DEPS_48)
	@echo '      [Link] $(CONFIG)/bin/authpass.out'
	 -o $(CONFIG)/bin/authpass.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/authpass.o" $(LIBPATHS_48) $(LIBS_48) $(LIBS_48) $(LIBS) -Wl,-r 

#
#   appweb.o
#
DEPS_49 += $(CONFIG)/inc/me.h
DEPS_49 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/appweb.o: \
    src/server/appweb.c $(DEPS_49)
	@echo '   [Compile] $(CONFIG)/obj/appweb.o'
	 -c -o $(CONFIG)/obj/appweb.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/server/appweb.c

#
#   appweb
#
DEPS_50 += $(CONFIG)/inc/mpr.h
DEPS_50 += $(CONFIG)/inc/me.h
DEPS_50 += $(CONFIG)/inc/osdep.h
DEPS_50 += $(CONFIG)/obj/mprLib.o
DEPS_50 += $(CONFIG)/bin/libmpr.a
DEPS_50 += $(CONFIG)/inc/pcre.h
DEPS_50 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_EXT_PCRE),1)
    DEPS_50 += $(CONFIG)/bin/libpcre.a
endif
DEPS_50 += $(CONFIG)/inc/http.h
DEPS_50 += $(CONFIG)/obj/httpLib.o
DEPS_50 += $(CONFIG)/bin/libhttp.a
DEPS_50 += $(CONFIG)/inc/appweb.h
DEPS_50 += $(CONFIG)/inc/customize.h
DEPS_50 += $(CONFIG)/obj/config.o
DEPS_50 += $(CONFIG)/obj/convenience.o
DEPS_50 += $(CONFIG)/obj/dirHandler.o
DEPS_50 += $(CONFIG)/obj/fileHandler.o
DEPS_50 += $(CONFIG)/obj/log.o
DEPS_50 += $(CONFIG)/obj/server.o
DEPS_50 += $(CONFIG)/bin/libappweb.a
DEPS_50 += src/slink.c
DEPS_50 += $(CONFIG)/inc/esp.h
DEPS_50 += $(CONFIG)/obj/espLib.o
ifeq ($(ME_EXT_ESP),1)
    DEPS_50 += $(CONFIG)/bin/libmod_esp.a
endif
DEPS_50 += $(CONFIG)/obj/slink.o
DEPS_50 += $(CONFIG)/bin/libslink.a
DEPS_50 += $(CONFIG)/inc/est.h
DEPS_50 += $(CONFIG)/obj/estLib.o
ifeq ($(ME_EXT_EST),1)
    DEPS_50 += $(CONFIG)/bin/libest.a
endif
DEPS_50 += $(CONFIG)/obj/mprSsl.o
DEPS_50 += $(CONFIG)/bin/libmprssl.a
DEPS_50 += $(CONFIG)/obj/sslModule.o
ifeq ($(ME_EXT_SSL),1)
    DEPS_50 += $(CONFIG)/bin/libmod_ssl.a
endif
DEPS_50 += $(CONFIG)/obj/appweb.o

LIBS_50 += -lappweb
LIBS_50 += -lhttp
LIBS_50 += -lmpr
ifeq ($(ME_EXT_PCRE),1)
    LIBS_50 += -lpcre
endif
LIBS_50 += -lslink
ifeq ($(ME_EXT_ESP),1)
    LIBS_50 += -lmod_esp
endif
ifeq ($(ME_EXT_SSL),1)
    LIBS_50 += -lmod_ssl
endif
LIBS_50 += -lmprssl
ifeq ($(ME_EXT_EST),1)
    LIBS_50 += -lest
endif

$(CONFIG)/bin/appweb.out: $(DEPS_50)
	@echo '      [Link] $(CONFIG)/bin/appweb.out'
	 -o $(CONFIG)/bin/appweb.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/appweb.o" $(LIBPATHS_50) $(LIBS_50) $(LIBS_50) $(LIBS) -Wl,-r 

#
#   server-cache
#
src/server/cache: $(DEPS_51)
	( \
	cd src/server; \
	mkdir -p cache ; \
	)

#
#   testAppweb.h
#
$(CONFIG)/inc/testAppweb.h: $(DEPS_52)
	@echo '      [Copy] $(CONFIG)/inc/testAppweb.h'
	mkdir -p "$(CONFIG)/inc"
	cp test/src/testAppweb.h $(CONFIG)/inc/testAppweb.h

#
#   testAppweb.o
#
DEPS_53 += $(CONFIG)/inc/me.h
DEPS_53 += $(CONFIG)/inc/testAppweb.h
DEPS_53 += $(CONFIG)/inc/mpr.h
DEPS_53 += $(CONFIG)/inc/http.h

$(CONFIG)/obj/testAppweb.o: \
    test/src/testAppweb.c $(DEPS_53)
	@echo '   [Compile] $(CONFIG)/obj/testAppweb.o'
	 -c -o $(CONFIG)/obj/testAppweb.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" test/src/testAppweb.c

#
#   testHttp.o
#
DEPS_54 += $(CONFIG)/inc/me.h
DEPS_54 += $(CONFIG)/inc/testAppweb.h

$(CONFIG)/obj/testHttp.o: \
    test/src/testHttp.c $(DEPS_54)
	@echo '   [Compile] $(CONFIG)/obj/testHttp.o'
	 -c -o $(CONFIG)/obj/testHttp.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" test/src/testHttp.c

#
#   testAppweb
#
DEPS_55 += $(CONFIG)/inc/mpr.h
DEPS_55 += $(CONFIG)/inc/me.h
DEPS_55 += $(CONFIG)/inc/osdep.h
DEPS_55 += $(CONFIG)/obj/mprLib.o
DEPS_55 += $(CONFIG)/bin/libmpr.a
DEPS_55 += $(CONFIG)/inc/pcre.h
DEPS_55 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_EXT_PCRE),1)
    DEPS_55 += $(CONFIG)/bin/libpcre.a
endif
DEPS_55 += $(CONFIG)/inc/http.h
DEPS_55 += $(CONFIG)/obj/httpLib.o
DEPS_55 += $(CONFIG)/bin/libhttp.a
DEPS_55 += $(CONFIG)/inc/appweb.h
DEPS_55 += $(CONFIG)/inc/customize.h
DEPS_55 += $(CONFIG)/obj/config.o
DEPS_55 += $(CONFIG)/obj/convenience.o
DEPS_55 += $(CONFIG)/obj/dirHandler.o
DEPS_55 += $(CONFIG)/obj/fileHandler.o
DEPS_55 += $(CONFIG)/obj/log.o
DEPS_55 += $(CONFIG)/obj/server.o
DEPS_55 += $(CONFIG)/bin/libappweb.a
DEPS_55 += $(CONFIG)/inc/testAppweb.h
DEPS_55 += $(CONFIG)/obj/testAppweb.o
DEPS_55 += $(CONFIG)/obj/testHttp.o

LIBS_55 += -lappweb
LIBS_55 += -lhttp
LIBS_55 += -lmpr
ifeq ($(ME_EXT_PCRE),1)
    LIBS_55 += -lpcre
endif

$(CONFIG)/bin/testAppweb.out: $(DEPS_55)
	@echo '      [Link] $(CONFIG)/bin/testAppweb.out'
	 -o $(CONFIG)/bin/testAppweb.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/testAppweb.o" "$(CONFIG)/obj/testHttp.o" $(LIBPATHS_55) $(LIBS_55) $(LIBS_55) $(LIBS) -Wl,-r 

#
#   installBinary
#
installBinary: $(DEPS_56)

#
#   install
#
DEPS_57 += installBinary

install: $(DEPS_57)


#
#   uninstall
#
DEPS_58 += build

uninstall: $(DEPS_58)
	( \
	cd package; \
	rm -f "$(ME_VAPP_PREFIX)/appweb.conf" ; \
	rm -f "$(ME_VAPP_PREFIX)/esp.conf" ; \
	rm -f "$(ME_VAPP_PREFIX)/mine.types" ; \
	rm -f "$(ME_VAPP_PREFIX)/install.conf" ; \
	rm -fr "$(ME_VAPP_PREFIX)/inc/appweb" ; \
	)

#
#   genslink
#
genslink: $(DEPS_59)
	( \
	cd src; \
	esp --static --genlink slink.c compile ; \
	)


#
#   run
#
DEPS_60 += compile

run: $(DEPS_60)
	( \
	cd src/server; \
	sudo ../../$(CONFIG)/bin/appweb -v ; \
	)

