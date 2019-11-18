#!/bin/bash -x

echo Welcome to  TIE TAC TOE GAME

#CONSTANTS
NUMBER_OF_ROWS=3
NUMBER_OF_COLUMNS=3

#VARIABLES
boardPositionCount=0
letterOfPlayer=""

#DICTIONARYS
declare -A ticTacToe

#toss to check who plays first
function toss()
{
	checkToss=$((Random%2))
	echo "1.Head 2.Tail"
	read userOption
	if [ $userOption -eq $(($checkToss + 1 )) ]
	then
		echo "Player play first"
	else
		echo "Computer play first"
	fi
}

#Player know the letter
function playerLetter()
{
	checkRandom=$((RANDOM%2))
	if [ $checkRandom -eq 0 ]
	then
		letterOfPlayer="X"
		echo $letterOfPlayer
	else
		letterOfPlayer="0"
		echo $letterOfPlayer
	fi
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
	for(( i=1; i<=$NUMBER_OF_ROWS; i++ ))
	do
		echo ${ticTacToe[$((++boardPositionCount))]} "|" ${ticTacToe[$((++boardPositionCount))]} "|" ${ticTacToe[$((++boardPositionCount))]}
	done
}

#main function
function main()
{
	start
	display
	letterOfPlayer="$( playerLetter )"
	echo "Your letter is "$letterOfPlayer
	toss
}

main

