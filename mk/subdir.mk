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

MK_DIR ?= $(dir $(lastword $(MAKEFILE_LIST)))

include $(MK_DIR)util.mk

################################################################################
# Variables
################################################################################

ifndef SOURCE_DIR
  SOURCE_DIR := $(dir $(patsubst %/,%,$(dir $(lastword $(MAKEFILE_LIST)))))
endif

SUBDIR_FILE ?= dir.mk

source_dir = $(SOURCE_DIR)$(output_dir)

################################################################################
# Functions
################################################################################

##
# Add project root directory.
# <p>
# Adds root directory, creates output folders and adds targets to default goal.
# 
subdir-add-root = $(eval $(subdir-add-root-body))
define subdir-add-root-body
  # Add project root directory file
  $(call subdir-add,.)

  # Create nesessary directories
  $(call mkdir-rules,$(ALL_OBJECTS) $(ALL_TARGETS))

  $(.DEFAULT_GOAL): $$(ALL_TARGETS)
endef

##
# Find and add all subdirectories to the project.
# 
subdir-add-all = $(call subdir-add-list,$(call subdir-find,$(source_dir)))

##
# Add list of subdirectories to the project.
#
# @param 1 Subdirectory list to add.
#
subdir-add-list = $(foreach d,$1,$(call subdir-add,$d))

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
  $(output_dir)OBJECTS := $$(addprefix $(output_dir),$$(objects))
  $(output_dir)TARGETS := $$(addprefix $(output_dir),$$(targets))

  # Add prefixed variables to globals
  ifneq ($$(value $(output_dir)OBJECTS),)
    ALL_OBJECTS += $$($(output_dir)OBJECTS)
  endif
  ifneq ($$(value $(output_dir)TARGETS),)
    ALL_TARGETS += $$($(output_dir)TARGETS)
  endif

  # Restore local variables
  output_dir := $2
  objects := $3
  targets := $4
endef

##
# Find immediate subdirectories containing SUBDIR_FILE.
#
# @param 1 Directory to search.
#
subdir-find = $(call source-strip,$(dir $(wildcard $(SOURCE_DIR)*/$(SUBDIR_FILE))))

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
