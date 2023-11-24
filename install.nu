#!/usr/bin/env nu

if (which brew | is-empty) {
  print -n "Missing brew bin\n"
  exit 1
}

def main [] {
  let config = "/Users/o0th/.config"

  #
  # karabiner
  #

  print -n "karabiner\n"

  let karabiner_destination = $"($config)/karabiner"
  let karabiner_source = $"($env.PWD)/.config/karabiner"

  let operation = (brew info karabiner-elements | complete)
  if ($operation | get exit_code) != 0 {
    print -n "Installing karabiner\n"
    let operation = (brew install --cask karabiner-elements | complete)
    if ($operation | get exit_code) != 0 {
      print -n $"Failed to install karabiner\n"
      exit 1
    }
  }

  if ($karabiner_destination | path exists) {
    print -n $"Removing directory ($karabiner_destination)\n"
    let operation = (^rm -rfd ($karabiner_destination) | complete)
    if ($operation | get exit_code) != 0 {
      print -n $"Failed to remove directory $(karabiner_destination)\n"
      exit 1
    }
  }

  print -n $"Creating directory ($karabiner_destination)\n"
  let operation = (^ln -s ($karabiner_source) ($karabiner_destination) | complete)
  if ($operation | get exit_code) != 0 {
    print -n $"Failed to create directory $(karabiner)\n"
    exit 1
  }
}
