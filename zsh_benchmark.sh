#!/bin/bash

# Execute 10 times in 1 second intervals and then wait 10 seconds in order to
# bring machine to reference state
echo "Prepping system..."
for i in {1..10}; do
  ${SHELL} -i -c "exit"
  sleep 1
done
echo "System prepped! Benchmark starting in 10..."

sleep 1
for i in {9..1}; do
  echo "${i}..."
  sleep 1
done

echo "Running benchmark for 10 seconds..."
benchmark_end_time="$(gdate -d "${date} + 10 seconds" +"%T.%N")"

iterations=0
while [[ "$(gdate +"%T.%N")" < "${benchmark_end_time}" ]]; do
  ${SHELL} -i -c "exit"
  if [[ "$(gdate +"%T.%N")" < "${benchmark_end_time}" ]]; then
    (( iterations++ ))
  fi
done

average_execution_time=$(echo "scale=3; 10 / ${iterations}" | bc)
echo "Completed ${iterations} iterations in 10 seconds."
echo "Average execution time: ${average_execution_time} seconds"
