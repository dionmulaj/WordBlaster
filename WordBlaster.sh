#!/bin/bash

#Colors
BBLUE='\033[1;34m' #Bold Blue

clear 

printf "
${BBLUE}+++++++ WordBlaster +++++++\n${NC}
$(tput bold)$(tput setaf 7)-Author:$(tput sgr0) Dion Mulaj
$(tput bold)$(tput setaf 7)-Github:$(tput sgr0) https://github.com/dionmulaj\n
$(tput bold)$(tput setaf 7)-Description:$(tput sgr0) WordBlaster generates different keyword variations using: uppercase, lowercase and leet combinations.\n\n"



# Generate combinations
generate_combinations() {
  local word=$1
  local prefix=$2
  local remaining=${word:1}

  # Base
  if [[ -z $remaining ]]; then
    echo "$prefix$word"
    return
  fi

  local current=${word:0:1}

  # Uppercase and lowercase variations
  generate_combinations "$remaining" "$prefix$current"
  generate_combinations "$remaining" "$prefix${current^}"

  # Leet table
  case $current in
    e) generate_combinations "$remaining" "$prefix${current//e/3}";;
    o) generate_combinations "$remaining" "$prefix${current//o/0}";;
    a) generate_combinations "$remaining" "$prefix${current//a/4}";;
    s) generate_combinations "$remaining" "$prefix${current//s/5}";;
    b) generate_combinations "$remaining" "$prefix${current//b/6}";;
    t) generate_combinations "$remaining" "$prefix${current//t/7}";;
    h) generate_combinations "$remaining" "$prefix${current//h/#}";;
    l) generate_combinations "$remaining" "$prefix${current//l/1}";;
    i) generate_combinations "$remaining" "$prefix${current//i/!}";;
  esac
}

# Keyword input
read -p "$(tput bold)$(tput setaf 6)Enter a keyword: $(tput sgr0)" word

# Estimated time
length=${#word}
total_combinations=$((2**length))
average_time=$((total_combinations / 1000)) # Assuming 1000 combinations/second

# Estimated time and confirmation
echo "Generating and saving possible word variations will take approximately $(tput bold)$(tput setaf 7)$average_time seconds$(tput sgr0)."
read -p "$(tput bold)$(tput setaf 7)PRESS$(tput sgr0) $(tput bold)$(tput setaf 2)ENTER$(tput sgr0) $(tput bold)$(tput setaf 7)TO PROCEED OR PRESS$(tput sgr0) $(tput bold)$(tput setaf 3)CTRL+C$(tput sgr0) $(tput bold)$(tput setaf 7)TO CANCEL.$(tput sgr0)"
echo "Please wait..."

# Results
combinations=()
generate_combinations "$word" "" | sort -u > combinations.txt

echo "$(tput bold)$(tput setaf 8)Generated combinations saved to combinations.txt.$(tput sgr0)"
