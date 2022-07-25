#!/usr/bin/env bash

main()
{
  wget https://raw.githubusercontent.com/ptrxyz/chemotion/latest-release/docker-compose.yml
}

CURRENT_DIR="$(pwd)
export PROJECT_FOLDER="$(cd "$(dirname "$(realpath "$0")")" &>/dev/null && pwd)"
cd "${PROJECT_FOLDER}"
main "$@"
cd "${CURRENT_DIR}"