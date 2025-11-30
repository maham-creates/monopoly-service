--
-- This SQL script builds a monopoly database, deleting any pre-existing version.
--
-- @author kvlinden
-- @version Summer, 2015
--

-- Drop previous versions of the tables if they they exist, in reverse order of foreign keys.
DROP TABLE IF EXISTS PlayerGame CASCADE; -- CASCADE is used to update or delete an entry from both the parent and child tables simultaneously.
DROP TABLE IF EXISTS Game CASCADE;
DROP TABLE IF EXISTS Player CASCADE;
DROP TABLE IF EXISTS PlayerState CASCADE; -- current status of player
DROP TABLE IF EXISTS Property CASCADE;  -- properties on the board
DROP TABLE IF EXISTS PlayerProperty CASCADE; -- properties owned by players

-- Create the schema.
CREATE TABLE Game (
	ID integer PRIMARY KEY,
	time timestamp
	);

CREATE TABLE Player (
	ID integer PRIMARY KEY, 
	emailAddress varchar(50) NOT NULL,
	name varchar(50)
	);

CREATE TABLE PlayerGame (
	gameID integer REFERENCES Game(ID), 
	playerID integer REFERENCES Player(ID),
	score integer
	);

CREATE TABLE PlayerState (
	playerID integer REFERENCES Player(ID),
	gameID integer REFERENCES Game(ID),
    cash integer,
	position integer   -- board location
    );

CREATE TABLE Property (
	propertyID integer PRIMARY KEY,
	name varchar(50),
	cost integer,
	rent integer
    );

CREATE TABLE PlayerProperty (
	playerID integer REFERENCES Player(ID),
	gameID integer REFERENCES Game(ID),
    propertyID integer REFERENCES Property(propertyID),
	houses integer,
	hotels integer
    );

-- Allow users to select data from the tables.
GRANT SELECT ON Game TO PUBLIC;
GRANT SELECT ON Player TO PUBLIC;
GRANT SELECT ON PlayerGame TO PUBLIC;
GRANT SELECT ON PlayerState TO PUBLIC;
GRANT SELECT ON Property TO PUBLIC;
GRANT SELECT ON PlayerProperty TO PUBLIC;


-- Add sample records.
INSERT INTO Game VALUES (1, '2006-06-27 08:00:00');
INSERT INTO Game VALUES (2, '2006-06-28 13:20:00');
INSERT INTO Game VALUES (3, '2006-06-29 18:41:00');

INSERT INTO Player(ID, emailAddress) VALUES (1, 'me@calvin.edu');
INSERT INTO Player VALUES (2, 'king@gmail.edu', 'The King');
INSERT INTO Player VALUES (3, 'dog@gmail.edu', 'Dogbreath');

INSERT INTO PlayerGame VALUES (1, 1, 0.00);
INSERT INTO PlayerGame VALUES (1, 2, 0.00);
INSERT INTO PlayerGame VALUES (1, 3, 2350.00);
INSERT INTO PlayerGame VALUES (2, 1, 1000.00);
INSERT INTO PlayerGame VALUES (2, 2, 0.00);
INSERT INTO PlayerGame VALUES (2, 3, 500.00);
INSERT INTO PlayerGame VALUES (3, 2, 0.00);
INSERT INTO PlayerGame VALUES (3, 3, 5500.00);

INSERT INTO Property VALUES (1, 'Mediterranean Avenue',60,250);
INSERT INTO Property VALUES (2, 'Vermont Avenue',50,550);
INSERT INTO Property VALUES (3, 'NewYork Avenue',100,1000);
INSERT INTO Property VALUES (4, 'Broadwalk',400,200);
INSERT INTO Property VALUES (5, 'Pacific Avenue', 300, 1200);


INSERT INTO PlayerState VALUES (1,1,1200,5);
INSERT INTO PlayerState VALUES (2,1,800,10);
INSERT INTO PlayerState VALUES (3,1,2350,22);
INSERT INTO PlayerState VALUES (1,2,1000,18);
INSERT INTO PlayerState VALUES (2,2,1500,3);
INSERT INTO PlayerState VALUES (3,2,500,12);
INSERT INTO PlayerState VALUES (2,3,2000,18);
INSERT INTO PlayerState VALUES (3,3,5000,20);

INSERT INTO PlayerProperty VALUES (3,1,4,2,1);
INSERT INTO PlayerProperty VALUES (3,1,5,1,0);
INSERT INTO PlayerProperty VALUES (2,1,1,0,0);
INSERT INTO PlayerProperty VALUES (1,2,2,1,0);
INSERT INTO PlayerProperty VALUES (3,2,3,3,0);
INSERT INTO PlayerProperty VALUES (2,3,1,2,0);
INSERT INTO PlayerProperty VALUES (3,3,4,4,1);
INSERT INTO PlayerProperty VALUES (3,3,5,3,0);
