# CS 1XA3 Project01 - fedorivy
## Usage
Clone the repository.  
Execute this script from anywhere(regardless of the location you are currently in) by running these two commands:  

 1. chmod +x **PATH**/CS1XA3/Project01/project_analyze.sh  
 1. .**PATH**/CS1XA3/Project01/project_analyze **arg1**  
**(** Where ***PATH*** is the path from your current directory to the directory where CS1XA3 is located, and **arg1** is the only argument that can be called before executing the script **)**  

Valid values for the argument **arg1**:  
* if arg1 is **1**, the __6.2 FIXME Log__ feature will be executed 
* if arg1 is **2**,  the __6.3 Checkout Latest Merge__ feature will be executed 
* if arg1 is **3**,  the __6.5 File Type Count__ feature will be executed 
* if arg1 is **4**,  the __6.6 Find Tag__ feature will be executed 
* if arg1 is **5**,  the __6.7 Switch to Executable__ feature will be executed 
* if arg1 is **6**,  the __6.8 Backup and Delete / Restore__ feature will be executed 
* if arg1 is **modif**,  the __Last Modifications__ custom feature 1 will be executed 
* if arg1 is **enc**,  the __File Encrytion__ custom feature 2 will be executed 

*Note: Passing more then one argument(or zero), or execute the script with **arg1** whose value is not one of those listed above will result in an error*

## Feature 01 (6.2 FIXME Log)
**Description**: This feature finds every file in the CS1XA3 directory(and its all subdirectories) that has the word #FIXME in the last line, puts the list of paths to these files(realtive to CS1XA3) in CS1XA3/Project01/fixme.log with each file separated by a newline.   
*Note: If fixme.log does not exist, it will be created, otherwise it will be overwritten.*   
*Note: I decided not to exclude hidden files and directories such as .git, since it's asking for **every file** in the repository.*    
**Execution**: Pass **1** as a value for the **arg1** before executing project_analyze.sh  
**Reference**: Bash: Location of Current Script - [Link](https://medium.com/@Aenon/bash-location-of-current-script-76db7fd2e388)

## Feature 02 (6.3 Checkout Latest Merge)
**Description**: This feature finds the most recent commit with the word merge (case insensitive) in the commit message and automatically checkouts that commit.  
*Note: If there are uncommitted changes on the branch you are currently working on, git will not allow you to checkout a commit.*   
**Execution**: Pass **2** as a value for the **arg1** before executing project_analyze.sh  
**Reference**: usage of **%%** - [Link](https://stackoverflow.com/questions/34951901/percent-symbol-in-bash-whats-it-used-for)

## Feature 03 (6.5 File Type Count)
**Description**: This feature prompts the user for an extension (i.e txt, pdf, py, etc) and outputs the number of files in the CS1XA3 directory(and its all subdirectories) with that extension.  
**Execution**: 
 1. Pass **3** as a value for the **arg1** before executing project_analyze.sh
 1. Type the extension and hit enter(Make sure **NOT** to include **.**)
 
**Reference**: Lecture and Lab slides

## Feature 04 (6.6 Find Tag)
**Description**: This feature prompts the user for a Tag, and then, for each python file (i.e ending in .py) in the CS1XA3 directory(and its all subdirectories), finds all lines that begin with a comment (i.e #) and include the Tag. Afterwards, both paths to the files and the lines are put to **Tag**.log (where **Tag** is literaly the name of the tag that was entered by the user).  
*Note: If **Tag**.log does not exist, it will be created, otherwise it will be overwritten.*   
**Execution**: 
 1. Pass **4** as a value for the **arg1** before executing project_analyze.sh
 1. Type the Tag and hit enter.  
 
**Reference**: Lecture and Lab slides

## Feature 05 (6.7 Switch to Executable)
**Description**: This feature prompts the user to **Change** or **Restore** permissions of all sh files found in this repository.
* If **Change** option is selected, all of the sh files found in this repository get the following modification:  
__Only people who have write permission also have execute permission__(i.e if any of the __User__, __Group__, or __Other__ scopes has +w permission it automatically gets +x permission. Likewise, if any of the scopes has -w permission it also gets -x permission).   In addition, each sh file has its original permissions stored in CS1XA3/Project01/permissions.log
* if **Restore** option is selected, each sh file restores its original permissions (as specified in CS1XA3/Project01/permissions.log)


*Note: Each time **Change** option is selected, CS1XA3/Project01/permissions.log gets overwritten*.    
*Note: If any of the sh files is deleted after its original permissions were stored in CS1XA3/Project01/permissions.log, using option **Restore** will print the message saying that that file no longer exists*.      
*Note: If CS1XA3/Project01/permissions.log is deleted, **Restore** option can't be used*.
**Execution**: 
 1. Pass **5** as a value for the **arg1** before executing project_analyze.sh
 1. Type the **option** (i.e either **Change** or **Restore** (Make sure its capitalized!)) and hit enter.
 
**Reference**:  
* Lecture and Lab slides
* Functions in bash - [Link](https://linuxize.com/post/bash-functions/)
* Index a string in bash - [Link](https://unix.stackexchange.com/questions/303960/index-a-string-in-bash)
* Manipulating Strings( ##, #, %%, % operators) - [Link](http://tldp.org/LDP/abs/html/string-manipulation.html)

## Feature 06 (6.8 Backup and Delete / Restore)
**Description**: This feature prompts the user to **Backup** or **Restore** all of the **.tmp** files found in this repository.   
* if **Backup** option is selected, it creates the directory CS1XA3/Project01/backup (if it doesn’t exit) and moves all of the files that end in **.tmp** into CS1XA3/Project01/backup folder. In addition, it creates a file CS1XA3/Project01/backup/restore.log that contains a list of paths of the files original locations
* if **Restore** option is selected, all of the files get copied from CS1XA3/Project01/backup to their original locations.

*Note After using **Restore** option, CS1XA3/Project01/backup and all of its contents remain to exist.*  
*Note: if **Backup** options is selected, but CS1XA3/Project01/backup folder already exist, it deletes it first, and then creates a new one.*  
*Note: if CS1XA3/Project01/backup/restore.log does not exist, you can't use **Restore** option.*     
*Note: If any of the **tmp** files stored in CS1XA3/Project01/backup is deleted, using option **Restore** will not restore that particular file and print the message saying that that file no longer exists.*    
**Execution**: 
 1. Pass **6** as a value for the **arg1** before executing project_analyze.sh
 1. Type the **option** (i.e either **Backup** or **Restore** (Make sure its capitalized!)) and hit enter.
 
**Reference**:
* Lecture and Lab slides
* Manipulating Strings( ##, #, %%, % operators) - [Link](http://tldp.org/LDP/abs/html/string-manipulation.html)

## Custom Feature 01 (Last Modifications)
**Description**: This feature prompts the user for a time zone, and, then, creates CS1XA3/Project01/**Last Modifications** directory(if doesn't already exist). Afterwards, it goes through each file in the repository(except for the files from the **Last Modifications** folder, and .git folder) and checks when their contents were last modified(according to specified time zone). For each 'last modified' date there will be a log file created in the **Last Modification** folder that contains paths to the files(separatetd by '\n'), whose contents were last modified on that exact date. Each log file will be named using this format **yyyy-mm-dd**.log, where **yyyy** is the year, **mm** is the month, and **dd** the day of the date. In addition, a CS1XA3/Project01/Last Modifications/info.txt file will be created that stores the time zone specified by the user and the date on which **Last Modifications** folder was created.

**Valid input values for time zone:**. 
* EST
* UTC
* UTC+**num1** , where **num1** is an integer from 0 to 24 inclusively.
* UTC-**num2** , where **num2** is an integer from 0 to 24 inclusively.

**Execution**:  
1. Pass **modif** as a value for the **arg1** before executing project_analyze.sh
1. Type the **time zone** option and hit enter(check the valid options for **time zone** above(**TYPE EXACTLY AS STATED ABOVE**).   
**Reference**:   
* Lecture and Lab slides
* Regex matching in a Bash if statement - [Link](https://stackoverflow.com/questions/18709962/regex-matching-in-a-bash-if-statement/18710850)
* File's last modified date in Bash (stat -c %y ) - [Link](https://stackoverflow.com/questions/16391208/print-a-files-last-modified-date-in-bash)
* TZ variable bash - [Link](https://www.cyberciti.biz/faq/linux-unix-set-tz-environment-variable/)


## Custom Feature 02 (File Encrytion)
**Description**: This feature prompts the user to **Encrypt** all the files in the repository, or **Decrypt** a particular one.  
* If **Encrypt** option is selected, all of the files (except for those indicated below under **Restricted Files** section) get encrypted by shifting each **printable** ASCII caharcters(characters whose ASCII decimal values are between 32 and 126 inclusevely) by one (i.e. character whose decimal value is 50 becomes 51, 66->67, 32->126, 126->32, etc.). In addition, for each encrypted file there will be generated a unqiue 6-character decryption key associated with that file and stored in the CS1XA3/Project01/encryptions.txt along with the path of the file. 

* If **Decrypt** option is selected, the user is firstly prompted for a path of the file, and then for a decryption key associated with that file. If the key entered by the user matches the one listed in CS1XA3/Project01/encryptions.txt and is indeed associated with that file, the file gets decprypted back to its original state and removed from CS1XA3/Project01/encryptions.txt
   * **(Additional Feature)**: if you are the owner of CS1XA3/Project01/encryptions.txt, you can type in **all** when prompted for a path of the file, and this will decrypt all of the files listed in CS1XA3/Project01/encryptions.txt and remove CS1XA3/Project01/encryptions.txt afterwards
   

**Restricted Files**:   
In order to not interfere with some of the other implemented features, I've put some restrictions on which files will be encrypted.
All of the files will be encrypted **except** for the following files and folders:
* CS1XA3/Project01/**encryption.py** (this is a python file used by **File Encrytion** feature. It gets created and then deleted at the end every time the feature is used by the user)
* CS1XA3/Project01/**project_analyze.sh**
* The entire **.git** folder
* CS1XA3/Project01/**encryptions.txt**
* CS1XA3/Project01/**permissions.log**
* The entire CS1XA3/Project01/**backup** folder


**Additional information**:  
 * Note: The script is designed in a way that prevents the user from encrypting the files multiple times without prior decryption of those files. (I.e running **project_analyze.sh enc** under **Encrypt** option two times in a row **WILL NOT** produce encryption of the files with printable ASCII caharcters shifted by the value of two; instead, the usual shift by the value of one will be produced just as if the script was run only once. This script does it by implicitly decrypting all of the files(if any) mentioned in the CS1XA3/Project01/encryptions.txt before performing encryption of all files.
 
 * Note: If any of the files that has previously been encrypted and stored in CS1XA3/Project01/encryptions.txt no longer exists, you won't be able to decrypt that file by using **Decrypt** option. By trying to do so, you will get notified that it cannot be done since the file no longer exist.
 
 * Note: Nobody can read, write, or execute the CS1XA3/Project01/encryptions.txt file except for the owner.
 
 * Note: if you delete the CS1XA3/Project01/encryptions.txt file, the files that haven't been decrypted will stay encrypted, so watch out for this.
 
**Execution**: 
 1. Pass **enc** as a value for the **arg1** before executing project_analyze.sh
 1. Type the **option** (i.e either **Encrypt** or **Decrypt** (Make sure its capitalized!)) and hit enter.
    * If **Decrypt** option is selected:
    1. Type the path of a file relative to CS1XA3 folder (i.e. if your want to decrypt **CS1XA3/file.txt**, type **file.txt**   , if your want to decrypt **CS1XA3/Project01/file2.txt**, type **Project01/file.txt** (DO NOT PUT **/** AS THE FIRST CHARACTER!**))
    1. Type the **6-character decryption code** associated with that file. (if you are the owner of CS1XA3/Project01/encryptions.txt, you can find the decryption codes in there)
 
**Reference**:
* Lecture and Lab slides
* Python script inside a bash script- [Link](https://unix.stackexchange.com/questions/184726/how-to-include-python-script-inside-a-bash-script)
* Using Command Line Arguments in Python - [Link](https://wellsr.com/python/using-command-line-arguments-with-python-sys-argv/)
*  (id -u) and (stat -c "%u" file.name) commands - [Link](https://superuser.com/questions/52232/script-in-unix-bash-to-determine-if-the-user-is-the-owner-of-a-file)
* Bash arrays -[Link](https://opensource.com/article/18/5/you-dont-know-bash-intro-bash-arrays)
* Functions in bash - [Link](https://linuxize.com/post/bash-functions/)
* While loop in bash - [Link](https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_09_02.html)
* Bash generate random alphanumeric string - [Link](https://gist.github.com/earthgecko/3089509)
* Sed Command to Delete Lines in File - [Link](https://www.folkstalk.com/2013/03/sed-remove-lines-file-unix-examples.html)
