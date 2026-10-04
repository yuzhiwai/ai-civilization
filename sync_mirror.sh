#!/bin/bash
# 镜像同步脚本：知识库 → GitHub镜像 → push
# 用法：bash C:/miaosen/ai-civilization/sync_mirror.sh "提交说明（可选）"
set -e
SRC="C:/知识库/思想与文学/AI与文明专栏"
DST="C:/miaosen/ai-civilization"

cp "$SRC"/0*.md "$SRC"/1*.md "$DST/" 2>/dev/null || true
cp "$SRC/常见问题与误读答疑.md" "$SRC/本专栏基于AI的正确打开方式.md" "$DST/"
cp "$SRC/_manifest.json" "$DST/manifest.json"

cd "$DST"
git -c safe.directory=C:/miaosen/ai-civilization add -A
if git -c safe.directory=C:/miaosen/ai-civilization diff --cached --quiet; then
  echo "无变化，无需提交"
else
  MSG="${1:-同步知识库更新}"
  git -c safe.directory=C:/miaosen/ai-civilization -c user.name="微与之" -c user.email="noreply@users.noreply.local" commit -m "$MSG" | tail -1
  git -c safe.directory=C:/miaosen/ai-civilization push | tail -1
fi
