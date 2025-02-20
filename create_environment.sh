#!/bin/bash
#declare the main directory with my name.
MAIN_DIR=submission_reminder_Michelle
#create the base directory
mkdir -p "$MAIN_DIR"
#declare sub directories, files and its content.
declare -A FILES=(
["app/reminder.sh"]="#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file"
["modules/functions.sh"]="#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}"
["assets/submissions.txt"]="student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted"
["config/config.env"]="# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
"
["startup.sh"]="#!/bin/bash 
  #starting submission reminder up.
  chmod +x "$BASE_DIR/app/reminder.sh"
chmod +x "$BASE_DIR/modules/functions.sh"
chmod +x '$BASE_DIR/startup.sh'"
["README.md"]="directory, sub directory,file and its content."
 # Make script files executable  
for file in "${!FILES[@]}"; do
    echo -e "${FILES[$file]}" > "$MAIN_DIR/$file"
    chmod +x "$MAIN_DIR/$file"  # Make script files executable
done
  
