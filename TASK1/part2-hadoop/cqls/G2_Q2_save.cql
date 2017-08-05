USE airline;

COPY airport_destination (airport, destination, depdelay) FROM '../results/G2_Q2.csv';

EXIT;
