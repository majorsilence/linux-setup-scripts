#!/bin/bash

USER=""
PASSWORD=""

SERVER_LIST=(
"SERVER1,USER_OVERRIDE,PASSWORD_OVERRIDE"
"SERVER2,,"
)

SCRIPT_LIST=(
"PLACEHOLDER/SCRIPT/PATH.sh"
"PLACEHOLDER/SCRIPT/PATH2.sh"
)

# Function that performs some task
perform_task() {
    ssh_server=$1
    ssh_user=$2
    ssh_password=$3
    echo "Start task $ssh_server"
    for script_path in ${SCRIPT_LIST[*]}
    do
      scp $script_path $ssh_user@$ssh_server:/home/$ssh_user
      sshpass -p "$ssh_password" ssh "$ssh_user@$ssh_server" "chmod +x /home/$ssh_user/$script_path && sudo /home/$ssh_user/$script_path"
    done
    echo "Finish task $ssh_server"
}


for item in ${SERVER_LIST[*]}
do
    server=`echo $item | cut -d "," -f 1`
    user_temp=`echo $item | cut -d "," -f 2`
    password_temp=`echo $item | cut -d "," -f 3`
    if [[ -z "${user_temp//[:space:]}" ]]; then
      USER=$user_temp
    fi
    if [[ -z "${password_temp//[:space:]}" ]]; then
      PASSWORD=$password_temp
    fi

    # Perform tasks in parallel using background processes
    perform_task "$server" "$USER" "$PASSWORD" &
done

# Wait for all background processes to finish
wait
echo "All tasks completed"
