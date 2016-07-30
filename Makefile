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

OUTPUT_DIR ?= build/
SOURCE_DIR ?= ../

include mk/utils.mk

export CPPFLAGS
export CFLAGS
export CXXFLAGS

################################################################################
# Rules
################################################################################

all: debug

debug: CFLAGS   = -O0 -ggdb
debug: CXXFLAGS = -O0 -ggdb

release: CPPFLAGS = -DNDEBUG
release: CFLAGS   = -O2
release: CXXFLAGS = -O2

.PHONY: debug release
debug release:
	@mkdir -p $(OUTPUT_DIR)$@
	$(MAKE) -C $(OUTPUT_DIR)$@ -f $(SOURCE_DIR)../project.mk

.PHONY: clean
clean:
	$(RM-R) $(OUTPUT_DIR)
