#!/bin/bash

  CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
  NANO_END_POINT_FILE="$CURRENT_PATH/conf/nanoEndpoint"
    
  if [ -f $NANO_END_POINT_FILE ] ; then
    
    FIRST_END_POINT=$(head -n 1 $NANO_END_POINT_FILE )

    IFS=’:’ read -ra INFO_NANO <<< "$FIRST_END_POINT" 
    NANO_END_POINT_IP=${INFO_NANO[1]}
    NANO_END_POINT_PORT=${INFO_NANO[2]}
            
    ENDPOINT="http://$NANO_END_POINT_IP:$NANO_END_POINT_PORT/bigdata/sparql"
    
    tput setaf 2
  	echo 
  	echo "----------------------------------------------------- "
  	echo "## Query Demo usning Curl ##                          "
  	echo "----------------------------- "
  	echo
  	echo " EndPoint : $ENDPOINT                                 "
  	echo
  	echo "----------------------------------------------------- "
  	echo 
  	sleep 2
  	tput setaf 7
  	
    curl -X POST $ENDPOINT --data-urlencode \
    'query=PREFIX : <http://www.anaee/fr/soere/ola#> 
     PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
     PREFIX oboe-core: <http://ecoinformatics.org/oboe/oboe.1.0/oboe-core.owl#>
      SELECT ?uri ?unite {
     	 ?uri a oboe-core:Measurement .
   	   ?uri oboe-core:hasValue ?unite
    }
   ' \
   -H 'Accept:application/json'
   
  else 
        
   echo " Oupss, config missed !! "
 
  fi
    
    
    
