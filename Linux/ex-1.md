### Exercise 1: Getting Familiar with File Management

1. Create a directory named devops_project in your home directory.
2. Inside the devops_project folder, create the following structure using a single command:
    ```sh
    devops_project/
    ├── scripts/
    ├── bin/
        └── tools/
    └── logs/
    ```
3. Create an empty file called deploy.sh under scripts/ folder.
4. Use the echo command to add the line #!/bin/bash at the beginning of ```deploy.sh```.
5. Add to ```deploy.sh``` commands to save the size and permissions of the devops_project dir and sub-dirs to file ```logs/tree.txt``` using appropriate commands.
6. Change the permissions to make the script executable for the owner only.
7. Create a compressed archive of the entire devops_project/ directory using tar.