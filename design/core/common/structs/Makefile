MAKEFILE_INCLUDE = ../../../../Makefile.include
include $(MAKEFILE_INCLUDE)

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
RTL_FILES = mac_avl_structures.sv
STRUCTURE_FILES =

all: work compile

# Create work library
work:
ifeq ($(OS),Windows_NT)
	@if not exist $(WORK_DIR) (vlib $(WORK_DIR))
else
	@test -d $(WORK_DIR) || vlib $(WORK_DIR)
endif

# Compile with library mapping
compile: work
	@echo "Compiling for library: $(LIB_NAME)"
	$(VLOG_CMD) $(STRUCTURE_FILES) $(RTL_FILES) $(TB_FILES) $(INCDIR)

clean:
	@echo "Cleaning $(LIB_NAME)..."
	@$(CLEAN_CMD)

print_libdir:
	@echo $(WORK_DIR)

.PHONY: all compile clean work print_libdir
