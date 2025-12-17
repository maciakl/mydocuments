VER := `uv version | busybox awk '{print $NF}'`

build:
    uv build
    python -m PyInstaller -F mydocuments.py

release: build
    zip -j "dist/mydocuments-{{VER}}-win_x64.zip" dist/mydocuments.exe

hash: release
    sha256sum dist/mydocuments-{{VER}}-win_x64.zip >> dist/checksums-{{VER}}.txt
    sha256sum dist/mydocuments-{{VER}}.tar.gz >> dist/checksums-{{VER}}.txt
