WORKSPACE_ROOT = ../..
MAKEFILE_INCLUDE = ../../Makefile.include
include $(MAKEFILE_INCLUDE)


#LIBS = altera_mf altera_lnsim
LIBS =
# LIB_INC collects -L flags for the simulator. Compute at parse-time using make's
# foreach so the flags are available to recipe commands (not generated inside a shell loop).
# By default this produces: -L altera_mf -L altera_lnsim
LIB_INC := $(foreach L,$(LIBS),-L $(L))

# Create work library
work:
ifeq ($(OS),Windows_NT)
	@if not exist work (vlib work)
else
	@test -d work || vlib work
endif

# List your SystemVerilog source files for this testbench and design
# Include common support files (clock/reset) if needed
TB_FILES = ../core/tb_tych_core.sv
STRUCTURE_FILES = $(DESIGN_DIR)/core/common/structs/mac_avl_structures.sv
RTL_FILES =

# Specify the top-level module for simulation
TOP_MODULE = tb_tych_core
TOP_OPT_MODULE = $(TOP_MODULE)_opt

all: work compile simulate

# Append the computed LIB_INC flags to the VLOG command defined in Makefile.include
# This adds the -L <lib> flags to the simulator compile command
# VLOG_CMD += $(LIB_INC)
VSIM_CMD += $(LIB_INC)
.PHONY: tb_tych_core clean work vmap_all

# Create vmap mappings for all libraries listed in LIBS
# This ensures ModelSim/Questa knows where each library directory is
vmap_all:
	@echo "Creating library mappings (vmap) $(LIBS)"
ifeq ($(OS),Windows_NT)
	@for %%L in ($(LIBS)) do vmap  %%L "$(LIB_PATH)$(PATH_SEP)%%L"
else
	@for lib in $(LIBS); do vmap $$lib "$(LIB_PATH)$(PATH_SEP)$$lib"; done
endif
	@echo "Library mappings created."

# Override compile target to ensure work directory exists and the
# vmap mappings are created before compilation
compile: work
	@echo $(TEST_MSG)
	@$(MAKE) -C ../ compile
	$(VLOG_CMD) $(STRUCTURE_FILES) $(RTL_FILES) $(TB_FILES) $(INCDIR)
#	@echo "Creating library mappings (vmap) for compiled libraries..."
#ifeq ($(OS),Windows_NT)
#	@for /f "delims=" %%p in ('make -C .. collect_libdirs 2^>nul ^| findstr /r "^[A-Z]:"') do @if exist "%%p" vmap work_%%~nxp "%%p"
#	@for /f "delims=" %%p in ('make -C ../../design/core print_libdir 2^>nul ^| findstr /r "^[A-Z]:"') do @if exist "%%p" vmap work_%%~nxp "%%p"
#else
#	@make -C .. collect_libdirs 2>/dev/null | grep "^/" | while read path; do [ -d "$$path" ] && vmap "work_$$(basename $$path)" "$$path"; done
#	@make -C ../../design/core print_libdir 2>/dev/null | grep "^/" | while read path; do [ -d "$$path" ] && vmap "work_$$(basename $$path)" "$$path"; done
#endif

# Main target: using the top-level module as the target name
top_tb: TEST_MSG = "Starting simulation for $(TOP_MODULE)"
top_tb: simulate

# Clean target that calls parent directory's clean
clean:
	@$(CLEAN_CMD)
	@$(MAKE) -C ../ clean
