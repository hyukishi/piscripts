#!/bin/bash
# Created by Jeffery Grantham 1/8/2019
# Usage: piholeimgmount.sh [image]

image=$1

mount -o loop,offset=50331648 $image /mnt/loop/
