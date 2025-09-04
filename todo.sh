#!/usr/bin/env bash

# --- Configuration & Security ---

TODO_FILE="$HOME/.todo.dat"

declare -r GREEN='\033[0;32m'
declare -r YELLOW='\033[1;33m'
declare -r RED='\033[0;31m'
declare -r BLUE='\033[0;34m'
declare -r NC='\033[0m' # No Color

_init_data_file() {
    if [[ ! -f "$TODO_FILE" ]]; then
        touch "$TODO_FILE"
        chmod 600 "$TODO_FILE"
        echo -e "${GREEN}Created secure data file: ${TODO_FILE}${NC}"
    fi
}

# --- Core Functions ---

_add_task() {
    if [[ -z "$1" ]]; then
        echo -e "${RED}Error: You must provide a task to add.${NC}"
        echo -e "Usage: add <task>"
        exit 1
    fi
    local task="$1"
    
    echo "0|$task" >> "$TODO_FILE"
    echo -e "${GREEN}Task added: ${task}${NC}"
}

_list_tasks() {
    local filter="$1"
    local count=1
    local total_tasks=0
    local completed_tasks=0
    local uncompleted_tasks=0

    if [[ ! -s "$TODO_FILE" ]]; then
        echo -e "${BLUE}No tasks found. Add a new one with 'add <task>'.${NC}"
        return
    fi

    echo -e "${YELLOW}Your To-Do List${NC}"
    echo -e "----------------"
    while IFS="|" read -r status task; do
        total_tasks=$((total_tasks + 1))
        if [[ "$status" == "1" ]]; then
            completed_tasks=$((completed_tasks + 1))
        else
            uncompleted_tasks=$((uncompleted_tasks + 1))
        fi

        case "$filter" in
            "all")
                if [[ "$status" == "1" ]]; then
                    echo -e "  ${GREEN}[✔]${NC} ${task}"
                else
                    echo -e "  ${RED}[✗]${NC} ${task}"
                fi
                ;;
            "completed")
                if [[ "$status" == "1" ]]; then
                    echo -e "  ${GREEN}[✔]${NC} ${task}"
                fi
                ;;
            "uncompleted")
                if [[ "$status" == "0" ]]; then
                    echo -e "  ${RED}[✗]${NC} ${task}"
                fi
                ;;
        esac
    done < "$TODO_FILE"

    echo -e "----------------"
    echo -e "${BLUE}Summary: ${uncompleted_tasks} pending, ${completed_tasks} completed, ${total_tasks} total.${NC}"
}

_done_task() {
    if [[ -z "$1" ]]; then
        echo -e "${RED}Error: You must specify a task number.${NC}"
        echo -e "Usage: done <number>"
        exit 1
    fi
    local task_num="$1"
    
    sed -i "${task_num}s/^0/1/" "$TODO_FILE" 2>/dev/null
    if [[ $? -eq 0 ]]; then
        echo -e "${GREEN}Task ${task_num} marked as done!${NC}"
    else
        echo -e "${RED}Error: Task number '${task_num}' not found or already done.${NC}"
    fi
}

_delete_task() {
    if [[ -z "$1" ]]; then
        echo -e "${RED}Error: You must specify a task number to delete.${NC}"
        echo -e "Usage: delete <number>"
        exit 1
    fi
    local task_num="$1"
    
    sed -i "${task_num}d" "$TODO_FILE" 2>/dev/null
    if [[ $? -eq 0 ]]; then
        echo -e "${GREEN}Task ${task_num} deleted.${NC}"
    else
        echo -e "${RED}Error: Task number '${task_num}' not found.${NC}"
    fi
}

_clear_all() {
    if [[ ! -s "$TODO_FILE" ]]; then
        echo -e "${BLUE}The list is already empty.${NC}"
        return
    fi
    
    > "$TODO_FILE"
    echo -e "${GREEN}All tasks have been cleared.${NC}"
}

_usage() {
    echo -e "${BLUE}To-Do CLI App${NC}"
    echo "Usage: ./$(basename "$0") <command> [arguments]"
    echo ""
    echo "Commands:"
    echo -e "  ${YELLOW}add <task>${NC}        Adds a new task."
    echo -e "  ${YELLOW}list${NC}              Lists all tasks with their status."
    echo -e "  ${YELLOW}list-c${NC}            Lists only completed tasks."
    echo -e "  ${YELLOW}list-u${NC}            Lists only uncompleted tasks."
    echo -e "  ${YELLOW}done <number>${NC}     Marks a task as completed."
    echo -e "  ${YELLOW}delete <number>${NC}   Deletes a task by its line number."
    echo -e "  ${YELLOW}clear${NC}             Deletes all tasks permanently."
    echo -e "  ${YELLOW}help${NC}              Shows this help message."
}

# --- Main Logic ---

_init_data_file

case "$1" in
    add)
        shift
        _add_task "$*"
        ;;
    list)
        _list_tasks "all"
        ;;
    list-c)
        _list_tasks "completed"
        ;;
    list-u)
        _list_tasks "uncompleted"
        ;;
    done)
        _done_task "$2"
        ;;
    delete)
        _delete_task "$2"
        ;;
    clear)
        _clear_all
        ;;
    help|--help|-h|"")
        _usage
        ;;
    *)
        echo -e "${RED}Error: Invalid command '$1'.${NC}"
        _usage
        exit 1
        ;;
esac
