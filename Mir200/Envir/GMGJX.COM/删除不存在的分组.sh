#!/bin/bash


# 指定列表文件和目标文件夹
list_file="./Group/Items.txt"       # 列表文件名称
target_dir="./Group/Items"  # 目标文件夹路径

# 读取列表文件，存放到数组中
mapfile -t list < "$list_file"

# 进入目标文件夹
cd "$target_dir" || { echo "目标文件夹不存在"; exit 1; }

# 遍历目标文件夹下的所有文件
for file in *; do
    # 检查文件是否在列表中，使用双引号防止空格问题
    if [[ ! "${list[@]} " =~ " ${file%.txt}" ]]; then
        # 如果文件不在列表中，删除该文件
        echo "Deleting file: $file"
        rm -f $file
    fi
done
