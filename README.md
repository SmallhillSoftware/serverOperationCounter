# ***********************************************************************
# The BASH-script opHoursCounter.sh counts the approximated run time of
# HW-components inside a server that is running 24/7. Usual candidates
# of these HW-components are harddisks, the mainboard, the power supply.
# The values are stored inside a text file and could be visualized by
# a PHP-script for instance. An example for such a PHP-file is also
# available here.
# The BASH-script opHoursCounter.sh shall be called periodically for
# instance from cron. The periodicity shall be 'callDifferenceMinutes' a
# parameter inside the script.
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
