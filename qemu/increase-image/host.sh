#!/usr/bin/env bash
SIZE_TO_INCREASE=$2
qemu-img resize $1 +$SIZE_TO_INCREASE 
