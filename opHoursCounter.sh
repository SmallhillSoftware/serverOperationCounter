#!/bin/bash

# ***********************************************************************
# This script shall be called periodically for instance from cron.
# The periodicity shall be 'callDifferenceMinutes'.
# When the time difference between the current call time of the script
# end the value of the last call stored in the file 'opHoursCounter.txt'
# is within 'callDifferenceMinutes' + the timing tolerance 
# 'differenceToleranceMinutes' the operating time counter value inside
# the file 'opHoursCounter.txt' is increased by the time difference
# between the current call time of the script and the value of the last
# call. The current call time of the script is stored inside the file
# 'opHoursCounter.txt' in any case. The operating time counter is
# written on the command line in any case.
# S. Kleineberg / 2020                                          rev. 1.0 
# ***********************************************************************

opHoursCounterFile="opHoursCounter.txt"
currentDateTime=$(date +"%Y-%m-%d %H:%M:%S")
#echo "currentDateTime:$currentDateTime"
callDifferenceMinutes=60
differenceToleranceMinutes=5
totalDifferenceMinutes=$((callDifferenceMinutes+differenceToleranceMinutes))
if [ -f "$opHoursCounterFile" ]
then
	#echo "$opHoursCounterFile found."
	while read FILE_LINE
	do
		IFS='=' read -r -a SPLIT_ARRAY <<< "$FILE_LINE"
		if [[ ${SPLIT_ARRAY[0]}  =~ ^lastAcquisition ]]
		then
			lastAcqDateTime=${SPLIT_ARRAY[1]}
			#echo "lastAcqDateTime:$lastAcqDateTime"
		elif [[ ${SPLIT_ARRAY[0]}  =~ ^operatingTimeHours ]]
		then
			operatingTimeHours=${SPLIT_ARRAY[1]}
			#echo "operatingTimeHours:$operatingTimeHours"
		elif [[ ${SPLIT_ARRAY[0]}  =~ ^mainboardOpHours ]]
		then
			mainboardOpHours=${SPLIT_ARRAY[1]}
			#echo "mainboardOpHours:$mainboardOpHours"
		elif [[ ${SPLIT_ARRAY[0]}  =~ ^powersupplyOpHours ]]
		then
			powersupplyOpHours=${SPLIT_ARRAY[1]}
			#echo "powersupplyOpHours:$powersupplyOpHours"
		elif [[ ${SPLIT_ARRAY[0]}  =~ ^hddAOpHours ]]
		then
			hddAOpHours=${SPLIT_ARRAY[1]}
			#echo "hddAOpHours:$hddAOpHours"
		elif [[ ${SPLIT_ARRAY[0]}  =~ ^hddBOpHours ]]
		then
			hddBOpHours=${SPLIT_ARRAY[1]}
			#echo "hddBOpHours:$hddBOpHours"			
		fi
	done < $opHoursCounterFile
	assumedDiffToLastAcqTime=$(date --date="$lastAcqDateTime $totalDifferenceMinutes minutes" +"%Y-%m-%d %H:%M:%S")
	#echo "assumedDiffToLastAcqTime:$assumedDiffToLastAcqTime"
	durationSecondsAssumedNowToPreviousAcq=`date -ud@$(($(date -ud"$assumedDiffToLastAcqTime" +%s)-$(date -ud"$currentDateTime" +%s))) +%s`	
	#echo "durationSecondsAssumedNowToPreviousAcq:$durationSecondsAssumedNowToPreviousAcq"	
	line1="lastAcquisition=$currentDateTime"	
	if [ $durationSecondsAssumedNowToPreviousAcq -ge $(($differenceToleranceMinutes*60)) ];
	then
		durationSecondsNowToPreviousAcq=`date -ud@$(($(date -ud"$currentDateTime" +%s)-$(date -ud"$lastAcqDateTime" +%s))) +%s`		
		durationHoursNowToPreviousAcq=$(bc <<<"scale=2; $durationSecondsNowToPreviousAcq / 3600")
		#echo "durationHoursNowToPreviousAcq:$durationHoursNowToPreviousAcq"
		operatingTimeHours=$(bc <<<"scale=2; $operatingTimeHours + $durationHoursNowToPreviousAcq")
		mainboardOpHours=$(bc <<<"scale=2; $mainboardOpHours + $durationHoursNowToPreviousAcq")
		powersupplyOpHours=$(bc <<<"scale=2; $powersupplyOpHours + $durationHoursNowToPreviousAcq")
		hddAOpHours=$(bc <<<"scale=2; $hddAOpHours + $durationHoursNowToPreviousAcq")
		hddBOpHours=$(bc <<<"scale=2; $hddBOpHours + $durationHoursNowToPreviousAcq")
		#echo "increasing operatingTimeHours by durationHoursNowToPreviousAcq"
		line2="operatingTimeHours=$operatingTimeHours"
		line3="mainboardOpHours=$mainboardOpHours"
		line4="powersupplyOpHours=$powersupplyOpHours"
		line5="hddAOpHours=$hddAOpHours"
		line6="hddBOpHours=$hddBOpHours"
	else
		#echo "keeping last operatingTimeHours"		
		line2="operatingTimeHours=$operatingTimeHours"
		line3="mainboardOpHours=$mainboardOpHours"
		line4="powersupplyOpHours=$powersupplyOpHours"
		line5="hddAOpHours=$hddAOpHours"
		line6="hddBOpHours=$hddBOpHours"
	fi
	/bin/cat <<EOM >$opHoursCounterFile
$line1
$line2
$line3
$line4
$line5
$line6
EOM
else #else-branch of if [ -f "$opHoursCounterFile" ]
	#echo "$opHoursCounterFile not found."
	line1="lastAcquisition=$currentDateTime"
	line2="operatingTimeHours=0"
	line3="mainboardOpHours=0"
	line4="powersupplyOpHours=0"
	line5="hddAOpHours=0"
	line6="hddBOpHours=0"
	/bin/cat <<EOM >$opHoursCounterFile
$line1
$line2
$line3
$line4
$line5
$line6
EOM
fi #end of if [ -f "$opHoursCounterFile" ]
echo "$operatingTimeHours"