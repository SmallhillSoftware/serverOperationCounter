<?php
$opHours = "";
$opHoursMainboard = "";
$opHoursPowerSupply = "";
$opHoursHddA = "";
$opHoursHddB = "";
if ($opCounterFile = fopen("/YOURDIRECTORY/opHoursCounter.txt", "r"))
{
	while(!feof($opCounterFile))
	{
		$opCounterFileLine = fgets($opCounterFile, 4096);
		if(strpos($opCounterFileLine, "OperatingTimeHours") === 0)
		{
			$eqPos   = strpos($opCounterFileLine, "=");
			$lenLine = strlen($opCounterFileLine);			
			$opHours = substr($opCounterFileLine, ($eqPos+1), ($lenLine-($eqPos+1)));
			$opHours = htmlspecialchars($opHours);
		}
		if(strpos($opCounterFileLine, "MainboardOpHours") === 0)
		{
			$eqPos   = strpos($opCounterFileLine, "=");
			$lenLine = strlen($opCounterFileLine);			
			$opHoursMainboard = substr($opCounterFileLine, ($eqPos+1), ($lenLine-($eqPos+1)));
			$opHoursMainboard = htmlspecialchars($opHoursMainboard);
		}
		if(strpos($opCounterFileLine, "PowersupplyOpHours") === 0)
		{
			$eqPos   = strpos($opCounterFileLine, "=");
			$lenLine = strlen($opCounterFileLine);			
			$opHoursPowerSupply = substr($opCounterFileLine, ($eqPos+1), ($lenLine-($eqPos+1)));
			$opHoursPowerSupply = htmlspecialchars($opHoursPowerSupply);
		}		
		if(strpos($opCounterFileLine, "HddAOpHours") === 0)
		{
			$eqPos   = strpos($opCounterFileLine, "=");
			$lenLine = strlen($opCounterFileLine);			
			$opHoursHddA = substr($opCounterFileLine, ($eqPos+1), ($lenLine-($eqPos+1)));
			$opHoursHddA = htmlspecialchars($opHoursHddA);
		}		
		if(strpos($opCounterFileLine, "HddBOpHours") === 0)
		{
			$eqPos   = strpos($opCounterFileLine, "=");
			$lenLine = strlen($opCounterFileLine);			
			$opHoursHddB = substr($opCounterFileLine, ($eqPos+1), ($lenLine-($eqPos+1)));
			$opHoursHddB = htmlspecialchars($opHoursHddB);
		}
	}
fclose($opCounterFile);
}
echo "<html>";
echo "<head>";
echo "<title>Server - Operation Hours Page</title>";
echo "<meta name=\"description\" content=\"Server - Operation Hours Page\">";
echo "<meta name=\"author\" content=\"Stefan Kleineberg\" >";
echo "<meta name=\"keywords\" content=\"Administration Server, Temperature, Processor\">";
echo "<meta name=\"generator\" content=\"Bluefish 2.2.7\" >";
echo "</head>";
echo "<body bgcolor=\"#333333\" text=\"#ffff00\" link=\"#cccc00\" vlink=\"#99cc00\" alink=\"#993300\">";
echo "<font size=\"+2\"><b>Server - Operation Hours Page</b></font>";
echo "<br/>";
echo "<br/>";
echo "<table>";
echo "<tr>";
echo "<td colspan=\"2\" align=\"center\"><img src=\"serverInsidePic.jpg\" width=\"50%\" height=\"50%\" alt=\"serverInsidePic.jpg\"></td>";
echo "</tr>";
echo "<tr>";
echo "<td><img src=\"mainboardPic.jpg\" width=\"50%\" height=\"50%\" alt=\"mainboard.jpg\"></td>";
echo "<td><font color=\"#faf20c\">The mainboard was running for $opHoursMainboard hours.</font></td>";
echo "</tr>";
echo "<tr>";
echo "<td><img src=\"powersupplyPic.jpg\" width=\"50%\" height=\"50%\" alt=\"powersupplyPic.jpg\"></td>";
echo "<td><font color=\"#27f20c\">The power supply was running for $opHoursPowerSupply hours.</font></td>";
echo "</tr>";
echo "<tr>";
echo "<td><img src=\"harddiskAPic.jpg\" width=\"50%\" height=\"50%\" alt=\"harddiskAPic.jpg\"></td>";
echo "<td><font color=\"#f20cd2\">The harddisk A was running for $opHoursHddA hours.</font></td>";
echo "</tr>";
echo "<tr>";
echo "<td><img src=\"harddiskBPic.jpg\" width=\"50%\" height=\"50%\" alt=\"harddiskBPic.jpg\"></td>";
echo "<td><font color=\"#0bf2e4\">The harddisk B was running for $opHoursHddB hours.</font></td>";
echo "</tr>";
echo "</table>";
echo "&nbsp;<br>";
echo "<br>";
echo "<hr>";
echo "Layout updated on : <!--HTML-FORMAT:AUTO-TEXT-DATUM-->30.04.2020<!--/-->";
echo "</body>";
echo "</html>";
?>