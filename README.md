# ChemotionDeploy
Script to deploy chemotion and other necessary indication to have an accessible chemotion for ICIQ researchers

# Characteristics
The script has been written in BASH and has been tested on Ubuntu 20.04 LTS.
The script uses `docker-compose create` followed by `docker-coompose -d up` so containers are initialized in background.
The script has the following dependencies, which are installed if not present: 
* `docker`
* `docker-compose`
* `wget`

The script can be run as root or normal user, but in normal user usage we will be using sudo to get administrative privileges

# Usage

**Note: Make sure that you have enough space in your machine! About 2 GB.**

Use the following BASH instructions to download and run the contents of this repository:

```
git clone https://github.com/Institut-Catala-d-Investigacio-Quimica/ChemotionDeploy
cd "ChemotionDeploy"
./deploy.sh
```
