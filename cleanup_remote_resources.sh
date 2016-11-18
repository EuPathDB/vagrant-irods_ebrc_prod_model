#!/bin/bash

# The box comes with remote resources on rs1.irods.vm but
# that VM is not managed by this Vagrant project. This causes
# distracting 'hostname unknown' messages in the iRODS server log. So,
# remove those obsolete rs1 resources.

if su - irods -c "ilsresc repl 1>/dev/null"; then
  for RESC in data_7k_003 data_7k_004; do
    if su - irods -c "ilsresc repl | grep -q $RESC"; then
      echo "dechild obsolete $RESC resource"
      su - irods -c "iadmin rmchildfromresc repl $RESC"
    fi
    if su - irods -c "ilsresc $RESC 1>/dev/null"; then
      echo "removing obsolete $RESC resource"
      su - irods -c "iadmin rmresc $RESC"
    fi
  done
  echo "removing obsolete repl resource"
  su - irods -c "iadmin rmresc repl"
fi
