# SPDX-FileCopyrightText: © 2026 Amritxyz
# SPDX-License-Identifier: 0BSD

CC      = cc
PREFIX  = /usr/local
BINDIR  = $(PREFIX)/bin

CFLAGS  += -std=c99 -Wall -Wextra -Wno-unused-parameter -D_POSIX_C_SOURCE=200809L
CFLAGS  += $(shell pkg-config --cflags wayland-client xkbcommon)
LDFLAGS += $(shell pkg-config --libs wayland-client xkbcommon)

WAYLAND_SCANNER = $(shell pkg-config --variable=wayland_scanner wayland-scanner)

GENERATED = \
	river-window-management-v1-client-protocol.h \
	river-window-management-v1-protocol.c \
	river-xkb-bindings-v1-client-protocol.h \
	river-xkb-bindings-v1-protocol.c

OBJS = \
	rwm.o \
	river-window-management-v1-protocol.o \
	river-xkb-bindings-v1-protocol.o

all: rwm

rwm: $(OBJS)
	$(CC) $(OBJS) $(LDFLAGS) -o $@

rwm.o: main.c $(filter %.h, $(GENERATED))
	$(CC) $(CFLAGS) -c main.c -o $@

%-protocol.c: protocol/%.xml
	$(WAYLAND_SCANNER) private-code $< $@

%-client-protocol.h: protocol/%.xml
	$(WAYLAND_SCANNER) client-header $< $@

river-window-management-v1-protocol.o: river-window-management-v1-protocol.c river-window-management-v1-client-protocol.h
	$(CC) $(CFLAGS) -c $< -o $@

river-xkb-bindings-v1-protocol.o: river-xkb-bindings-v1-protocol.c river-xkb-bindings-v1-client-protocol.h
	$(CC) $(CFLAGS) -c $< -o $@

install: rwm
	install -Dm755 rwm $(DESTDIR)$(BINDIR)/rwm

clean:
	rm -f rwm $(OBJS) $(GENERATED)

.PHONY: all install clean
