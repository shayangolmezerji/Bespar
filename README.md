# Bespar: A No-Fuss CLI To-Do App

If you're tired of bloated, slow, and overly-complicated To-Do apps, you've come to the right place. **Bespar** is a simple, lightning-fast, and secure command-line To-Do app written in pure Bash. It provides a minimal yet powerful experience right in your terminal, with zero dependencies and no unnecessary features.

---

### Key Features

* **Blazing Fast:** As a lightweight Bash script, Bespar is designed for speed. It runs instantly, allowing you to manage your tasks without any performance overhead.
* **Fully Secure:** Your task data is stored in a hidden file (`~/.todo.dat`) with permissions set to `600`. This ensures that only the file owner (you) can read or write to it, keeping your data private.
* **Intuitive:** The command syntax is simple and easy to remember. Whether you're a seasoned developer or new to the command line, you'll feel right at home.
* **Full Control:** Get full control over your tasks with straightforward commands to add, list, mark as complete, or delete items.

---

### Getting Started

Getting Bespar up and running is straightforward. Just a few steps and you'll be set.

**For Linux/macOS Users:**

1.  **Clone the repository** or simply download the `todo.sh` file.
2.  **Make it executable** so your system can run the script.
    ```bash
    chmod +x todo.sh
    ```
3.  **Make it a global command** for access from any directory.
    ```bash
    # Create the directory if it doesn't exist
    mkdir -p ~/.local/bin
    
    # Move the script and rename it to 'todo'
    mv todo.sh ~/.local/bin/
    ```
4.  **Update your PATH**. Add this line to your shell's configuration file (`~/.bashrc`, `~/.zshrc`, etc.) to ensure your system knows where to find the `todo` command.
    ```bash
    export PATH="$HOME/.local/bin:$PATH"
    ```
    Afterward, apply the changes by running `source ~/.bashrc` (or your shell's equivalent).

**For Windows Users:**

This script is built for a Unix-like environment. The easiest way to run Bespar on Windows is by using the **Windows Subsystem for Linux (WSL)**. It's the best way to get the full command-line experience on your machine.

---

### Usage

The syntax is clean and straightforward. Here are the core commands you'll need.

| Command               | Description                                           |
| --------------------- | ----------------------------------------------------- |
| `todo add <task>`     | Adds a new task to your list.                         |
| `todo list`           | Shows all your tasks, both completed and pending.     |
| `todo list-u`         | Shows only uncompleted tasks.                         |
| `todo list-c`         | Shows only completed tasks.                           |
| `todo done <number>`  | Marks a task as complete by its line number.          |
| `todo delete <number>`| Deletes a task permanently by its line number.        |
| `todo clear`          | Clears all tasks from the list.                       |
| `todo help`           | Displays the help menu.                               |

#### Examples:

```bash
# Add a new task
todo add "Fix that mf bug bro"

# Add a more complex task
todo add "Finish the Bespar project README.md"

# See what's on your plate
todo list

# Mark task number 1 as done
todo done 1

# Delete a task you don't need anymore
todo delete 2
````

-----

### License

This project is licensed under the [**DON'T BE A DICK PUBLIC LICENSE 1.2**](https://github.com/phuu/dont-be-a-dick-license/blob/master/LICENSE.txt).

-----

### Author

Authored and maintained by [Shayangolmezerji](https://github.com/shayangolmezerji).
