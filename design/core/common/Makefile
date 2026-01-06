MAKEFILE_INCLUDE = ../../../Makefile.include
include $(MAKEFILE_INCLUDE)

# Subdirectories to build
SUBDIRS = structs param_ip

.PHONY: all compile clean $(SUBDIRS) print_libdir

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


# Collect library directories from subdirectories
print_libdir:
ifeq ($(OS),Windows_NT)
	@for %%d in ($(SUBDIRS)) do @make -C "%%d" print_libdir
else
	@for dir in $(SUBDIRS); do \
	    make -C "$$dir" print_libdir; \
	done
endif
