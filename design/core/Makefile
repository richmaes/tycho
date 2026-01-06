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
RTL_FILES = tych_core.sv \
			./tych_ing/tych_ing_frm_buf.sv \
			./tych_ing/tych_ing_m2c_avl.sv \
            ./tych_ing/tych_ing.sv \
			./tych_egr/tych_egr.sv \
			./tych_fwd/tych_fwd.sv
STRUCTURE_FILES =

all: compile

$(SUBDIRS):
	@echo "Building $@..."
	make -C $@ compile

# Compile with library mapping
compile: $(SUBDIRS)
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

.PHONY: all compile clean print_libdir $(SUBDIRS)
