# Swift Bindings for LLVM

Swift bindings for [LLVM](https://llvm.org)'s C API, written for Daniel James Heywood's 3rd year project. They support only the subset of LLVM that the project requires.

The bindings mirror LLVM-C where possible, deviating only to follow the naming conventions of LLVM's C++ API and to replace LLVM-C's `Create`/`Dispose` memory management model with automatic reference counting.

## Installation

This package uses a pkg-config file named `llvm` to link LLVM.

On macOS, [Homebrew](https://brew.sh) installs LLVM without a pkg-config file, but you can use [llvm-swift-installer](https://github.com/DanielJamesHeywood/llvm-swift-installer) to write one.

## Safety

The bindings strive to be as safe as they can be without incurring any overhead under `-Ounchecked`.

The sole exception is that each object retains a reference to the context or module that owns it, which resolves the memory-safety issues that the bindings introduce by deviating from LLVM-C's memory management model.
