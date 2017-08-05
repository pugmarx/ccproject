CREATE KEYSPACE IF NOT EXISTS airline WITH replication = {
  'class' : 'SimpleStrategy',
  'replication_factor' : 2
};

USE airline;

CREATE TABLE IF NOT EXISTS airport_dest_delay
		( 	airport text,
                     	destination text,
			delay double,
			PRIMARY KEY (airport, destination, delay)
                );
EXIT;
