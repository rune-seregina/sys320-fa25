#! /bin/bash
clear

# filling courses.txt
bash courses.bash

courseFile="courses.txt"

function displayCoursesofInst(){

echo -n "Please Input an Instructor Full Name: "
read instName

echo ""
echo "Courses of $instName :"
cat "$courseFile" | grep "$instName" | cut -d';' -f1,2 | \
sed 's/;/ | /g'
echo ""

}

function courseCountofInsts(){

echo ""
echo "Course-Instructor Distribution"
cat "$courseFile" | cut -d';' -f7 | \
grep -v "/" | grep -v "\.\.\." | \
sort -n | uniq -c | sort -n -r 
echo ""

}

# TODO - 1
# Make a function that displays all the courses in given location
function displayCoursesofLoc() {
echo -n "Please input a location. Valid building names include JOYC, GBTC, MIC, WICK, FOST, FREE, CCM, SKFA, and BARN, followed by a space and a room number (eg. JOYC 310)"
read locName

# function dislaplays course code, course name, course days, time, instructor
echo ""
echo "Courses in $locName :"
cat "$courseFile" | grep "$locName" | cut -d';' -f1,2,5,6,7 | \
sed 's/;/ | /g'
echo ""
}
# Add function to the menu
# Example input: JOYC 310
# Example output: See the screenshots in canvas

# TODO - 2
# Make a function that displays all the courses that has availability
function displayAvailableCourses() {
# (seat number will be more than 0) for the given course code
echo -n "Please input a course code to check availability (Example: SEC)"
read courseCode

echo "" 
echo "Available courses in $courseCode :"
courses="$(cat $courseFile | grep $courseCode)"
echo "$courses" | while read -r line;
do
	seats=$(echo "$line" | cut -d';' -f 4)
	if [[ $seats -gt 0 ]]; then
		echo "$line" | cut -d';' -f 1,2,3,4,5,6,7,8,9,10 | sed 's/;/ | /g'
	fi
done

# Add function to the menu
}
# Example input: SEC
# Example output: See the screenshots in canvas

while :
do
	echo ""
	echo "Please select and option:"
	echo "[1] Display courses of an instructor"
	echo "[2] Display course count of instructors"
	echo "[3] Display courses in a location"
	echo "[4] Display available seats of a course code"
	echo "[5] Exit"

	read userInput
	echo ""

	if [[ "$userInput" == "5" ]]; then
		echo "Goodbye"
		break

	elif [[ "$userInput" == "1" ]]; then
		displayCoursesofInst

	elif [[ "$userInput" == "2" ]]; then
		courseCountofInsts

	elif [[ "$userInput" == "3" ]]; then
		displayCoursesofLoc

	elif [[ "$userInput" == "4" ]]; then
		displayAvailableCourses

	# TODO - 3 Display a message, if an invalid input is given
	else
		"Invalid selection. Please select a number 1-5"
	fi
done
