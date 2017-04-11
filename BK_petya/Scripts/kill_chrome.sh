#!/bin/bash

for i in $(ps x | grep chrome | cut -d"?" -f1 | grep -v chrome); do kill -9 $i ; done
rm -R /home/boban/.cache/google-chrome/*
