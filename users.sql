create table usersdb(
id integer,
username varchar(50),
password varchar(200)
);

ALTER TABLE usersdb
ADD PRIMARY KEY (id);

insert INTO usersdb
values (1, 'admin', 'admin123456');

UPDATE usersdb SET password = crypt('password',gen_salt('bf'));

INSERT into usersdb (id, username, password, "Name", "LastName", "Active", email)
VALUES (1, 'korisnik1', crypt('password123456',gen_salt('bf')), NULL, NULL, NULL, NULL);

SELECT COUNT (id) FROM usersdb WHERE username = 'korisnik1' AND password = crypt('password123456', password);
