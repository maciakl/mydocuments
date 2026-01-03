VER := `uv version | busybox awk '{print $NF}'`

build:
    uv build
    python -m PyInstaller -F mydocuments.py

zip: build
    zip -j "dist/mydocuments-{{VER}}-win_x64.zip" dist/mydocuments.exe

hash: zip
    sha256sum dist/mydocuments-{{VER}}-win_x64.zip >> dist/checksums-{{VER}}.txt
    sha256sum dist/mydocuments-{{VER}}.tar.gz >> dist/checksums-{{VER}}.txt

release: hash
    git tag -a "v{{VER}}"
    git push origin "v{{VER}}"
    gh release create "v{{VER}}" dist/mydocuments-{{VER}}-win_x64.zip dist/checksums-{{VER}}.txt --title "v{{VER}}" --notes "Release v{{VER}} of MyDocuments"
