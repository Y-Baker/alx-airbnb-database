## how to create the database
```sql
DROP DATABASE IF EXISTS airbnb;
CREATE DATABASE airbnb;
```

### how to create the user
```sql
CREATE USER 'airbnb'@'*' IDENTIFIED BY 'root';
```

### how to grant privileges and flush privileges
```sql
GRANT ALL PRIVILEGES ON airbnb.* TO 'airbnb'@'*';
FLUSH PRIVILEGES;
```

---

## how to create the tables
```bash 
cat database-script-0x01/schema.sql | mysql -u airbnb -p airbnb
```

---

## Seed Data
...


<br />

## Authors :black_nib:
* [__Repo__](https://github.com/Y-Baker/alx-airbnb-database)
* __Yousef Bakier__ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br />
 &nbsp;&nbsp;[<img height="" src="https://img.shields.io/static/v1?label=&message=GitHub&color=181717&logo=GitHub&logoColor=f2f2f2&labelColor=2F333A" alt="Github">](https://github.com/Y-Baker)
