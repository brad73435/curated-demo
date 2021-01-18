
function mn-rename {
   for e in `docker ps --filter "ancestor=ghcr.io/tatarsky/gns3/cnhost:0.1" -q ` 
     do 
     docker rename $e `docker exec $e hostname` 
    done
   for e in `docker ps --filter "ancestor=gns3/endhost" -q ` 
     do 
     docker rename $e `docker exec $e hostname` 
    done
   for e in `docker ps --filter "ancestor=ghcr.io/tatarsky/gns3/openvswitch28:0.1" -q ` 
     do 
     docker rename $e `docker exec $e hostname` 
    done
   for e in `docker ps --filter "ancestor=ghcr.io/tatarsky/gns3/controller:0.1" -q ` 
     do 
     docker rename $e `docker exec $e hostname` 
    done
   # Probably should warn if somehow both are running
   for e in `docker ps --filter "ancestor=ghcr.io/tatarsky/gns3/controllerprod:0.1" -q ` 
     do 
     docker rename $e `docker exec $e hostname` 
    done
   for e in `docker ps --filter "ancestor=ghcr.io/tatarsky/gns3/router:0.1" -q ` 
     do 
     docker rename $e `docker exec $e hostname` 
    done
# Alias all named images with shortcut -it aliases
# if command doesn't been a pty it doesn't matter
   for cn in `docker ps --format "{{.Names}}"`;do alias "$cn"="docker exec -it $cn" ;done
}

function mn-alias {
   for cn in `docker ps --format "{{.Names}}"`;do alias "$cn"="docker exec -it $cn" ;done
}

function iperf-pair {
  echo run iperf on $2:$3
  docker exec $2 iperf -V -D -s  -p $3
  echo client on $1
  docker exec $1 iperf -c $2 -p $3
}

function iperf-pair6 {
  echo run iperf on $2:$3
  docker exec $2 iperf -V -D -s  -p $3
  echo client on $1
  docker exec $1 iperf -V -c "$2"-6 -p $3
}

