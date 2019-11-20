#!/bin/bash

echo Welcome to  TIE TAC TOE GAME

#CONSTANTS
NUMBER_OF_ROWS=3
CHANCE_FOR_PLAYER=0
TOTAL_NUMBER_OF_CELL_FIELD=9

#VARIABLES
boardPositionCount=0
letterOfPlayer=""
changeChance=0
countNumberOfCellField=1
winner=0

#DICTIONARYS
declare -A ticTacToe

#Chance
function chance()
{
	if [ $changeChance -eq $CHANCE_FOR_PLAYER ]
	then
		while [ true ]
		do
			echo "Choose a cell(1 to 9):"
			cell="$( chooseCell )"
			if [ "${ticTacToe[$cell]}" == '-' ] 
			then
				changeChance=1
				ticTacToe[$cell]="X"
				break
			else
				echo "You choose wrong option"
			fi
		done
	else
		while [ true ]
		do
			checkWinMoveInRow
			checkWinMoveInColumn
			checkWinMoveInDiagonal
			if [ $winner -eq 0 ]
			then
				cell=$((RANDOM % 9 + 1))
				if [ "${ticTacToe[$cell]}" == "-" ]
				then
					changeChance=0
					ticTacToe[$cell]="0"
					break
				fi
			else
				break
			fi
		done
	fi
}

function checkRowColumn()
{
	checkWinner=0
	if [ $1 != "-" ] && [ $1 ==  $2 ] && [ $2 == $3 ]
	then
		checkWinner=1
	fi
	if [ $checkWinner -eq 1 ]
	then
		echo "TRUE"
	else
		echo "FALSE"
	fi
}

function checkWinMoveInRow()
{
	cell=1
	for(( i=1; i<=3; i++ ))
	do
		checkWinMove $((cell++)) $((cell++)) $((cell++))
	done
}

function checkWinMove()
{
	check=0
	if [ "${ticTacToe[$1]}" == "0" ] && [ "${ticTacToe[$1]}" == "${ticTacToe[$2]}" ] && [ "${ticTacToe[$3]}" == "-" ]
	then
		ticTacToe[$3]="0"
		check=1
	elif [ "${ticTacToe[$1]}" == "0" ] && [ "${ticTacToe[$1]}" == "${ticTacToe[$3]}" ] && [ "${ticTacToe[$2]}" == "-" ]
	then
		ticTacToe[$2]="0"
		check=1
	elif [ "${ticTacToe[$2]}" == "0" ] && [ "${ticTacToe[$2]}" == "${ticTacToe[$3]}" ] && [ "${ticTacToe[$1]}" == "-" ]
	then
		ticTacToe[$1]="0"
		check=1
	elif [ "${ticTacToe[$2]}" == "0" ] && [ "${ticTacToe[$2]}" == "${ticTacToe[$1]}" ] && [ "${ticTacToe[$3]}" == "-" ]
	then
		ticTacToe[$3]="0"
		check=1
	elif [ "${ticTacToe[$3]}" == "0" ] && [ "${ticTacToe[$3]}" == "${ticTacToe[$1]}" ] && [ "${ticTacToe[$2]}" == "-" ]
	then
		ticTacToe[$2]="0"
		check=1
	elif [ "${ticTacToe[$3]}" == "0" ] && [ "${ticTacToe[$3]}" == "${ticTacToe[$2]}" ] && [ "${ticTacToe[$1]}" == "-" ]
	then
		ticTacToe[$1]="0"
		check=1
	fi
	if [ $check -eq 1 ]
	then
		changeChance=0
		display
		checkRows="$( checkRow )"
		checkColumns="$( checkColumn )"
		checkDiagonals="$( checkDiagonal )"
		echo "checkRows:"$checkRows
		echo "checkColumns:"$checkColumns
		echo "checkDiagonals:"$checkDiagonals
		if [ $checkRows == "TRUE" ] || [ $checkColumns == "TRUE" ] || [ $checkDiagonals == "TRUE" ]
		then
			winner=1
		fi
	fi
}

function checkWinMoveInColumn()
{
	for(( i=1; i<=3; i++ ))
	do
		checkWinMove $i $(($i+3)) $(($i+6))
	done
}

function checkWinMoveInDiagonal()
{
	cell=1
	checkWinMove $cell $(($cell+4)) $(($cell+8))
	checkWinMove $(($cell+2)) $(($cell+4)) $(($cell+6))	
}

function checkRow()
{
	checkWinner=0
	cell=1
	for(( i=1; i<=3; i++ ))
	do
			checkRowColumn="$( checkRowColumn "${ticTacToe[$cell]}" "${ticTacToe[$(($cell+1))]}" "${ticTacToe[$(($cell+2))]}" )"
		if [ $checkRowColumn == "TRUE" ]
		then
			checkWinner=1
			break
		fi
		cell=$(($cell + 3))
	done 
	if [ $checkWinner -eq 1 ]
	then
		echo "TRUE"
	else
		echo "FALSE"
	fi	
}

function checkColumn()
{
	checkWinner=0
	for(( i=1; i<=3; i++ ))
	do
		checkRowColumn="$( checkRowColumn "${ticTacToe[$i]}" "${ticTacToe[$(($i+3))]}" "${ticTacToe[$(($i+6))]}" )"
		if [ $checkRowColumn == "TRUE" ]
		then
			checkWinner=1
			break
		fi
	done
	if [ $checkWinner -eq 1 ]
	then
		echo "TRUE"
	else
		echo "FALSE"
	fi
}

function checkDiagonal()
{
	cell=1
	checkDiagonal="$( checkRowColumn "${ticTacToe[$cell]}" "${ticTacToe[$(($cell+4))]}" "${ticTacToe[$(($cell+8))]}")"
	checkDiagonal1="$( checkRowColumn "${ticTacToe[$(($cell+2))]}" "${ticTacToe[$(($cell+4))]}" "${ticTacToe[$(($cell+6))]}")"
	if [ $checkDiagonal == "TRUE" ] || [ $checkDiagonal1 == "TRUE" ]
	then
		echo "TRUE"
	else
		echo "FALSE"
	fi
}

#Determine every move 
function determineMove()
{
	checkWinner=0
	while [ $countNumberOfCellField -le $TOTAL_NUMBER_OF_CELL_FIELD ]
	do
		chance
		if [ $winner -eq 1 ]
		then
			break
		fi
		((countNumberOfCellField++))
		display
		checkRows="$( checkRow )"
		checkColumns="$( checkColumn )"
		checkDiagonals="$( checkDiagonal )"
		if [ $checkRows == "TRUE" ] || [ $checkColumns == "TRUE" ] || [ $checkDiagonals == "TRUE" ]
		then
			checkWinner=1
			break
		fi
	done
	
	if [ $checkWinner -eq 0 ] && [ $winner -eq 0 ]
	then
		echo "Game draw"
	else
		echo "Winner"
	fi
}

#Choose the valid cells
function chooseCell()
{
	read cell;
	echo $cell;
}

#toss to check who plays first
function toss()
{
	checkToss=$((Random%2))
	echo "1.Head 2.Tail"
	echo "Choose your option(1 or 2)"
	read userOption
	if [ $userOption -eq $(($checkToss + 1 )) ]
	then
		echo "Player play first"
		changeChance=0
	else
		echo "Computer play first"
		changeChance=1
	fi
}

#Player know the letter
function playerLetter()
{
	letterOfPlayer="X"
	echo $letterOfPlayer
}

#Initialise a tic tac toe board
function start()
{
	for(( i=1; i<=$NUMBER_OF_ROWS; i++ ))
	do
		ticTacToe[$((++boardPositionCount))]="-"
		ticTacToe[$((++boardPositionCount))]="-"
		ticTacToe[$((++boardPositionCount))]="-"
	done
}

#Display a tic tac toe board
function display()
{
	boardPositionCount=0
	echo "-------------"
	for(( i=1; i<=$NUMBER_OF_ROWS; i++ ))
	do
		echo "|" ${ticTacToe[$((++boardPositionCount))]} "|" ${ticTacToe[$((++boardPositionCount))]} "|" ${ticTacToe[$((++boardPositionCount))]} "|"
		echo "-------------"
	done
	echo "=*=*=*=*=*=*="
}

#main function
function main()

{
	start
	display
	letterOfPlayer="$( playerLetter )"
	echo "Your letter is "$letterOfPlayer
	toss
	determineMove
}

main

