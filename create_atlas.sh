#!/bin/bash
shopt -s expand_aliases
source ~/.fsl_inte 

mkdir atlas

#To run this fslmerge command you have to run reg2atlas.sh script before. Register all subject's anatomy files to atlas and then you can merge T1w.nii.gz images to create atlas for six subjects.
fslmerge -t atlas/atlas_init_4D sub001/anatomy/T1w.nii.gz sub002/anatomy/T1w.nii.gz sub003/anatomy/T1w.nii.gz sub004/anatomy/T1w.nii.gz sub005/anatomy/T1w.nii.gz sub006/anatomy/T1w.nii.gz

fslmaths atlas/atlas_init_4D.nii.gz -Tmean atlas_init

fslswapdim atlas/atlas_init -x y z atlas_init_flipped

fslmaths atlas/atlas_init -add atlas_init_flipped.nii.gz -div 2 atlas_flirt