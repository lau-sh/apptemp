# apptemp
Web application template image using Python 3, Flask, PostgreSQL, and nginx.

**Note:** This README is still very much a work-in-progress and will be missing
information.

## Initialization
To kick things up, begin by running the initialization script:

    ./bin/init.sh

The initialization step only needs to be done the first time the machine is set
up.  Afterwards, all the appropriate folders/dependencies should be in place.

Note that the `init.sh` script will only work on Ubuntu Linux machines.

## Build
To build the image, run the following script:

    ./bin/build.sh

This will generate an image of the entire web service.  This may be shown using
`docker ps`.

## Run Daemon
To run the web service, run the following script:

    ./bin/run.sh

You may see the status of the container of the service using `docker ps`, and
you may view the logs of the service by running `docker logs <service_name>`.

## Directory Structure
Under Construction...
