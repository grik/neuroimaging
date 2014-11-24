#!/bin/bash
# Use this script to calculate SNR's and echo it to the terminal

#specify the subject:
lista=$( ls -1 | grep "sub001")

#to do it for all subject uncomment the following line:
#lista=$( ls -1 | grep "sub")

for osoba in $lista
do

	cd $osoba/BOLD

	echo $osoba
    #runs=$( ls -1 | grep "run001")
    runs=$( ls -1 | grep "run")

	for run in $runs
	do

		cd $run

		rm -fr Preprocessing
		mkdir Preprocessing
		bet bold Preprocessing/brain -m -f 0.3

		mcflirt -in bold -out Preprocessing/mc -plots -stats

		fslmaths Preprocessing/mc -mas Preprocessing/brain_mask -ing 1000 Preprocessing/norm

		fslmaths Preprocessing/norm -Tmean Preprocessing/mean
		fslmaths Preprocessing/norm -Tstd Preprocessing/std

		fslmaths Preprocessing/mean -div Preprocessing/std Preprocessing/snr
		
		snr=$(fslstats Preprocessing/snr -k Preprocessing/brain_mask -M)	
		echo $run":"$snr

		cd ..

	done

	cd ../..

done
