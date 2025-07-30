build:
    uv build
    python -m PyInstaller -F mydocuments.py

release: build
    $VER = (uv version | busybox awk '{print $NF}')
    zip -j "dist/mydocuments-$VER-win_x64.zip" dist/mydocuments.exe
