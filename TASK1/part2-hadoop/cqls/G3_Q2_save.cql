USE airline;

COPY airport_connect (origin, transit, destination, startdate, leg, delay, carrier, fltnum, depdate, deptime ) FROM '../results/G3_Q2.csv';

EXIT;
