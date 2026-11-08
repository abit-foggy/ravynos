# Building ravynOS From Source

This guide is for the current Darwin-based ravynOS. In this source revision, the checked-in top-level build is driven by BSD make (`bmake`); there is no top-level `CMakeLists.txt`. The build starts by creating a toolchain for the host OS and then uses it to build the OS for the same CPU architecture.

The host toolchain (Default.xctoolchain) includes clang, LLVM, Apple cctools, xcbuild, and other utilities needed to build the OS. Building LLVM initially takes a __long__ time, so be patient. It lives in `<build_dir>/Developer/Toolchains/Default.xctoolchain` once built.

After the toolchain is available, critical system libraries and headers will be built into the ravynOS.sdk - an equivalent of MacOSX.sdk for ravynOS native targets. The new SDK is then used to progressively build the rest of the system.

Building it this way takes longer, but there are advantages. It helps make the entire build portable and it guarantees build consistency, which helps reduce those nasty "well it works for me" problems. Once it has built fully, subsequent incremental builds are faster.

## What you need:
* A host machine with:
  * clang 17.x (Apple, Linux) or 18.x (Linux)
  * cmake 3.15+ and ninja
  * GNU make (gmake)
  * BSD make (bmake)
  * Python 3
  * OpenSSL
  * libpng (for xcbuild), libxml2, zlib (libz)
* A lot of patience


## Linux development with Nix

The repository's `flake.nix` provides a pinned development shell with Clang 18, LLD, BSD and GNU make, CMake/Ninja, and the documented host libraries and utilities. It sets the `HOST_CC`, `HOST_CXX`, and `HOST_AR` variables for the project build without changing `/usr/bin/cc` or `/usr/bin/c++`.

Enter the shell from the repository root:

```sh
nix develop
```

## Full source build

Use the checked-in BSD makefiles and their declared targets from the repository root. A full source build creates the toolchain and SDK under the build directory described by the top-level `Makefile`; it takes substantially longer than entering the Nix development shell.
