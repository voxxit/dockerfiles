#!/usr/bin/env bats

@test "container should have a bats binary" {
  run bats -v
  [ $status -eq 0 ]
}

@test "container should have a gosu binary" {
  run gosu
  [ $status -eq 1 ]
}
