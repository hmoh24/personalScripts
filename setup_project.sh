#shebang below: to tell OS to use bash shell to interpret the script
#!/bin/bash

# $1 - first parameter
# -z - is empty
# echo 'message' - sends a message to user
# exit - stop and exit the script
# 1 - indicates generic error occured and script did not complete successfully
if [ -z "$1" ]; then
    echo "Error: No github repository provided."
    echo "Usage: set_project.sh <git-repo-link>"
    exit 1
fi

git clone "$1"

# Extract the repository name from the URL
REPO_NAME=$(basename -s .git "$1")

# Change into the cloned repository directory
cd "$REPO_NAME" || { echo "Failed to enter directory $REPO_NAME"; exit 1; }

#Create project files
touch style.css script.js

# Create index.html with boilerplate HTML
## << - Here Document - a way to feed a multiline block of text directly into a command
## EOL - Start and end for cat input (can use any word)
# > index.html - directs output from cat into index.html. Will create the file or overwrite if it exists
cat <<EOL > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <script src="script.js" defer></script>
    <title>New Project</title>
</head>
<body>
    
</body>
</html>
EOL

git add .
git commit -m 'Boilerplate setup via bash script on local machine'
git push

echo "Project setup complete in $REPO_NAME, and changes pushed to remote!"