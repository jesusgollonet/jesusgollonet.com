#!/bin/bash

preview(){
    (cd build
    middleman && open http://localhost:4567)
}

build(){
    (cd build
    bundle exec middleman build)
}