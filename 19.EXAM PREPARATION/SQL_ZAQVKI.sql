---------- 1 ---  01.Table Design

CREATE TABLE IF NOT EXISTS `chats` (
  `id` int(11) NOT NULL,
  `title` varchar(32) NOT NULL,
  `start_date` date NOT NULL,
  `is_active` bit(1) NOT NULL,
  PRIMARY KEY (`id`)
) 

CREATE TABLE IF NOT EXISTS `credentials` (
  `id` int(11) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) 

CREATE TABLE IF NOT EXISTS `locations` (
  `id` int(11) NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  PRIMARY KEY (`id`)
) 

CREATE TABLE IF NOT EXISTS `messages` (
  `id` int(11) NOT NULL,
  `content` varchar(200) NOT NULL,
  `sent_on` date NOT NULL,
  `chat_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_messages_chats` (`chat_id`),
  KEY `FK_messages_users` (`user_id`),
  CONSTRAINT `FK_messages_chats` FOREIGN KEY (`chat_id`) REFERENCES `chats` (`id`),
  CONSTRAINT `FK_messages_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) 

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL,
  `nickname` varchar(25) NOT NULL,
  `gender` char(1) NOT NULL,
  `age` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  `credential_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `credential_id` (`credential_id`),
  KEY `FK_users_locations` (`location_id`),
  CONSTRAINT `FK_users_credentials` FOREIGN KEY (`credential_id`) REFERENCES `credentials` (`id`),
  CONSTRAINT `FK_users_locations` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`)
) 

CREATE TABLE IF NOT EXISTS `users_chats` (
  `user_id` int(11) NOT NULL,
  `chat_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`chat_id`),
  UNIQUE KEY `user_id_chat_id` (`user_id`,`chat_id`),
  KEY `FK_users_chats_chats` (`chat_id`),
  CONSTRAINT `FK_users_chats_chats` FOREIGN KEY (`chat_id`) REFERENCES `chats` (`id`),
  CONSTRAINT `FK_users_chats_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) 

----------- 2 -------- 02. Insert

INSERT INTO `messages` (`content`, `sent_on`, `chat_id`, `user_id`)	
SELECT
	CONCAT(`u`.`age`, '-', `u`.`gender`, '-', `l`.`latitude`, '-', `l`.`longitude`) AS `content`,
	'2016-12-15' AS `sent_on`,
	(CASE 
	WHEN `u`.`gender` = 'M' THEN ROUND(POW(`u`.`age` / 18, 3), 0)
	WHEN `u`.`gender` = 'F' THEN CEIL(SQRT(`u`.`age` * 2))
	END) AS `chat_id`,
	`u`.`id` AS `user_id`
	FROM `users` AS `u`
	JOIN `locations` AS `l` ON `u`.`location_id` = `l`.`id`
	WHERE `u`.`id` >= 10 AND `u`.`id` <= 20;
	
------ 3 -------  03. Update

UPDATE `chats` AS `c` JOIN `messages` AS `m` ON `m`.`chat_id` = `c`.`id`
AND `sent_on` < `start_date`
SET `c`.`start_date` = `m`.`sent_on`



update chats
join messages
on messages.chat_id=chats.id
set start_date=sent_on
where `sent_on` < `start_date`

------------ 4 -------- 04. Delete

DELETE `l`
	FROM `locations` AS `l`
	LEFT JOIN `users` AS `u` ON `u`.`location_id` = `l`.`id`
WHERE `u`.`id` IS NULL;



delete from locations
where id IN(
      select l.id from (
	                     select*from locations) as l
      left join users as u
      on l.id=u.location_id
      where u.location_id is null)

------------ 5 ------- 05. Age Range

SELECT `nickname`, `gender`, `age` 
FROM `users`
WHERE `age` >= 22 AND `age` <= 37
ORDER BY `id` ASC;

------------ 6 -------- 06. Messages

SELECT `content`, `sent_on`
FROM `messages`
WHERE date(`sent_on`) > '2014-05-12' AND `content` LIKE '%just%'
ORDER BY `id` DESC;

------------ 7 ------- 07. Chats

SELECT `title`, `is_active`
FROM `chats`
WHERE (`is_active` = 0 AND CHAR_LENGTH(`title`) < 5) OR SUBSTRING(`title`, 3, 2) = 'tl'
ORDER BY `title` DESC;

------------ 8 ------- 08. Chat Messages

SELECT `c`.`id`, `title`, `m`.`id`
FROM `chats` AS `c`
JOIN `messages` AS `m` ON `m`.`chat_id` = `c`.`id`
WHERE `m`.`sent_on` < '2012-03-26' AND SUBSTRING(`c`.`title`, -1, 1) = 'x'
ORDER BY `c`.`id` ASC, `m`.`id` ASC;

------------ 9 -------- 09. Message Count

SELECT `c`.`id`, COUNT(`m`.`id`) AS `total_messages` FROM `chats` AS `c`
JOIN `messages` AS `m` ON `m`.`chat_id` = `c`.`id` 
WHERE `m`.`id` < 90
GROUP BY `c`.`id`
ORDER BY `total_messages` DESC, `c`.`id` ASC
LIMIT 5;	

------------ 10 ------- 10. Credentials

SELECT `nickname`, `email`, `password`
FROM `users` AS `u`
JOIN `credentials` AS `c` ON `u`.`credential_id` = `c`.`id`
WHERE `email` LIKE '%co.uk'
ORDER BY `email` ASC;

------------ 11 --------  11. Locations

SELECT `id`, `nickname`, `age`
FROM `users` AS `u`
WHERE `location_id` IS NULL
ORDER BY `id` ASC;

------------ 12 --------  12. Left Users

SELECT `m`.`id`, `m`.`chat_id`, `m`.`user_id`
FROM `messages` AS `m`
LEFT JOIN `users_chats` AS `uc` 
	ON `uc`.`user_id` = `m`.`user_id` AND `uc`.`chat_id` = `m`.`chat_id`
WHERE `uc`.`user_id` IS NULL AND `m`.`chat_id` = 17
ORDER BY `m`.`id` DESC;

------------ 13 --------  13. Users in Bulgaria

SELECT `nickname`, `c`.`title`, `latitude`, `longitude`
FROM `users` AS `u`
JOIN `locations` AS `l` ON `l`.`id` = `u`.`location_id`
JOIN `users_chats` AS `uc` ON `uc`.`user_id` = `u`.`id`
JOIN `chats` AS `c` ON `c`.`id` = `uc`.`chat_id`
WHERE `latitude` >= 41.139999 AND `latitude` <= 44.129999
	AND `longitude` BETWEEN 22.209999 AND 28.359999
	
ORDER BY `c`.`title` ASC;

------------ 14 --------  14. Last Chat

SELECT `title`, `m`.`content`
FROM `chats` AS `c`
LEFT JOIN `messages` AS `m` ON `c`.`id` = `m`.`chat_id`
WHERE `c`.`start_date` = (SELECT `start_date` 
								  FROM `chats`
								  ORDER BY `start_date` DESC 
								  LIMIT 1)  
ORDER BY `m`.`sent_on` ASC, `m`.`id` ASC;

------------ 15 --------  15. Radians

DROP FUNCTION IF EXISTS udf_get_radians;        
CREATE FUNCTION udf_get_radians(`degrees` FLOAT)
RETURNS FLOAT                                   
BEGIN                                           
	return RADIANS(`degrees`);                   
END




DROP FUNCTION IF EXISTS udf_get_radians;        
create function udf_get_radians(degrees float) 
returns float
begin
   declare result FLOAT;
   set result = (degrees*PI())/180;
   return result;
end

------------ 16 --------  16. Change Password

CREATE PROCEDURE udp_change_password(`user_email` VARCHAR(30), `new_password` VARCHAR(20))
BEGIN
	IF	(SELECT `id` FROM `credentials` WHERE `email` = `user_email`) IS NULL THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The email does\'t exist!';
	ELSE 
		UPDATE `credentials` SET `password` = `new_password` WHERE `email` = `user_email`;
	END IF;
	
END

------------ 17 --------  17. Send Message

CREATE PROCEDURE udp_send_message(`u_id` INT, `c_id` INT, `chat_msg` VARCHAR(200))
BEGIN
	IF	(SELECT `user_id` FROM `users_chats` 
		 WHERE `user_id` = `u_id` AND `chat_id` = `c_id`
		) IS NULL THEN
		
		SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'There is no chat with that user!';
	ELSE 
		INSERT INTO `messages` (`content`, `sent_on`, `chat_id`, `user_id`)
		VALUES (`chat_msg`, '2016-12-15', `c_id`, `u_id`);
	END IF;
	
END

------------ 18 --------  18. Log Messages

CREATE TRIGGER del_msg
AFTER DELETE 
ON `messages`
FOR EACH ROW
BEGIN
	INSERT INTO `messages_log` VALUES (OLD.id, OLD.content, OLD.sent_on, OLD.chat_id, OLD.user_id);
END

------------ 19 --------  19. Delete Users

CREATE TRIGGER del_urs_before
BEFORE DELETE 
ON `users`
FOR EACH ROW
BEGIN
	DELETE FROM `messages` WHERE `user_id` = OLD.id;
	DELETE FROM `messages_log` WHERE `user_id` = OLD.id;	
	DELETE FROM `users_chats` WHERE `user_id` = OLD.id;
	
END

