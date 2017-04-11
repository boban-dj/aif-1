#!/bin/bash

for i in $(ps x | grep Whatsapp | cut -d"?" -f1 | grep -v Whatsapp); do kill -9 $i ; done
