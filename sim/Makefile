MAKEFILE_INCLUDE = ../Makefile.include
include $(MAKEFILE_INCLUDE)

# Subdirectories to build
SUBDIRS = ../ common

.PHONY: all compile clean work $(SUBDIRS) collect_libdirs

all: compile

# Build all subdirectories
compile: $(SUBDIRS)

$(SUBDIRS):
	@$(MAKE) -C $@ compile

clean:
ifeq ($(OS),Windows_NT)
	@for %%d in ($(SUBDIRS)) do make -C "%%d" clean
else
	@for dir in $(SUBDIRS); do \
	    make -C "$$dir" clean; \
	done
endif

work:
ifeq ($(OS),Windows_NT)
	@for %%d in ($(SUBDIRS)) do make -C "%%d" work
else
	@for dir in $(SUBDIRS); do \
	    make -C "$$dir" work; \
	done
endif

# Collect library directories from all subdirectories
collect_libdirs:
ifeq ($(OS),Windows_NT)
	@for %%d in ($(SUBDIRS)) do @make -C "%%d" print_libdir
else
	@for dir in $(SUBDIRS); do \
	    make -C "$$dir" print_libdir; \
	done
endif
