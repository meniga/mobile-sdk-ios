#!/bin/sh

# uniquify and sort the Xcode projct files
python -mxUnique -u -s -c "Meniga-ios-sdk/Meniga-ios-sdk.xcodeproj/project.pbxproj" &> /dev/null

if [ $? -ne 0 ]; then
  red="\033[31m"
  reset="\033[m"
  printf "$red"
cat <<EOF
This commit has been aborted because the project file needed to be uniquified.
Please run "xUniquify" in the project root and commit again.
EOF
printf "$reset"
  exit 1
fi
