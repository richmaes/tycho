MAKEFILE_INCLUDE = ../Makefile.include
include $(MAKEFILE_INCLUDE)

# Subdirectories to build
SUBDIRS = core

.PHONY: all compile clean work $(SUBDIRS)

all: compile

# Build all subdirectories
compile: $(SUBDIRS)

$(SUBDIRS):
	@echo "Building $@..."
	make -C $@ compile

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
