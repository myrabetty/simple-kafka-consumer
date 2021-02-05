#!/usr/bin/env bash
# this script makes sure kafka topics are ready before starting the application.
function check_topic {
  echo "checking started for topic : $1 "

  # check that the topic exists
  kafka-topics.sh --bootstrap-server kafka:9092 --describe  --topic "$1"

  if [ $? -ne 0 ]; then
    return 1;
  fi

  # check that partitions have a leader (should be empty)
  has_partitions=$(kafka-topics.sh --bootstrap-server kafka:9092 --describe  --topic "$1" --unavailable-partitions)

  if [ $? -ne 0 ] || [ -n "$has_partitions" ] ; then
    return 1;
  fi

  # check that partitions are fully replicated (should be empty)
  has_replicas=$(kafka-topics.sh --bootstrap-server kafka:9092 --describe  --topic "$1" --under-replicated-partitions)

  if [ $? -ne 0 ] || [ -n "$has_replicas" ] ; then
    return 1;
  fi

}

for var in "$@"
do
  check_topic "$var"
  if [ $? -ne 0 ]; then
    exit 1;
  fi
done
