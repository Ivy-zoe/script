#!/bin/bash

REMOTE="http://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet"
INSTALL="/tmp/install-texlive"

mkdir -p "$INSTALL"
curl -sSL "$REMOTE/install-tl-unx.tar.gz" | tar -xzv -C "$INSTALL" --strip-components=1

cat << EOF > "$INSTALL/tl.profile"
selected_scheme scheme-full
tlpdbopt_autobackup 0
EOF

"$INSTALL/install-tl" -profile "$INSTALL/tl.profile" -repository "$REMOTE"