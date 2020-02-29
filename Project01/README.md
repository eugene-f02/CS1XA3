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
**Reference**: usage of **%%**(regex) - [Link](https://stackoverflow.com/questions/34951901/percent-symbol-in-bash-whats-it-used-for)

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


## Custom Feature 01 (Last Modifications Log)
**Description**: This feature creates a folder **Last Modifications**(if doesn't already exist) in the CS1XA3 directory and, afterwards, goes through each file in the repository(except for the files from the **Last Modifications** folder, and .git folder) and checks when their contents were last modified. For each 'last modified' date there will be a log file created in the **Last Modification** folder that contains paths to the files(separatetd by '\n'), whose contents were last modified on that exact date. Each log file will be named using this format **yyyy-mm-dd**.log, where **yyyy** is the year, **mm** is the month, and **dd** the day of the date.

**Execution**: Pass **modif** as a value for the **arg1** before executing project_analyze.sh
 
**Reference**: Coming Up Soon


## Custom Feature 02 (File Encrytion)
**Description**: This feature prompts the user for the path to any of the files in the repository, and, afterwards, the user is asked to choose between the two options:

First - 'encrypt', which would generate a unqiue 6-character long key associated with that file and store it in the CS1XA3/encryptions.txt. Afterwards, the file gets encrypted such that each character in the file is replaced with the character whose ASCII value is grater than the original character's by one.     
*Note: this encrypting pattern will be only applied to all of the printable ASCII characters(ie. HEX values from 20 to 7e)*
*Note: the option 'encrypt' will only work if the file has not been already encrypted by this feature).*

Second - 'decrypt', which would prompt the user for a decryption key. If the key entered by the user matches the one listed in CS1XA3/encryptions.txt and is indeed associated with that file, the file gets decprypted back to its original state.

*Note: .sh, .py, and any files from .git folder will not be encrypted.*  
*Note: if you deleted the encryptions.txt file, the files that haven't been decrypted will stay encrypted, so watch out for this.*    
*Note: Nobody can read, write, or execute the encryptions.txt file except for the owner.*

**Execution**: 
 1. Pass **enc** as a value for the **arg1** before executing project_analyze.sh
 1. Type in the path to a file
 1. Choose the option by typing in either **encrypt** or **decrypt**
     * If **decrypt** was selected, type in a decrypting key
 
**Reference**: Coming up Soon


