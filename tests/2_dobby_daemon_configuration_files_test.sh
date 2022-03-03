#!/bin/bash

test_3() {
  local testid="Test3"
  local desc="dobby.service file ownership is set to root:root"
  local check="$testid - $desc"
  local file

  file="/lib/systemd/system/dobby.service"
  
  if [ -f $file ]; then
    if [ "$(stat -c %u%g "$file")" -eq 00 ]; then
      pass "$check"
      return
    fi
    fail "$check Wrong ownership for $file"
    return
  fi
  
  warn "$check [ $file file is not found]"
}

test_4() {
  local testid="Test4"
  local desc="dobby.service file permission is set to 644"
  local check="$testid - $desc"
  local file

  file="/lib/systemd/system/dobby.service"
  
  if [ -f $file ]; then
    if [ "$(stat -c %a "$file")" -le 644 ]; then
      pass "$check"
      return
    fi
    fail "$check [Wrong ownership]"
    return
  fi
  
  warn "$check [ $file file is not found]"
}

test_5() {
  local testid="Test5"
  local desc="dobbyPty.sock file ownership is set to root:root"
  local check="$testid - $desc"
 
    if [ "$(stat -c %u%g "/tmp/dobbyPty.sock")" -eq 00 ]; then
      pass "$check"
      return
    fi
    fail "$check [Wrong ownership]"
}

test_6() {
  local testid="Test6"
  local desc="dobbyPty.sock file permission is set to 644"
  local check="$testid - $desc"

    if [ "$(stat -c %a "/tmp/dobbyPty.sock")" -le 644 ]; then
      pass "$check"
      return
    fi
    fail "$check [Wrong ownership]"
}

test_7() {
  local testid="Test7"
  local desc="dobby.json file ownership is set to root:root"
  local check="$testid - $desc"
  local file

  file="/etc/dobby.json"
  
  if [ -f $file ]; then
    if [ "$(stat -c %u%g "$file")" -eq 00 ]; then
      pass "$check"
      return
    fi
    fail "$check [Wrong ownership]"
    return
  fi
  
  warn "$check [ $file file is not found]"
}

test_8() {
  local testid="Test8"
  local desc="dobby.json file permission is set to 644"
  local check="$testid - $desc"
  local file

  file="/etc/dobby.json"
  
  if [ -f $file ]; then
    if [ "$(stat -c %a "$file")" -le 644 ]; then
      pass "$check"
      return
    fi
    fail "$check [Wrong ownership]"
    return
  fi
  
  warn "$check [ $file file is not found]"
}
