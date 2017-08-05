CREATE KEYSPACE IF NOT EXISTS airline WITH replication = {
  'class' : 'SimpleStrategy',
  'replication_factor' : 2
};

USE airline;

CREATE TABLE IF NOT EXISTS airport_carrier
		( 	airport text,
                     	carrier text,
			depdelay double,
                        PRIMARY KEY (airport, carrier)
                );
EXIT;
