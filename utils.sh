#!/bin/sh

function log() {
  echo "$(date -Isecond) $*"
}

function info() {
  log "[INFO]" $*
}

function warning() {
  log "[WARNING]" $*
}

function error() {
  log "[ERROR]" $*
}

function debug() {
  if [ -n "${CS_DEBUG}" ]; then
    log "[DEBUG]" $*
  fi
}


