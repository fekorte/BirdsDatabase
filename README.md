# BirdsDatabase

Project for the uni (database classes), created together with @KaZebra. 
Based on the "Hour of the Garden Birds" campaign by the NABU. A participant reports to the NABU how many and which kind of birds he or she observed during one hour. 

Tables for: Participants, observation site, bird species, annual result, observation, individual observation.
The table durchgeführtVonAmOrt (= performedByOnPlace) contains information about the observation, the individual and the observation site and displays a grade three relationship.

Several attributes are being created by trigger functions (all attributes in the annual result table and vögelGesamt (= birdsTotal) in the observation table).
The script insertStatements contains example data. 
The script SQLQueries contains example queries.

We used pgAdmin and PostgreSQL.
