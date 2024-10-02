FROM wordpress:latest

# wp-cliのインストール
RUN apt-get update && apt-get install -y less mariadb-client
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# WordPressディレクトリの所有権を変更
WORKDIR /var/www/html
RUN chown -R www-data:www-data /var/www/html
