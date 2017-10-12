---1------

CREATE DATABASE minions;

---2------

USE  minions;
CREATE TABLE minions
(
   id int PRIMARY KEY
  ,name VARCHAR(50)
  ,age int
);
  
CREATE TABLE towns
(
  id int PRIMARY KEY
, name VARCHAR(50)
);

---3------

ALTER TABLE minions ADD column town_id int;
ALTER TABLE minions
ADD CONSTRAINT fk_minions_towns FOREIGN KEY(town_id)
REFERENCES towns(id);

---4------

INSERT INTO towns(id, name)
VALUES (1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna');

INSERT INTO minions(id, name, age, town_id)
VALUES (1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2);

-- -----------------5-------------
Truncate table minions;
-- -----------------6-------------
DROP TABLE minions;
DROP TABLE towns;
-- drop database minions

---7------


---8------


CREATE TABLE users(
	id BIGINT PRIMARY KEY UNIQUE AUTO_INCREMENT,
	username VARCHAR(30) UNIQUE  NOT NULL,
	password  VARCHAR(26) NOT NULL,
	profile_picture  BLOB,
	last_login_time DATE,
	is_deleted BOOL
);


INSERT INTO users(username, password, last_login_time, is_deleted)
VALUES ('Gogo', 'spojpe',  '2017-05-15', TRUE),
('Bobo','epgojro', '2017-08-05', FALSE),
('Ani',  'rpker', '2017-04-25', TRUE),
('Sasho',  'rgpjrpe', '2017-05-06', TRUE),
('Gery', 'pkptkh','2017-01-11', FALSE);


---9------

ALTER TABLE users MODIFY id BigINT NOT NULL;
ALTER TABLE users DROP PRIMARY KEY;
ALTER TABLE users ADD CONSTRAINT pk_users PRIMARY KEY (`id`, `username`);

---10------

alter table users modify column last_login_time NOT NULL DEFAULT CURRENT_TIMESTAMP;
-- ALTER TABLE users MODIFY COLUMN last_login_time TIMESTAMP NOT NULL DEFAULT now();


---11------

ALTER TABLE users MODIFY id BIGINT NOT NULL;
ALTER TABLE users DROP PRIMARY KEY;
ALTER TABLE users ADD CONSTRAINT pk_users PRIMARY KEY(id);
ALTER TABLE users ADD CONSTRAINT uq_username UNIQUE (username);

---12------



---13------


---14------


---15------
  
---16------


---17------


---18------

---19------


---20------


---21------


