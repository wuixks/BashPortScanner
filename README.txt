CPSC 42700 Project 1: Bash Port Scanner
Michael Wallin
Feb 4, 2025

NAME
	portscanner.sh
	
USAGE
	./portscanner.sh [-t timeout] [host startport stopport]
	
DESCRIPTION
	This is a simple portscanner that will scan a range of ports inputed by the user or a predifined range on a file that the user could upload. 
	
COMMAND-LINE OPTIONS
    host
        The hostname or IP address of the target system to scan.

    startport
        The starting port number of the range to be scanned.

    stopport
        The ending port number of the range to be scanned. 
    
    -t timeout 
    		Sets a timeout interval for the port scanner (default is 2 seconds)

INPUT FILE FORMAT
	[host startport stopport]
	example: google.com 74 83
	
	Optionally: [-t timeout] [host startport stopport]
	example: -3 google.com 74 83

KNOWN BUGS AND LIMITATIONS
	Since this is a simple port scanner you cannot scan private ips, invalid ips, or IPv6.
	When the user enters a cat command the banner: "No hostname provided. Enter hostname, start port, and stop port.
	Enter hostname (or press Enter to quit): " will pop up
	
ADDITIONAL NOTES
		does not recongnized Yahoo.com, so I used google.com instead for testing
