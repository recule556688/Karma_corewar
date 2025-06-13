#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Find all .cor files
CHAMPIONS=($(find . -name "*.cor"))

if [ ${#CHAMPIONS[@]} -eq 0 ]; then
    echo -e "${RED}No .cor files found!${NC}"
    exit 1
fi

# Initialize results array
declare -A results

# Run battles
echo -e "${YELLOW}Running battles...${NC}"
for ((i=0; i<${#CHAMPIONS[@]}; i++)); do
    for ((j=0; j<${#CHAMPIONS[@]}; j++)); do
        [ $i -eq $j ] && continue  # Skip self-matches

        champ1=${CHAMPIONS[$i]}
        champ2=${CHAMPIONS[$j]}
        name1=$(basename "${champ1%.cor}")
        name2=$(basename "${champ2%.cor}")
        
        echo -n "Battle: $name1 vs $name2 - "
        # Run the battle and keep only the line that tells who won
        winner_line=$(./corewar "$champ1" "$champ2" 2>/dev/null | grep "has won")

        if [ -n "$winner_line" ]; then
            # Extract the winning player number (1 or 2)
            winner_num=$(echo "$winner_line" | grep -o 'player [0-9]' | awk '{print $2}')

            if [ "$winner_num" -eq 1 ]; then              # champ1 wins
                echo -e "${GREEN}$name1 wins!${NC}"
                results[$name1,$name2]="W"
            elif [ "$winner_num" -eq 2 ]; then            # champ2 wins
                echo -e "${GREEN}$name2 wins!${NC}"
                results[$name1,$name2]="L"
            else                                          # should not happen
                echo -e "${YELLOW}No clear winner${NC}"
                results[$name1,$name2]="D"
            fi
        else                                              # no "has won" line
            echo -e "${YELLOW}No clear winner${NC}"
            results[$name1,$name2]="D"
        fi
    done
done

# Print summary
echo -e "\n${YELLOW}=== Battle Summary ===${NC}"
printf "%-20s" "Champion"
for ((i=0; i<${#CHAMPIONS[@]}; i++)); do
    printf "%-10s" "$(basename ${CHAMPIONS[$i]%.cor})"
done
echo

for ((i=0; i<${#CHAMPIONS[@]}; i++)); do
    name1=$(basename ${CHAMPIONS[$i]%.cor})
    printf "%-20s" "$name1"
    for ((j=0; j<${#CHAMPIONS[@]}; j++)); do
        name2=$(basename ${CHAMPIONS[$j]%.cor})
        if [ $i -eq $j ]; then
            printf "%-10s" "-"
        else
            result=${results[$name1,$name2]}
            case $result in
                "W") printf "${GREEN}%-10s${NC}" "W";;
                "L") printf "${RED}%-10s${NC}" "L";;
                "D") printf "${YELLOW}%-10s${NC}" "D";;
            esac
        fi
    done
    echo
done

# Print win statistics
echo -e "\n${YELLOW}=== Win Statistics ===${NC}"

# Create arrays to store names and their win counts
declare -a names
declare -a win_counts

# First collect all names and their win counts
for ((i=0; i<${#CHAMPIONS[@]}; i++)); do
    name=$(basename ${CHAMPIONS[$i]%.cor})
    wins=0
    for ((j=0; j<${#CHAMPIONS[@]}; j++)); do
        if [ $i -ne $j ]; then
            if [ "${results[$name,$(basename ${CHAMPIONS[$j]%.cor})]}" == "W" ]; then
                ((wins++))
            fi
        fi
    done
    names+=("$name")
    win_counts+=("$wins")
done

# Sort the arrays based on win counts (bubble sort)
for ((i=0; i<${#names[@]}-1; i++)); do
    for ((j=0; j<${#names[@]}-i-1; j++)); do
        if [ ${win_counts[$j]} -lt ${win_counts[$j+1]} ]; then
            # Swap win counts
            temp=${win_counts[$j]}
            win_counts[$j]=${win_counts[$j+1]}
            win_counts[$j+1]=$temp
            # Swap names
            temp=${names[$j]}
            names[$j]=${names[$j+1]}
            names[$j+1]=$temp
        fi
    done
done

# Print sorted results
for ((i=0; i<${#names[@]}; i++)); do
    echo -e "${names[$i]}: ${GREEN}${win_counts[$i]}${NC} wins"
done

