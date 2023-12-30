#!/bin/bash
awk -F: '$3 > 999 && $1 != "root" {print $1}' /etc/passwd | xargs -I {} deluser --remove-home {}
