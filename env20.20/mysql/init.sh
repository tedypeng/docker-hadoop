CREATE DATABASE metastore;
CREATE USER 'hive'@'%' IDENTIFIED BY 'hive';
GRANT ALL PRIVILEGES ON metastore.* TO 'hive'@'%';

