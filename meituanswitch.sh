#!/bin/bash -x

PROJECTS_DIR=/Users/crl/Desktop/testbranch/DianpingCode
ISUPDATE=0
##排除以下情况
##1.非目录
##2.非git目录

function is_git_dir(){
    param=`find $PWD -name ".git"`
    if [ -z "$param" ];then
        return 1
    else
        return 0
    fi
}

function update_all(){
    for d in `ls`
    do
        if [ -d "$PROJECTS_DIR/$d" ];then
            # echo $d;
            cd $PROJECTS_DIR/$d
            
            if is_git_dir $PWD;then
                if [ $ISUPDATE -eq 1 ];then
                    `git pull`
                fi
                update_branch $1
                echo "update success ^_^"
            else
                echo "$PWD is not a git dir!"
            fi
        else
            echo "$d is not a directory"
        fi
    done
}


function update_branch(){
    if [ -n "$1" ];then
        branchparam=`git branch -a | grep "$1"`
        if [ -n branchparam ];then
            `git checkout "$1"`
        fi
    fi
}
if [ ! -d "$PROJECTS_DIR" ];then
    PROJECTS_DIR="$PWD"
    echo $PROJECTS_DIR
fi
cd $PROJECTS_DIR
update_all $1
