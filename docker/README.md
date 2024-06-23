# WB_Practice-BI-Olap
ДЗ 2 по Docker и Docker-compose
# Задание 1
docker pull nginx
docker pull mysql

docker run -d --name mynginx -p 8080:80 -v nginx-data:/usr/share/nginx/html --restart unless-stopped --memory="512m" --cpus="1.0" nginx
docker run -d --name mysql -p 3306:3306 -v mysql-data:/var/lib/mysql --restart unless-stopped --memory="1g" --cpus="2.0" -e MYSQL_ROOT_PASSWORD=12345678 -e MYSQL_DATABASE=wbdatabase -e MYSQL_USER=shreyder -e MYSQL_PASSWORD=wb123456 mysql

docker restart mynginx
docker restart mysql

docker stop mynginx mysql

docker rm mynginx mysql

# Задание 2
docker-compose up
