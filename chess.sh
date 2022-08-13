#!/bin/bash

function panic {
	message="$1"
	printf "Error: %s\n" "$message"
	exit 1
}

function printBoard {
	[[ $# -eq 1 ]] || panic "printBoard expects 1 argument (the board array), found $# arguments."
	for i in $(seq 1 8); do
		rank=$(( 9 - i ))
		for j in a b c d e f g h; do
			file=$j
      pos="$file$rank"
      piece="${board[$pos]}"
      if [[ "$piece" == "" ]]; then
        printf "."
      else
        piece_type=$(echo "$piece" | awk '{print $1}')
        printf "%s" "$piece_type"
      fi
		done
		printf "\n"
	done
}

declare -A board=(
	# black pieces
	[a1]="R q"
	[b1]="N q"
	[c1]="B q"
	[d1]="Q q"
	[e1]="K k"
	[f1]="B k"
	[g1]="N k"
	[h1]="R k"
	# black pawns
	[a2]="P q"
	[b2]="P q"
	[c2]="P q"
	[d2]="P q"
	[e2]="P q"
	[f2]="P q"
	[g2]="P q"
	[h2]="P q"
	# white pieces
	[a8]="r q"
	[b8]="n q"
	[c8]="b q"
	[d8]="q q"
	[e8]="k k"
	[f8]="b k"
	[g8]="n k"
	[h8]="r k"
	# white pawns
	[a7]="p q"
	[b7]="p q"
	[c7]="p q"
	[d7]="p q"
	[e7]="p q"
	[f7]="p q"
	[g7]="p q"
	[h7]="p q"
)

printBoard "$board"
