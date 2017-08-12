# oracle-inventory-converter


Here's how to use it: paste the attached code into a file and name it something like sort_oracle.sh
it needs a file for input such as the sample_tnsnames.ora you sent. so run this:

./sort_oracle.sh sample_tnsnames.ora.sh

That will put everything in the file in csv format.

if you want to exclude everything that's optional use -h

./sort_oracle.sh sample_tnsnames.ora -h

if you want to exclude separate things use these options:

-d   QueueSize [Optional]
-e    Server [Optional]
-f     SID [Optional]
-g    ServiceName [Optional]
