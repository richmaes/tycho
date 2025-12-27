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

# List your source files for this directory
TB_FILES = iclk.v irst.v
RTL_FILES =

all: compile

# Compile with library mapping
compile:
	@echo "Compiling for library: $(LIB_NAME)"
	$(VLOG_CMD)  $(STRUCTURE_FILES) $(RTL_FILES) $(TB_FILES) $(INCDIR)

clean:
	@echo "Cleaning $(LIB_NAME)..."
	@$(CLEAN_CMD)

print_libdir:
	@echo $(WORK_DIR)

.PHONY: all compile clean work print_libdir
