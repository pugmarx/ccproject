USE airline;

COPY airport_carrier (airport, carrier, depdelay) FROM '../results/G2_Q1.csv';

EXIT;
