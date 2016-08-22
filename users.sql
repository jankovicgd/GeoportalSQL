CREATE TABLE public.usersdb
(
  id integer NOT NULL DEFAULT nextval('usersdb_id_seq'::regclass),
  username character varying(20),
  password character varying(512),
  email character varying(50),
  aktivan integer DEFAULT 0,
  "Nameuser" character varying(50),
  "LastName" character varying(50),
  "holdingNo" bigint,
  CONSTRAINT usersdb_pkey PRIMARY KEY (id)
)

ALTER TABLE usersdb
ADD PRIMARY KEY (id);

insert INTO usersdb
values (1, 'admin', 'admin123456');

UPDATE usersdb SET password = crypt('password',gen_salt('bf'));

INSERT into usersdb (id, username, password, "Name", "LastName", "Active", email)
VALUES (2, 'korisnik1', crypt('password123456',gen_salt('bf')), NULL, NULL, NULL, NULL);

SELECT COUNT (id) FROM usersdb WHERE username = 'korisnik1' AND password = crypt('password123456', password);
