CREATE TABLE geo_code
(
  id  bigint auto_increment,
  lng double default null,
  lat double default null,
  PRIMARY KEY (id)
);

INSERT INTO geo_code (id, lng, lat)
VALUES (1, 20, 20),
       (2, 30, 30),
       (3, 40, 40);

CREATE TABLE `super_user`
(
  `id`           bigint(20)   AUTO_INCREMENT,
  `user_type`    varchar(255),
  `username`     varchar(255) DEFAULT NULL,
  `password`     varchar(255),
  `email`        varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  address        varchar(255),
  geo_code_id    bigint(20),
  PRIMARY KEY (`id`),
  CONSTRAINT geo_code_id FOREIGN KEY (`id`) REFERENCES `geo_code` (`id`)

);

-- testUser1 password: pass1
-- testUser2 password: pass2
-- testUser3 password: pass3
INSERT INTO super_user (id, username, password, email, phone_number, address, geo_code_id, user_type)
VALUES (1,
        'test1',
        '$2a$10$3A7YK9hDUpHN4plBoCphYOzk426CebJwnaFMk0kN4qEXoWUTiwejC',
        'test1@test.test',
        '5353',
        'Budapest, Szép u. 2, 1053',
        1,
        'PrivateUser'),
       (2,
        'test2',
        '$2a$10$y1WkKt52SH8eDm6zvy63v.B0EstAaevqAgfo7plk8v9UuigsMcqxi',
        'test2@test.test',
        '5555',
        'Gitega, Burundi',
        2,
        'PrivateUser'),
       (3,
        'test3',
        '$2a$10$N.4V.83hs.5X2bI0qY0Tme2PYceHtDf2Suzh0QHEcYVZxeS0YhJL6',
        'test3@test.test',
        null,
        '1042',
        3,
        'PrivateUser');


CREATE TABLE `animal`
(
  `id`                  bigint(20)   AUTO_INCREMENT,
  `super_user_id`       bigint(20),
  `animal_type`         varchar(255),
  `name`                varchar(255) DEFAULT NULL,
  `birth_date`          datetime(6),
  `type`                varchar(255) DEFAULT NULL,
  `gender`              varchar(255) DEFAULT NULL,
  `from_when_available` datetime(6),
  `photo_path`          varchar(255) DEFAULT NULL,
  `spayed`              bit          DEFAULT 0,
  `vaccinated`          bit          DEFAULT 0,
  `adopted`             bit          DEFAULT 0,
  CONSTRAINT super_user_id FOREIGN KEY (`id`) REFERENCES `super_user` (`id`),
  PRIMARY KEY (`id`)
);

INSERT INTO animal (id,
                    name,
                    birth_date,
                    type,
                    gender,
                    from_when_available,
                    spayed,
                    vaccinated,
                    photo_path,
                    super_user_id,
                    animal_type)
VALUES (1,
        'Pinguee',
        '2010-02-04 03:00:00',
        'dog',
        'female',
        '2019-02-04 03:00:00',
        true,
        true,
        '$HOME/assets/images/penguee.jpg',
        1,
        'Dog'),
       (2,
        'Doggo',
        '2012-10-04 03:00:00',
        'dog',
        'male',
        '2019-05-04 03:00:00',
        false,
        true,
        '$HOME/assets/images/doggo.jpg',
        1,
        'Dog'),
       (3,
        'Grumpy',
        '2015-10-04 03:00:00',
        'cat',
        'male',
        '2050-05-04 03:00:00',
        false,
        false,
        '$HOME/assets/images/grumpycat.jpg',
        1,
        'Cat');


CREATE TABLE private_users_liked_animals
(
  animal_id       BIGINT NOT NULL,
  private_user_id BIGINT NOT NULL,
  CONSTRAINT private_users_liked_animals_animal_id FOREIGN KEY (animal_id) REFERENCES animal (id),
  CONSTRAINT private_users_liked_animals_private_user_id FOREIGN KEY (private_user_id) REFERENCES super_user (id)
);