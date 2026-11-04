# Swift Bindings for LLVM

## Installation

This package uses a pkg-config file named `llvm` to link [LLVM](https://llvm.org).

On macOS, [Homebrew](https://brew.sh) installs LLVM without a pkg-config file, but you can use [llvm-swift-installer](https://github.com/DanielJamesHeywood/llvm-swift-installer) to write one.

## Safety

These bindings strive to be as safe as they can be without incurring any overhead under `-Ounchecked`.

The sole exception is that each object retains a reference to the context or module that owns it, which resolves the memory-safety issues that the bindings introduce by deviating from LLVM-C's memory management model.
