#!/bin/bash

echo Welcome to  TIE TAC TOE GAME

#CONSTANTS
NUMBER_OF_ROWS=3
NUMBER_OF_COLUMNS=3

#VARIABLES
boardPositionCount=0

#DICTIONARYS
declare -A ticTacToe

function start()
{
	for(( i=1; i<=$NUMBER_OF_ROWS; i++ ))
	do
		ticTacToe[$((++boardPositionCount))]="-"
		ticTacToe[$((++boardPositionCount))]="-"
		ticTacToe[$((++boardPositionCount))]="-"
	done
}

function display()
{
	boardPositionCount=0
	for(( i=1; i<=$NUMBER_OF_ROWS; i++ ))
	do
		echo ${ticTacToe[$((++boardPositionCount))]} "|" ${ticTacToe[$((++boardPositionCount))]} "|" ${ticTacToe[$((++boardPositionCount))]}
	done
}

function main()
{
	start
	display
}

main

