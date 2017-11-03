#!/bin/bash

# depends on nmap

preview(){
    if is_server_up
    then
        open http://localhost:4567
    else
        echo "no server is up. start preview"
        (cd build
        launch_server
        check_localhost_server_is_up)
    fi
}

launch_server(){
    echo "launching middleman server in the background"
    echo "run screen -r to see its output"
    screen -d -m middleman 
}

build(){
    (cd build
    bundle install
    bundle exec middleman build)
}

check_localhost_server_is_up(){
    while true 
    do
        echo "checking if server has booted"
        if is_server_up
        then
            open http://localhost:4567
            break
        fi
        sleep 1
    done
}

is_server_up(){
    if nmap -p 4567 localhost | grep open > /dev/null
    then
        echo "server is up!"
        return 0
    else
        echo "server is down"
        return 1
    fi
}