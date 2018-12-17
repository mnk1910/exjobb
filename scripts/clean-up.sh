#!/bin/bash

[[ $(helm list wp-k8s --short | wc -l) -eq 1 ]] && helm delete --purge wp-k8s && kubectl delete pvc --all && kubectl delete pv --all

exit 0
