#!/bin/bash

list="/etc/apt/mirror.list"

export DEFAULTARCH=${DEFAULTARCH:-amd64}

envsubst < ${list}.template > ${list}

# Environment variables; helps build the /etc/apt/mirrors.list sources for you...
declare -a distros=(${MIRROR_DISTROS})
declare -a flavors=(${MIRROR_FLAVORS})
declare -a branches=(${MIRROR_BRANCHES})

for distro in "${distros[@]}"; do
  for flavor in "${flavors[@]}"; do
    echo "deb ${MIRROR_PROTO}://${MIRROR_HOST}/${distro} ${flavor} ${MIRROR_COMPONENTS}" | tee -a ${list}

    if [ ! -z ${MIRROR_INCLUDE_SOURCE} ]; then
      echo "deb-src ${MIRROR_PROTO}://${MIRROR_HOST}/${distro} ${flavor} ${MIRROR_COMPONENTS}" | tee -a ${list}
    fi

    for branch in "${branches[@]}"; do
      echo "deb ${MIRROR_PROTO}://${MIRROR_HOST}/${distro} ${flavor}-${branch} ${MIRROR_COMPONENTS}" | tee -a ${list}

      if [ ! -z ${MIRROR_INCLUDE_SOURCE} ]; then
        echo "deb-src ${MIRROR_PROTO}://${MIRROR_HOST}/${distro} ${flavor}-${branch} ${MIRROR_COMPONENTS}" | tee -a ${list}
      fi
    done
  done

  echo "clean ${MIRROR_PROTO}://${MIRROR_HOST}/${distro}" | tee -a ${list}
done

while true; do
  exec /usr/local/bin/apt-mirror
  echo "Sleeping for ${SLEEP_SECS}..."
  sleep ${SLEEP_SECS}
done
