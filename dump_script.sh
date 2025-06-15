#!/bin/bash

# 미디어위키 설치 경로
MW_DIR="/home/bitnami/htdocs/mw"

php $MW_DIR/maintenance/run.php $MW_DIR/maintenance/dumpBackup.php --current > dump_allPages.xml
php $MW_DIR/maintenance/run.php $MW_DIR/maintenance/dumpBackup.php --current --filter=namespace:3200 > dump_lyricOnly.xml

# 스테이징
git add dump_allPages.xml dump_lyricOnly.xml

# 커밋 메시지와 함께 커밋
GIT_AUTHOR_NAME="backup-bot[bot]" \
GIT_AUTHOR_EMAIL="backup-bot[bot]@users.noreply.github.com" \
GIT_COMMITTER_NAME="backup-bot[bot]" \
GIT_COMMITTER_EMAIL="backup-bot[bot]@users.noreply.github.com" \
git commit -m "자동 백업: $(date)"

# 원격 저장소로 푸시
git pull
git push origin main