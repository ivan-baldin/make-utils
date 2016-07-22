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

include $(MK_DIR)utils.mk

################################################################################
# Programs
################################################################################

gcc-set = $(call set-program,$(strip $1),$(strip $(GCC_PREFIX)$2))

$(call gcc-set, ADDR2LINE, addr2line)
$(call gcc-set, AR,        ar)
$(call gcc-set, AS,        as)
$(call gcc-set, C++FILT,   c++filt)
$(call gcc-set, CC,        gcc)
$(call gcc-set, CXX,       g++)
$(call gcc-set, ELFEDIT,   elfedit)
$(call gcc-set, GCOV,      gcov)
$(call gcc-set, GCOV-TOOL, gcov-tool)
$(call gcc-set, GDB,       gdb)
$(call gcc-set, GPROF,     gprof)
$(call gcc-set, LD,        ld)
$(call gcc-set, NM,        nm)
$(call gcc-set, OBJCOPY,   objcopy)
$(call gcc-set, OBJDUMP,   objdump)
$(call gcc-set, RANLIB,    ranlib)
$(call gcc-set, READELF,   readelf)
$(call gcc-set, SIZE,      size)
$(call gcc-set, STRINGS,   strings)
$(call gcc-set, STRIP,     strip)
