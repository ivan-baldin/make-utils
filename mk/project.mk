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

ifndef SOURCE_DIR
  SOURCE_DIR := $(dir $(patsubst %/,%,$(dir $(lastword $(MAKEFILE_LIST)))))
endif

include $(SOURCE_DIR)mk/utils.mk

################################################################################
# Variables
################################################################################

SUBDIR_FILE ?= dir.mk

source_dir = $(SOURCE_DIR)$(output_dir)

################################################################################
# Functions
################################################################################

##
# Add subdirectory to the project.
#
# @param 1 Subdirectory to add. Must be relative to SOURCE_DIR.
#
subdir-add = $(eval $(call subdir-add-body,$1,$(output_dir),$(objects),$(targets)))
define subdir-add-body
  $(eval output_dir := $(call source-strip,$(SOURCE_DIR)$1))
  $(eval output_dir := $(and $(output_dir),$(output_dir)/))

  include $(source_dir)$(SUBDIR_FILE)

  # Prefix directory specific variables
  ifneq ($$(words $$(objects)),0)
    ifeq ($(output_dir),)
      $$(eval OBJECTS += $$(objects))
    else
      $(output_dir)OBJECTS := $$(addprefix $(output_dir),$$(objects))
      OBJECTS += $$($(output_dir)OBJECTS)
    endif
  endif
  ifneq ($$(words $$(targets)),0)
    ifeq ($(output_dir),)
      $$(eval TARGETS += $$(targets))
    else
      $(output_dir)TARGETS := $$(addprefix $(output_dir),$$(targets))
      TARGETS += $$($(output_dir)TARGETS)
    endif
  endif

# Create output directory rules
$$($(output_dir)OBJECTS): | $(output_dir)
$$($(output_dir)TARGETS): | $(output_dir)
$(output_dir):
	$$(MKDIR) $$@

  # Restore local variables
  output_dir := $2
  objects := $3
  targets := $4
endef

##
# Strip prefix of a path.
# <p>
# Only works for paths that are subdirectories of a prefix path.
#
# @param 1 Prefix to strip.
# @param 2 Path to strip.
#
prefix-strip = $(patsubst /%,%,$(patsubst $(abspath $1)%,%,$(abspath $2)))

##
# Strip SOURCE_DIR prefix of a path.
#
# @param 1 Path to strip.
#
source-strip = $(foreach f,$1,$(call prefix-strip,$(SOURCE_DIR),$f))

################################################################################
# Add root directory
################################################################################

$(call vpath-add-list,$(VPATH_SUFFIXES),$(SOURCE_DIR))

$(call subdir-add,.)

$(.DEFAULT_GOAL): $(TARGETS)
