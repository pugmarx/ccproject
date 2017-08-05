CREATE KEYSPACE IF NOT EXISTS airline WITH replication = {
  'class' : 'SimpleStrategy',
  'replication_factor' : 2
};

USE airline;

CREATE TABLE IF NOT EXISTS airport_destination
		( 	airport text,
                     	destination text,
			depdelay double,
			PRIMARY KEY (airport, depdelay, destination)
                );
EXIT;
