USE airline;

COPY airport_dest_delay (airport, destination, delay) FROM '../results/G2_Q4.csv';

EXIT;
