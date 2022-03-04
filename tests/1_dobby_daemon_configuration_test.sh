#!/bin/bash

test_2_1() {
  local testid="2.1"
  local desc="Run the Dobby daemon as a non-root user, if possible"
  local check="$testid - $desc"
  local output
  
  output=$(ps -fe | grep "DobbyDeamon"| awk '{print $1}')
  if [ "$output" == "root" ]; then
      warn "$check"
	  return
  fi
  pass "$check"
}


test_2_9() {
	local testid="2.9"
	local desc="Enable user namespace support"
	local check="$testid - $desc"
	local child_pid
	local DobbyInit_PID
	local output
  
	DobbyInit_PID=$(ps -fe | grep DobbyInit | grep $containername | awk '{print $2}')
	
	child_pid=$(ps h --ppid $DobbyInit_PID -o pid | sed 's/ //g')

	output=$(cat /proc/$child_pid/status | grep '^Uid:' | awk '{print $3}')
   
    if [ "$output" == "0"  ]; then
      fail "$check"
      return
    fi
    pass "$check"
}
