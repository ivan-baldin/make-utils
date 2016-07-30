# Copyright 2016 Ivan Baldin
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ifndef utils.mk
utils.mk :=

# Ensure default goal is defined
ifndef .DEFAULT_GOAL
.PHONY: all
all :

endif

# Silence rule output
$(VERBOSE).SILENT:

# Enable second expansion of rules
.SECONDEXPANSION:

# If unset set default source directory to ".."
ifndef SOURCE_DIR
  SOURCE_DIR := $(dir $(patsubst %/,%,$(dir $(lastword $(MAKEFILE_LIST)))))
endif

################################################################################
# Variables
################################################################################

# Suffixes that should be included in vpath
C_SUFFIXES   := .c .h
CXX_SUFFIXES := .cc .C .cpp .cxx .hpp
ASM_SUFFIXES := .s .S

# Pretty print format for programs
PROGRAM_PP_FMT := '%-8s%s\n'

SUBDIR_FILE ?= dir.mk

output_dir = ./
source_dir = $(SOURCE_DIR)$(output_dir)

@/TARGETS = $(addprefix $(output_dir),$(targets))
@/OBJECTS = $(addprefix $(output_dir),$(objects))
TARGETS =
OBJECTS =
DEPENDS = $(patsubst %.o,%.d,$(filter %.o,$(TARGETS) $(OBJECTS)))

################################################################################
# Functions
################################################################################

##
# Add list of suffixes to vpath.
#
# @param 1 List of suffixes.
# @param 2 Path to include.
#
vpath-add = $(foreach s,$1,$(eval vpath %$s $2))

##
# Set program variable for make script and pretty printed version for rules.
#
# @param 1 Variable name.
# @param 2 Program command.
#
set-program = $(eval $(set-program-body))
define set-program-body
$1 := $2
$(or $(MAKECMDGOALS),$(.DEFAULT_GOAL)): $1 = $$(call rule-pretty-print,$1,$2)
endef

define rule-pretty-print
@printf $(PROGRAM_PP_FMT) '$1' '$@'
	$2
endef

##
# Add subdirectory to the project.
#
# @param 1 Subdirectory to add. Must be relative to SOURCE_DIR.
#
add-subdir = $(eval $(call add-subdir-body,$1,$(output_dir),$(targets),$(objects)))
define add-subdir-body
  $(eval output_dir := $(1:%/=%)/)
  targets :=
  objects :=

  # Create output directory
  $(shell $(MKDIR) $(output_dir))

  # Process subdirectory file
  include $(SOURCE_DIR)$(output_dir)$(SUBDIR_FILE)

  # Add exported targets
  $(output_dir)TARGETS := $$(@/TARGETS)
  ifneq ($$(@/TARGETS),)
    TARGETS += $$($(output_dir)TARGETS)
  endif

  # Add compiled objects
  $(output_dir)OBJECTS := $$(@/OBJECTS)
  ifneq ($$(@/OBJECTS),)
    OBJECTS += $$($(output_dir)OBJECTS)
  endif

  # Restore local variables
  $(output_dir) := $2
  targets := $3
  objects := $4
endef

################################################################################
# Programs
################################################################################

$(call set-program,RM,rm -f)
$(call set-program,RM-R,rm -fr)
$(call set-program,MKDIR,mkdir -p)
$(call set-program,MAKE,make)

endif
