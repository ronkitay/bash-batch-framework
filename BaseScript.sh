#!/bin/sh

##################################################################################
# BaseScript.sh                                                                  #
# =============                                                                  #
# Basic script that any script using the framework must include at the begining  #
# of the script.                                                                 #
##################################################################################

function GetLogDir()
{
	echo "/log"
}

function GetLogFileBaseName()
{
	echo `basename $0`
}

function GetTimeStampForLog()
{
	echo "`date '+%Y.%m.%d; %H:%M:%S'`;"
}

function TurnDebugOn()
{
	export DEBUG_BASH_ON="Y"
}

function TurnDebugOff()
{
	export DEBUG_BASH_ON="N"
}

function Error()
{
	echo "$(GetTimeStampForLog) [ERROR]: "$1 | tee -a ${LOG_FILE}
}


function Info()
{
	echo "$(GetTimeStampForLog) [INFO]; "$1 | tee -a ${LOG_FILE}
}

function Debug()
{
	if [[ ${DEBUG_BASH_ON} == "Y" ]]
	then
		echo "$(GetTimeStampForLog) [DEBUG]: "$1 | tee -a ${LOG_FILE}
	fi
}

function TraceCommand()
{
	Debug "About to run: '$1'"
}

function LogEmptyLine()
{
	echo "" >> ${LOG_FILE}
}

function MarkLogStart()
{
	echo "*****************************************************************************" >> ${LOG_FILE}
	echo "*****************************************************************************" >> ${LOG_FILE}
	echo "*****************************************************************************" >> ${LOG_FILE}
}

function LogCommandStart
{
	echo "Command output is sent to ${LOG_FILE}"
	LogEmptyLine
	MarkLogStart
	LogEmptyLine
	Info "Starting the '$1' command with the following arguments <`echo $2 | tr ' ' ','`>"
	LogEmptyLine
}

function LogCommandEnd()
{
	LogEmptyLine
	Info "Finished the '$1' command"
	LogEmptyLine
}

function ExecuteCommand()
{
	STEP_DESCRIPTION=$1
	COMMAND=$2
	
	Info "${STEP_DESCRIPTION}"
	TraceCommand "${COMMAND}"
	${COMMAND} 1>> ${LOG_FILE} 2>&1
	result=$?
	
	if [ $result -ne 0 ]; then
		Error "Step <${STEP_DESCRIPTION}> has failed with error code <${result}>"
		exit $result
	fi
}

##################################################################################
#                           Main code starts here                                #
##################################################################################

export LOG_DIR=$(GetLogDir)
export LOG_FILE="${LOG_DIR}/$(GetLogFileBaseName).log.`date +%Y%m%d`"

if [ "$1" = "-help" ] || [ "$1" =  "--help" ] || [ "$1" =  "-h" ]; then
	Usage # The calling script must implement this function
fi



