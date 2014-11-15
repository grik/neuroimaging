#!/bin/bash

lista=$(ls -1 | grep "sub00")

for i in $lista
do

    cd $i/anatomy
    
    flirt -in highres001.nii.gz -ref $FSLDIR/data/standard/MNI152_T1_2mm -out T1w -omat T1w.mat -cost mutualinfo -dof 12 -interp spline
    
    cd ../..

done
