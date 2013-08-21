#!/bin/sh

# Assume the base script is in the same directory as the current script
. `dirname $0`/BaseScript.sh

echo "Log is writen to ${LOG_FILE}"

Error "This"
Info "Is"
TurnDebugOn
Debug "Sparta"
TurnDebugOff
Debug "another Sparta"

TurnDebugOn
ExecuteCommand "Listing all files in the current directory" "cat BaseScript.sh"
TurnDebugOff

Info "Done"