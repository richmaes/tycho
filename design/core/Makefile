MAKEFILE_INCLUDE = ../../Makefile.include
include $(MAKEFILE_INCLUDE)

# Subdirectories to build
SUBDIRS = common

# Compute library name from current directory path
ifeq ($(OS),Windows_NT)
    LIB_NAME = $(subst \,_,$(patsubst .\%,%,$(CURDIR)))
else
    LIB_NAME = $(subst /,_,$(patsubst ./%,%,$(CURDIR)))
endif

# Work directory for this library
WORK_DIR = $(CURDIR)/work

# List your source files for this directory
TB_FILES =
RTL_FILES = tych_core.sv
STRUCTURE_FILES =

all: work compile

# Create work library
work:
ifeq ($(OS),Windows_NT)
	@if not exist $(WORK_DIR) (vlib $(WORK_DIR))
else
	@test -d $(WORK_DIR) || vlib $(WORK_DIR)
endif

$(SUBDIRS):
	@echo "Building $@..."
	make -C $@ compile

# Compile with library mapping
compile: work $(SUBDIRS)
	@echo "Compiling for library: $(LIB_NAME)"
	$(VLOG_CMD) -work $(WORK_DIR) $(STRUCTURE_FILES) $(RTL_FILES) $(TB_FILES) $(INCDIR)

clean:
	@echo "Cleaning $(LIB_NAME)..."
	@$(CLEAN_CMD)

print_libdir:
	@echo $(WORK_DIR)
ifeq ($(OS),Windows_NT)
	@for %%d in ($(SUBDIRS)) do @make -C "%%d" print_libdir
else
	@for dir in $(SUBDIRS); do \
	    make -C "$$dir" print_libdir; \
	done
endif

.PHONY: all compile clean work print_libdir $(SUBDIRS)
