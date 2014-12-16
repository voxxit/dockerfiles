#!/usr/bin/env bats

@test "container should have a bats binary" {
  run bats -v
  [ $status -eq 0 ]
  [ $(expr "$output" : "Bats [0-9][0-9.]*") -ne 0 ]
}
