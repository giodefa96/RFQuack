#
# vim: noexpandtab
#
# RFQuack is a versatile RF-hacking tool that allows you to sniff, analyze, and
# transmit data over the air. Consider it as the modular version of the great
# 
# Copyright (C) 2019 Trend Micro Incorporated
# 
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; either version 2 of the License, or (at your option) any later
# version.
# 
# This program is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.  See the GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License along with
# this program; if not, write to the Free Software Foundation, Inc., 51 Franklin
# Street, Fifth Floor, Boston, MA  02110-1301, USA.
#

# Note: make sure that client/ points to the root of https://github.com/rfquack/RFQuack-cli

SHELL := /bin/bash
EXAMPLES := $(wildcard examples/*)

.PHONY: all proto examples

all: proto examples

proto:
	cd "${HOME}/.platformio/lib/Nanopb/generator/proto" ;  make
	cd "src" ; \
	protoc --plugin=protoc-gen-nanopb=${HOME}/.platformio/lib/Nanopb/generator/protoc-gen-nanopb \
		--nanopb_out=./ \
		rfquack.proto \
		--python_out=client/

examples:
	for example in $(EXAMPLES); do \
		pio ci -c $$example/platformio.ini -l src/ $$example; \
	done
