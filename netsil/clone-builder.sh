#!/bin/bash
BUILDER_BRANCH=${BUILDER_BRANCH:-"master"}
builder_dir=./netsil/netsil-builder
if [[ -d "${builder_dir}" ]] ; then
    cd ${builder_dir}
    git pull origin ${BUILDER_BRANCH} 
else
    git clone https://github.com/netsil/netsil-builder ${builder_dir}
fi

