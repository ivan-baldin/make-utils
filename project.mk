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

PROJECT_NAME = $(notdir $(abspath $(SOURCE_DIR)))
SOURCE_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

include $(SOURCE_DIR)mk/util.mk
include $(SOURCE_DIR)mk/gcc.mk
include $(SOURCE_DIR)mk/subdir.mk

$(call vpath-add-list,$(VPATH_SUFFIXES),$(SOURCE_DIR))

$(call subdir-add-root)

################################################################################
# Flags
################################################################################

# Preprocessor Flags
CPPFLAGS += -Wall -Wextra -Wpedantic

# C Flags
CFLAGS += -std=c11
CFLAGS += -MMD

# C++ Flags
CXXFLAGS += -std=c++11 
CXXFLAGS += -MMD

# Archive Flags
ARFLAGS := rcs

-include $(ALL_OBJECTS:.o=.d)
