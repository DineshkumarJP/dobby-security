#!/bin/bash

test_10() {
	local testid="Test10"
	local desc="Host Namespace is not shared"
	local check="$testid - $desc"
	local output

	output=$(ifconfig dobby0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
   
    if [ "$output" == "100.64.11.1"  ]; then
      pass "$check"
      return
    fi
    fail "$check"
}

test_11() {
	local testid="Test11"
	local desc="Memory limit of the container"
	local check="$testid - $desc"
	local output
  
	output=$(cat /sys/fs/cgroup/memory/$containername/memory.limit_in_bytes)
   
    if [ "$output" == "0"  ]; then
      fail "$check [ No Memory limit of the container]"
      return
    fi
    pass "$check"
}

test_12() {
	local testid="Test12"
	local desc="Host Process Namespace is not shared"
	local check="$testid - $desc"
	local output
  
	output=$(DobbyTool info $containername | jsonValue nsPid)
   
    if [ "$output" == "0"  ]; then
      fail "$check [ Host Process Namespace is set as root ]"
      return
    fi
    pass "$check"
}

test_13() {
	local testid="Test13"
	local desc="Host devices are not directly exposed to containers"
	local check="$testid - $desc"
	local output
  
	output=$(cat /sys/fs/cgroup/devices/$containername/devices.list)
   
    if [ "$output" == ""  ]; then
      pass "$check"
      return
    fi
    fail "$check [Container have access to host devices]"
}

test_14() {
	local testid="Test14"
	local desc="PIDs cgroup limit is used"
	local check="$testid - $desc"
	local output
  
	output=$(cat /sys/fs/cgroup/pids/$containername/pids.max)
   
    if [ "$output" == "max"  ]; then
      fail "$check [No limit is set]"
      return
    fi
    pass "$check"
}

test_15() {
	local testid="Test15"
	local desc="Default bridge 'dobby0' is not used"
	local check="$testid - $desc"
	local output
  
	output=$(brctl show | grep "dobby0" | awk '{ print $1}')
   
    if [ "$output" == "dobby0"  ]; then
      fail "$check [Default bridge is $output]"
      return
    fi
    pass "$check"
}
