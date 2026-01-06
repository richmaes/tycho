MAKEFILE_INCLUDE = ../../../../Makefile.include
include $(MAKEFILE_INCLUDE)

# Compute library name from current directory path
ifeq ($(OS),Windows_NT)
    LIB_NAME = $(subst \,_,$(patsubst .\%,%,$(CURDIR)))
else
    LIB_NAME = $(subst /,_,$(patsubst ./%,%,$(CURDIR)))
endif

# Work directory for this library
# WORK_DIR = $(CURDIR)/work

# List your source files for this directory
TB_FILES =
RTL_FILES = scfifo_param.sv altram2port_param.sv
STRUCTURE_FILES =

all: compile

# Compile with library mapping
compile:
	@echo "Compiling for library: $(LIB_NAME)"
	$(VLOG_CMD) $(STRUCTURE_FILES) $(RTL_FILES) $(TB_FILES) $(INCDIR)

clean:
	@echo "Cleaning $(LIB_NAME)..."
	@$(CLEAN_CMD)

print_libdir:
	@echo $(WORK_DIR)

.PHONY: all compile clean print_libdir
