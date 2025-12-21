MAKEFILE_INCLUDE = ../../Makefile.include
include $(MAKEFILE_INCLUDE)

# Compute library name from current directory path
# Remove leading ./ or .\, then replace / or \ with _
ifeq ($(OS),Windows_NT)
    # Windows: convert path like .\sim\common to sim_common
    LIB_NAME = $(subst \,_,$(patsubst .\%,%,$(CURDIR)))
else
    # Unix: convert path like ./sim/common to sim_common
    LIB_NAME = $(subst /,_,$(patsubst ./%,%,$(CURDIR)))
endif

# Work directory for this library
WORK_DIR = $(CURDIR)/work

# List your source files for this directory
TB_FILES = iclk.v irst.v
RTL_FILES =

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
	$(VLOG_CMD) -work $(WORK_DIR)
#	@$(MAKE) -C ../core compile

clean:
	@echo "Cleaning $(LIB_NAME)..."
	@$(CLEAN_CMD)

.PHONY: all compile clean work
