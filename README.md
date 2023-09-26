# devops_playground

A small collection of DevOps tasks. Scripts for working with system information and Docker.

1. [Part 1 - Simple Bash Scripts](#part-1---simple-bash-scripts)

    1.1. [First effort](#part-11-first-effort)  
    1.2. [System research](#part-12-system-research)  
    1.3. [Visual output design for the system research script](#part-13-visual-output-design-for-the-system-research-script)   
    1.4. [Configuring visual output design for the system research script](#part-14-configuring-visual-output-design-for-the-system-research-script)  
    1.5. [File system research](#part-15-file-system-research) 

2. [Part 2 - Work With File System](#part-2---work-with-file-system)

    2.1. [File generator](#part-21-file-generator)  
    2.2. [File system clogging](#part-22-file-system-clogging)  
    2.3. [Cleaning the file system](#part-23-cleaning-the-file-system)  
    2.4. [Log generator](#part-24-log-generator)  
    2.5. [Monitoring](#part-25-monitoring)  
    2.6. [GoAccess](#part-26-goaccess)  
    2.7. [Prometheus, Grafana and my own script](#part-27-prometheus-grafana-and-my-own-script) 

3. [Part 3. Basic Docker Compose with mini server inside nginx](#Part-3-basic-docker-compose-with-mini-server-inside-nginx)

## Part 1 - Simple Bash Scripts

## Part 1.1 First effort
**Task:**

+ Write a bash script. The script is run with one parameter. It is a text parameter.  
+ The script outputs the value of the parameter.  
+ If the parameter is a number, the script must output an invalid input message.

## Part 1.2. System research
**Task:**

+ Write a bash script. The script should output the following information:

**HOSTNAME** = _network name_  
**TIMEZONE** = _time zone as: **America/New_York UTC -5** (time zone must be taken from the system and be correct for the current location)_  
**USER** = _current user who ran the script_  
**OS** = _type and version of operating system_  
**DATE** = _current time as: **12 May 2020 12:24:36**_  
**UPTIME** = _system uptime_  
**UPTIME_SEC** = _system uptime in seconds_  
**IP** = _ip address of the machine on any of the network interfaces  
**MASK** = _network mask of any of the network interfaces as: **xxx.xxx.xxx.xxx**_.  
**GATEWAY** = _default gateway ip_  
**RAM_TOTAL** = _main memory size in GB with an accuracy of three decimal places as: **3.125 GB**_  
**RAM_USED** = _used memory size in GB with an accuracy of three decimal places_  
**RAM_FREE** = _free memory size in GB, with an accuracy of three decimal places_  
**SPACE_ROOT** = _root partition size in MB, with an accuracy of two decimal places, as **254.25 MB**_  
**SPACE_ROOT_USED** = _size of used space of the root partition in MB, with an accuracy of two decimal places_  
**SPACE_ROOT_FREE** = _size of free space of the root partition in MB, with an accuracy of two decimal places_

+ After outputting the values, suggest writing the data to a file (ask the user to answer **Y/N**).  
Responses **Y** and **y** are considered positive, all others - negative.

+ If the user agrees, create a file in the current directory containing the information that had been outputted.
The file name must looks like: **DD_MM_YY_HH_MM_SS.status** (The time in the file name must indicate when the data was saved).

## Part 1.3. Visual output design for the system research script
**Task:**

+ Write a bash script. Use the script from [**Part 1.2**](#part-12-system-research) and remove the part where the data is saved to a file.  The script is run with 4 parameters. The parameters are numeric. From 1 to 6, for example:  
`script03.sh 1 3 4 5`

+ Color designations: (1 - white, 2 - red, 3 - green, 4 - blue, 5 - purple, 6 - black)

**Parameter 1** is the background of the value names (HOSTNAME, TIMEZONE, USER etc.)  
**Parameter 2** is the font color of the value names (HOSTNAME, TIMEZONE, USER etc.)  
**Parameter 3** is the background of the values (after the '=' sign)  
**Parameter 4** is the font color of the values (after the '=' sign)

+ The font and background colors of one column must not match.  
If matching values are entered, there must be a message describing the problem and offering to call the script again.
After the message output, the program should exit correctly.

## Part 1.4. Configuring visual output design for the system research script
**Task:**

+ Write a bash script. Use the script from [**Part 1.3.**](#part-13-visual-output-design-for-the-system-research-script). The color designations are similar. The script runs without parameters. The parameters are set in the configuration file before the script is running.

+ This is how the configuration file must look like:
```
column1_background=2
column1_font_color=4
column2_background=5
column2_font_color=1
```

+ If one or more parameters are not set in the configuration file, the color must be substituted from the default color scheme. (Choice is at the developer's discretion).

+ After the system information output from [**Part 1.3.**](#part-13-visual-output-design-for-the-system-research-script), you should output the color scheme by indenting one empty line as follows:
```
Column 1 background = 2 (red)
Column 1 font color = 4 (blue)
Column 2 background = 5 (purple)
Column 2 font color = 1 (white)
```

+ When running the script with the default color scheme, the output should look like this:
```
Column 1 background = default (black)
Column 1 font color = default (white)
Column 2 background = default (red)
Column 2 font color = default (blue)
```

## Part 1.5. File system research
**Task:**

+ Write a bash script. The script is run with a single parameter.  
The parameter is an absolute or relative path to a directory. The parameter must end with '/', for example:  
`script05.sh /var/log/`

+ The script must output the following information about the directory specified in the parameter:
    + Total number of folders, including sub-folders
    + Top 5 folders with largest size in descending order (path and size)
    - Total number of files
    - Number of configuration files (with .conf extension), text files, executable files, log files (files with .log extension), archives, symbolic links
    - Top 10 files with largest size in descending order (path, size and type)
    - Top 10 executable files with largest size in descending order (path, size and hash)
    - Execution time of the script

The script should output the following information:

```
Total number of folders (including all nested ones) = 6  
TOP 5 folders of maximum size arranged in descending order (path and size):  
1 - /var/log/one/, 100 GB  
2 - /var/log/two/, 100 MB  
etc up to 5
Total number of files = 30
Number of:  
Configuration files (with the .conf extension) = 1 
Text files = 10  
Executable files = 5
Log files (with the extension .log) = 2  
Archive files = 3  
Symbolic links = 4  
TOP 10 files of maximum size arranged in descending order (path, size and type):  
1 - /var/log/one/one.exe, 10 GB, exe  
2 - /var/log/two/two.log, 10 MB, log  
etc up to 10  
TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)  
1 - /var/log/one/one.exe, 10 GB, 3abb17b66815bc7946cefe727737d295  
2 - /var/log/two/two.exe, 9 MB, 53c8fdfcbb60cf8e1a1ee90601cc8fe2  
etc up to 10  
Script execution time (in seconds) = 1.5
```


## Part 2 - Work With File System

## Part 2.1. File generator
**Task:**

Write a bash script. The script is run with 6 parameters. An example of running a script: \
`main.sh /opt/test 4 az 5 az.az 3kb`

**Parameter 1** is the absolute path. \
**Parameter 2** is the number of sub-folders. \
**Parameter 3** is a list of English alphabet letters used in folder names (no more than 7 characters). \
**Parameter 4** is the number of files in each created folder. \
**Parameter 5** - the list of English alphabet letters used in the file name and extension (no more than 7 characters for the name, no more than 3 characters for the extension). \
**Parameter 6** - file size (in kilobytes, but not more than 100).

Folder and file names must only consist of the letters specified in the parameters and use each of them at least 1 time.  
The length of this part of the name should be at least 4 characters, plus the script run date in DDMMYY format, separated by underscores, for example: \
**./aaaz_021121/**, **./aaazzzz_021121** 

If `az` has been specified for a folder or a file name, there can be no inverse entry: \
**./zaaa_021121/** i.e. the order of the characters specified in the parameter must be maintained.

When the script runs in the location specified in parameter 1, the folders and files should be created in them with the appropriate names and sizes. The script should stop running if there is 1GB of free space left on the file system (in the / partition).

Make a log file with data on all created folders and files (full path, creation date, file size).


## Part 2.2. File system clogging
**Task:**

Write a bash script. The script is run with 3 parameters. An example of running a script: \
`main.sh az az.az 3Mb`

**Parameter 1** is a list of English alphabet letters used in folder names (no more than 7 characters). \
**Parameter 2** the list of English alphabet letters used in the file name and extension (no more than 7 characters for the name, no more than 3 characters for the extension). \
**Parameter 3** - is the file size (in Megabytes, but not more than 100).

Folder and file names must only consist of the letters specified in the parameters and use each of them at least 1 time.  
The length of this part of the name should be at least 5 characters, plus the script run date in DDMMYY format, separated by underscores, for example: \
**./aaazz_021121/**, **./aaazzzz_021121** 

If `az` has been specified for a folder or a file name, there can be no inverse entry: \
**./zaaa_021121/** i.e. the order of the specified characters in the parameter must be maintained.

When running the script, file folders must be created in different (any, except paths containing **bin** or **sbin**) locations on the file system.
The number of subfolders is up to 100. The number of files in each folder is a random number (different for each folder). The script should stop running when there is 1GB of free space left on the file system (in the / partition).
Check the file system free space with  `df -h /`.

Make a log file with data on all created folders and files (full path, creation date, file size).

At the end of the script, display the start time, end time and total running time of the script. Complete the log file with this data.

## Part 2.3. Cleaning the file system
**Task:**

Write a bash script. The script is run with 1 parameter. The script should be able to clear the system from the folders and files created in [Part 2.2](#part-22-file-system-clogging) in 3 ways:

1. By log file
2. By creation date and time
3. By name mask (i.e. characters, underlining and date).

The cleaning method is set as a parameter with a value of 1, 2 or 3 when you run the script.

*When deleting by date and time of creation, the user enters the start and end times up to the minute. All files created within the specified time interval must be deleted. The input can be implemented either through parameters or at runtime.*

## Part 2.4. Log generator
**Task:**

Write a bash script or a C program that generates 5 **nginx** log files in *combined* format. Each log should contain information for 1 day.

A random number between 100 and 1000 entries should be generated per day.
For each entry there should be randomly generated the following:

1. IP (any correct one, i.e. no ip such as 999.111.777.777)
2. Response codes (200, 201, 400, 401, 403, 404, 500, 501, 502, 503)
3. methods (GET, POST, PUT, PATCH, DELETE)
4. Dates (within a specified log day, should be in ascending order)
5. Agent request URL
6. Agents (Mozilla, Google Chrome, Opera, Safari, Internet Explorer, Microsoft Edge, Crawler and bot, Library and net tool)

Specify in the comments of your script/program what each of the response codes used means.


## Part 2.5. Monitoring
**Task:**

- Write a bash script to parse **nginx** logs from [Part 2.4.](#part-24-log-generator) via **awk**.
- The script is run with 1 parameter, which has a value of 1, 2, 3 or 4.

- Depending on the value of the parameter, output the following:
- 1. All entries sorted by response code
- 2. All unique IPs found in the entries
- 3. All requests with errors (response code - 4xx or 5xxx)
- 4. All unique IPs found among the erroneous requests

## Part 2.6. **GoAccess**
**Task:**

- Use the GoAccess utility to get the same information as in [Part 2.5.](#part-25-monitoring)
- Open the web interface of the utility on the local machine.

## Part 2.7. **Prometheus**, **Grafana** and **my own script**
**Task:**

- Install and configure **Prometheus** and **Grafana** with docker compose
- Access the **Prometheus** and **Grafana** web interfaces from a local machine
- Add to the **Grafana** your own dashboard a display of CPU, available RAM, free space and the number of I/O operations on the hard disk.  

- Run your bash script from [Part 2.2.](#part-22-file-system-clogging)
- Check the hard disk load (disk space and read/write operations)
- Install the **stress** utility and run the following command `stress -c 2 -i 1 -m 1 --vm-bytes 32M -t 10s`
- Check the hard disk, RAM and CPU load  

- Download the ready-made dashboard *Node Exporter Quickstart and Dashboard* from **Grafana Labs** official website.
- Run the same tests  

- Run a network load test using for example **iperf3**
- Check the network interface load

**Bonus Task**
  
Write a bash script or a C program that collects information on basic system metrics (CPU, RAM, hard disk (capacity)). The script or a program should make a html page in **Prometheus** format, which will be served by **nginx**. \
The page itself can be refreshed within a bash script or a program (in a loop), or using the cron utility, but not more often than every 3 seconds.

- Change the **Prometheus** configuration file so it collects information from the page you created.
- Run the same tests

## Part 3. Basic **Docker Compose** with mini server inside **nginx** 
**Task:**

- Write a mini server in **C** and **FastCgi** that will return a simple page saying `Hello World!`
- Run the written mini server via *spawn-fcgi* on port 8080
- Write your own *nginx.conf* that will proxy all requests from port 81 to *127.0.0.1:8080*
- Add proxying of */status* page in *./nginx/nginx.conf* to return the **nginx** server status
- Write a *docker-compose.yml* file, using which:
- 1) Start your container 
- 2) Start the docker container with **nginx** which will proxy all requests from port 8080 to port 81 of the first container
- Map port 8080 of the second container to port 80 of the local machine


