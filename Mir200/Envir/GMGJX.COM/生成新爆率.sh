#!/bin/bash

    # 整合全部装备
    cd Group/Items
    baotable=()
    for item in *; do 

        while read -r line; do
            baotable+=("$line")
        done < $item
    done
    cd -

    #整合所有boss
    bosstable=()
    while read -r line; do
        bosstable+=("$line")
    done < Group/Mons/boss.txt


target_dir="./MonItems"  # 目标文件夹路径
target_db="../../../../Mud2/DB/REDM2.DB"

# 进入目标文件夹
cd "$target_dir" || { echo "目标文件夹不存在"; exit 1; }


# 遍历目标文件夹下的所有文件
for file in *; do
    # 去掉后缀
    monName=${file%.txt}
    echo $monName

    # 查询血量
    hp=`cat ../血量.csv | grep -E ",${monName}$" |cut -d ',' -f 1`
    echo "hp # $hp"
    if  [[ $hp == "" ]]; then
        rm $file
        echo $file>> delete.txt
        continue
    fi

    

    if [ "$hp" -gt 0 ] && [ "$hp" -le 100 ]; then
    ## 两个条件都为真时要执行的语句
    echo "0...100"
    fi

    if [ "$hp" -gt 100 ] && [ "$hp" -le 500 ]; then
    ## 两个条件都为真时要执行的语句
        echo "100...500"

        # 去掉爆率表中已有装备
        
        for i in `cat $file |awk '{print $2}'`; do
            if [[ "${baotable[@]}" =~ " ${i}" ]]; then
            # 如果装备在列表中，删除该装备爆率
             sed -i "/$i/d" $file
          
            fi
        done

        
        # 载入爆率模板
        
        cat ../默认分组/15级基础怪/Values.txt >> $file

        # 按血量微调爆率
        xueDiff=$((500 - 100))
        realDiff=$((500 - $hp))
        chaPercent=`echo "$realDiff / $xueDiff" | bc -l`
        echo "chapercent  = $chaPercent"

        step=20
        aaaa=20
        bbbb=40
        aaaa=`echo "$aaaa + $step * $chaPercent" | bc -l`
        bbbb=`echo "$bbbb + $step * $chaPercent" | bc -l`
        aaaa=`printf "%.0f" "$aaaa"`
        bbbb=`printf "%.0f" "$bbbb"`
        echo "aaaa # $aaaa"
        echo "bbbb # $bbbb"
        # 如果为特殊怪
        result=$(echo $monName | grep -E '0|8|3')
        if [[ $result != "" ]]; then
        upPercent=0.15
        aaaa=`echo "$aaaa * ( 1 - $upPercent)" | bc -l`
        bbbb=`echo "$bbbb * ( 1 - $upPercent)" | bc -l`
        aaaa=`printf "%.0f" "$aaaa"`
        bbbb=`printf "%.0f" "$bbbb"`
        echo "为特殊怪"
        echo "aaaa # $aaaa"
        echo "bbbb # $bbbb"
        fi

        # 如果为boss
        if [[ "${bosstable[@]}" =~ " ${monName}" ]]; then
            echo "\n">> $file
            echo "1/5      金条">> $file
            echo "1/5      银元宝">> $file
            echo "1/15     金元宝">> $file

        fi
        # 写入爆率
        sed -i "s/aaaa/$aaaa/g" $file
        sed -i "s/bbbb/$bbbb/g" $file
        sed -i '/^[[:space:]]*$/d' $file
    fi

    if [ "$hp" -gt 500 ] && [ "$hp" -le 1000 ]; then
    ## 两个条件都为真时要执行的语句
    echo "500...1000"
    fi

    if [ "$hp" -gt 1000 ] && [ "$hp" -le 2000 ]; then
    ## 两个条件都为真时要执行的语句
    echo "1000...2000"
    fi

    if [ "$hp" -gt 2000 ] && [ "$hp" -le 3000 ]; then
    ## 两个条件都为真时要执行的语句
    echo "2000...3000"

        # 如果为boss

           # 清空爆率


           # 载入boss爆率模板




    fi

    if [ "$hp" -gt 3000 ] && [ "$hp" -le 5000 ]; then
    ## 两个条件都为真时要执行的语句
    echo "3000...5000"

        # 如果为boss
        # 清空爆率
        # 载入boss爆率模板

    fi

    if [ "$hp" -gt 5000 ] && [ "$hp" -le 8000 ]; then
    ## 两个条件都为真时要执行的语句
    echo "5000...8000"
    fi


    if [ "$hp" -gt 8000 ] && [ "$hp" -le 15000 ]; then
    ## 两个条件都为真时要执行的语句
    echo "8000...15000"
    fi

    if [ "$hp" -gt 15000 ] && [ "$hp" -le 24000 ]; then
    ## 两个条件都为真时要执行的语句
    echo "15000...24000"
    fi

    if [ "$hp" -gt 24000 ] && [ "$hp" -le 32000 ]; then
    ## 两个条件都为真时要执行的语句
    echo "24000...32000"
    fi
    #break
done
