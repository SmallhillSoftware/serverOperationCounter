#!/bin/bash

opHoursCounterFile="opHoursCounter.txt"
currentDateTime=$(date +"%Y-%m-%d %H:%M:%S")
echo "currentDateTime:$currentDateTime"
callDifferenceMinutes=60
differenceToleranceMinutes=5
totalDifferenceMinutes=$((callDifferenceMinutes+differenceToleranceMinutes))
if [ -f "$opHoursCounterFile" ]
then
	echo "$opHoursCounterFile found."
	while read FILE_LINE
	do
		IFS='=' read -r -a SPLIT_ARRAY <<< "$FILE_LINE"
		if [[ ${SPLIT_ARRAY[0]}  =~ ^lastAcquisition ]]
		then
			lastAcqDateTime=${SPLIT_ARRAY[1]}
			echo "lastAcqDateTime:$lastAcqDateTime"
		elif [[ ${SPLIT_ARRAY[0]}  =~ ^operatingTimeMinutes ]]
		then
			lastOperatingTimeMinutes=${SPLIT_ARRAY[1]}
			echo "lastOperatingTimeMinutes:$lastOperatingTimeMinutes"
		fi
	done < $opHoursCounterFile
	assumedDiffToLastAcqTime=$(date --date="$lastAcqDateTime $totalDifferenceMinutes minutes" +"%Y-%m-%d %H:%M:%S")
	echo "assumedDiffToLastAcqTime:$assumedDiffToLastAcqTime"
	currentDateTimeUTS=$(date --date="currentDateTime" +"%s")
	assumedDiffToLastAcqTimeUTS=$(date --date="assumedDiffToLastAcqTime" +"%s")
	if [ $currentDateTimeUTS -le $assumedDiffToLastAcqTimeUTS ];
	then
		increaseOpHoursCounter=1
	else
		increaseOpHoursCounter=0
	fi
	echo "increaseOpHoursCounter:$increaseOpHoursCounter"
else #else-branch of if [ -f "$opHoursCounterFile" ]
	echo "$opHoursCounterFile not found."
	line1="lastAcquisition=$currentDateTime"
	line2="operatingTimeMinutes=0"
	/bin/cat <<EOM >$opHoursCounterFile
$line1
$line2
EOM
fi #end of if [ -f "$opHoursCounterFile" ]