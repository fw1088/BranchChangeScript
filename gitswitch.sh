#!/bin/bash -x
##author fangwei 2016.12.11

PROJECTS_DIR=/Users/crl

##用于控制切换分支的时候是否拉取
ISUPDATE=1 

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

##更新所有目录，并拉取
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
            fi
        fi
    done
}

##拉取分支
function update_branch(){
    if [ -n "$1" ];then
        branchparam=`git branch -a | grep "$1"`
        if [ -n branchparam ];then
            `git checkout "$1"`
        fi
    fi
}

##主函数开始执行
if [ ! -d "$PROJECTS_DIR" ];then
    PROJECTS_DIR="$PWD"
    echo $PROJECTS_DIR
fi
cd $PROJECTS_DIR
update_all $1
