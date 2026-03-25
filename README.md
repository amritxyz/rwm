<!--
SPDX-FileCopyrightText: © 2026 Amritxyz
SPDX-License-Identifier: 0BSD
-->

# main.c [rwm]

Tiny river window manager implemented in C.

## Acknowledgements

Inspired by [tinyrwm](https://codeberg.org/river/tinyrwm) by Isaac Freund,
originally licensed under 0BSD & MIT.

## Dependencies

The following system dependencies are required:

- meson
- ninja
- wayland
- xkbcommon

## Building

```sh
make
sudo make install
```

## Running

```
river -c rwm
```
