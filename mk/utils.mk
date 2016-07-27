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

################################################################################
# Variables
################################################################################

# Suffixes that should be included in vpath
VPATH_SUFFIXES := .c .cc .C .cpp .cxx .h .hpp .s .S .y .l .sh

# Pretty print format for programs
PROGRAM_PP_FMT := '%-8s%s\n'

################################################################################
# Functions
################################################################################

##
# Add list of suffixes to vpath.
#
# @param 1 List of suffixes.
# @param 2 Path to include.
#
vpath-add-list = $(foreach s,$1,$(eval vpath %$s $2))

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

################################################################################
# Programs
################################################################################

$(call set-program,RM,rm -f)
$(call set-program,RM-R,rm -fr)
$(call set-program,MKDIR,mkdir -p)
$(call set-program,MAKE,make)

endif
