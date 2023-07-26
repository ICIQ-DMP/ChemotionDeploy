#!/usr/bin/env bash


# Description: Ensures that a dependency (package) is present
# Arguments:
# - Argument 1: Dependency to ensure.
ensure_dependency()
{
  # If $1 dependency is not present 
  if ! command -v "$1" &>/dev/null; then
    if isRoot; then 
      ${PACKAGE_MANAGER_INSTALL} "$1"
    else 
      # We are not root and dependency is not available, install using root
      echo
      echo "Introduce password to install $1 if asked"
      sudo ${PACKAGE_MANAGER_INSTALL} "$1"
    fi 
  fi 
}


# Description: Returns true (0) if the user executing the code is root and false (1) otherwise. 
# Arguments:
# - Argument 1: Dependency to ensure.
isRoot()
{
  if [ "${EUID}" == 0 ]; then
    return 0
  else
    return 1
  fi
}


# Description: Ensure all depenendcies for Chemotion software, deploys the Chemotion instance, runs it and shows it using the browser.
main()
{
  dependencies=("wget" "docker" "docker-compose")
  for dependency in ${dependencies[@]}; do 
    ensure_dependency "${dependency}"
  done

  # Download the docker-compose file 
  echo
  echo "Downloading docker compose file"
  rm -f "${PROJECT_FOLDER}/docker-compose.yml*"
  wget -q --show-progress https://raw.githubusercontent.com/ptrxyz/chemotion/cb906ce8d37e0a173ae66b3696a9f039f540eace/docker-compose.yml -O "${PROJECT_FOLDER}/docker-compose.yml"

  # Run it using docker-compose, depending on our privileges
  if isRoot; then 
    docker-compose create
    docker-compose -d up
  else 
    echo
    echo "Introduce password to create container if asked"
    sudo docker-compose create
    echo "Introduce password to deploy container if asked"
    sudo docker-compose -d up
  fi 

  # Shows it in the browser, after active waiting
  echo
  echo "Chemotion will be opened in the browser"

  # Use xdg if available, if not use firefox, which is usually present in Linux systems
  if command -v "xdg-open" &>/dev/null; then
    xdg-open "http://localhost:4000/"
  else 
    firefox "http://localhost:4000/"
  fi 
}



CURRENT_DIR="$(pwd)"
PROJECT_FOLDER="$(cd "$(dirname "$(realpath "$0")")" &>/dev/null && pwd)"
PACKAGE_MANAGER_INSTALL="apt-get install -y"

cd "${PROJECT_FOLDER}"
main "$@"
cd "${CURRENT_DIR}"

exit 0
