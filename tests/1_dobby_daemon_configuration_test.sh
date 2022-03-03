#!/bin/bash

test_1() {
  local testid="Test1"
  local desc="Run the DobbyDaemon as non-root user"
  local check="$testid - $desc"
  local output
  
  output=$(ps -fe | grep "DobbyDeamon"| awk '{print $1}')
  if [ "$output" == "root" ]; then
      warn "$check [DobbyDeamon running as root]"
	  return
  fi
  pass "$check"
}


test_2() {
	local testid="Test2"
	local desc="User Namespace Support"
	local check="$testid - $desc"
	local child_pid
	local DobbyInit_PID
	local output
  
	DobbyInit_PID=$(ps -fe | grep DobbyInit | grep $containername | awk '{print $2}')
	
	child_pid=$(ps h --ppid $DobbyInit_PID -o pid | sed 's/ //g')

	output=$(cat /proc/$child_pid/status | grep '^Uid:' | awk '{print $3}')
   
    if [ "$output" == "0"  ]; then
      fail "$check [Namespace PID set as root]"
      return
    fi
    pass "$check"
}
