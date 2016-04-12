#!/bin/bash


export FILE_DIR="/var/lib/postgresql/9.4/main/pg_log/"
export FILE_PRE="postgresql"
export DATE=`date +"%Y-%m-%d_*.csv"`
export DB_NAME="postgres"
export DB_USER="postgres"
export DB_IP="10.2.5.116"
export DB_PORT="5432"
export DATE_TIME=`date +"%Y-%m-%d_%H:%M:%S"`

#########################################################################
# description: import csv file to table
# date:2016-03-23
# levi 
#########################################################################



if [ -d $FILE_DIR ]; then

     FILE_NAME=$(ls $FILE_DIR -lrt | tail -l | awk 'END {print $NF}')

     echo "filelist is  $FILE_NAME"  
     echo "begining to connect the database..."
     echo "begining time is:$DATE_TIME" 
     /usr/bin/expect <<-EOF
     
     spawn psql  -h $DB_IP -p $DB_PORT -U $DB_USER -W  -d $DB_NAME -c "COPY postgres_log FROM '$FILE_DIR$FILE_NAME'  WITH csv;" 
         
     expect "Password for user postgres: "
     send "postgres\n"
      
     expect eof 
    
EOF
    

fi

