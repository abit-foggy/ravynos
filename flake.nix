{
  description = "ravynOS development tools for the Darwin source tree";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      llvm = pkgs.llvmPackages_18;
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          llvm.clang
          llvm.lld
          cmake
          ninja
          gnumake
          bmake
          python3
          openssl
          libpng
          libxml2
          zlib
          bison
          flex
          binutils
          tcsh
          pkg-config
          git
        ];

        shellHook = ''
          export HOST_CC="${llvm.clang}/bin/clang"
          export HOST_CXX="${llvm.clang}/bin/clang++"
          export HOST_AR="${pkgs.llvmPackages_18.bintools}/bin/llvm-ar"
          echo "ravynOS toolchain: $(clang --version | head -n 1)"
        '';
      };
    };
}
