#!/bin/bash

# Docker Composeを使用してWordPress環境を立ち上げる
docker-compose up -d

# WordPressが起動するまで少し待機
echo "Waiting for WordPress to be ready..."
sleep 30

# WordPressの初期設定（ユーザーやパスワード設定）
WP_URL="http://localhost:8080"
WP_TITLE="My WordPress Site"
WP_ADMIN="admin"
WP_PASSWORD="adminpassword"
WP_EMAIL="admin@example.com"

# wp-cliコマンドに --allow-root を追加
docker exec wordpress wp --allow-root core install --url="$WP_URL" \
  --title="$WP_TITLE" \
  --admin_user="$WP_ADMIN" \
  --admin_password="$WP_PASSWORD" \
  --admin_email="$WP_EMAIL" \
  --skip-email

# wp-cliを使用してプラグインをインストールして有効化
docker exec wordpress wp --allow-root plugin install restrict-content-pro --activate
docker exec wordpress wp --allow-root plugin install youtube-embed-plus --activate

# 動画一覧ページの作成とパスワード保護
PAGE_TITLE="Protected Video Page"
PAGE_CONTENT='<h1>YouTube Video List</h1><iframe width="560" height="315" src="https://www.youtube.com/embed/YOUR_VIDEO_ID" frameborder="0" allowfullscreen></iframe>'
PAGE_PASSWORD="video123"

docker exec wordpress wp --allow-root post create --post_title="$PAGE_TITLE" --post_content="$PAGE_CONTENT" --post_status=publish --post_password="$PAGE_PASSWORD" --post_type=page

echo "WordPress setup complete. Visit $WP_URL to see your site."