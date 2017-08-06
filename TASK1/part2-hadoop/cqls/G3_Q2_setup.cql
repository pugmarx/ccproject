CREATE KEYSPACE IF NOT EXISTS airline WITH replication = {
  'class' : 'SimpleStrategy',
  'replication_factor' : 2
};

USE airline;

CREATE TABLE IF NOT EXISTS airport_connect
		( 	origin text,
			transit text,
                     	destination text,
			startdate timestamp,
			leg text,
			delay int,
			carrier text,
			fltnum text,
			depdate timestamp,
			deptime text,
			PRIMARY KEY (origin, transit, destination, startdate, leg)
                );
EXIT;
