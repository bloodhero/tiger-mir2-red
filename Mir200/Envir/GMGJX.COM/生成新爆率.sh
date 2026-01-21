#!/bin/bash

# 整合全部装备
cd Group/Items
baotable=()
for item in *; do
    
    while read line; do
        baotable+=("$line")
    done < $item
done
cd -

#整合所有boss
bosstable=()
while read line; do
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
        # 去掉爆率表中已有装备
        
        for i in `cat $file |awk '{print $2}'`; do
            if [[ "${baotable[@]}" =~ .*"${i}".* ]]; then
                # 如果装备在列表中，删除该装备爆率
                sed -i "/$i/d" $file
                
            fi
        done
        
        
        # 载入爆率模板
        
        cat ../默认分组/10级基础怪/Values.txt >> $file
        
        # 按血量微调爆率
        xueDiff=$((100 - 0))
        realDiff=$((100 - $hp))
        chaPercent=`echo "$realDiff / $xueDiff" | bc -l`
        echo "chapercent  = $chaPercent"
        
        step=20
        aaaa=20
        aaaa=`echo "$aaaa + $step * $chaPercent" | bc -l`
        aaaa=`printf "%.0f" "$aaaa"`
        echo "aaaa # $aaaa"
        # 如果为特殊怪
        result=$(echo $monName | grep -E '0|8|3')
        if [[ $result != "" ]]; then
            upPercent=0.15
            aaaa=`echo "$aaaa * ( 1 - $upPercent)" | bc -l`
            aaaa=`printf "%.0f" "$aaaa"`
            echo "为特殊怪"
            echo "aaaa # $aaaa"
        fi
        
        # 如果为boss
        
        
        for e in "${bosstable[@]}"; do
            
            if [[ "$e" =~ .*"$monName".* ]]; then
                echo "This is a boss"
                echo "">> $file
                echo "1/5      金条">> $file
                echo "1/5      银元宝">> $file
                echo "1/15     金元宝">> $file
                break
            fi
        done
        
        
        
        # 写入爆率
        sed -i "s/aaaa/$aaaa/g" $file
        sed -i '/^[[:space:]]*$/d' $file
        
        
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
        
        
        for e in "${bosstable[@]}"; do
            
            if [[ "$e" =~ .*"$monName".* ]]; then
                echo "This is a boss"
                echo "">> $file
                echo "1/5      金条">> $file
                echo "1/5      银元宝">> $file
                echo "1/15     金元宝">> $file
                break
            fi
        done
        
        
        
        # 写入爆率
        sed -i "s/aaaa/$aaaa/g" $file
        sed -i "s/bbbb/$bbbb/g" $file
        sed -i '/^[[:space:]]*$/d' $file
    fi
    
    if [ "$hp" -gt 500 ] && [ "$hp" -le 1000 ]; then
        ## 两个条件都为真时要执行的语句
        echo "500...1000"
        
        # 去掉爆率表中已有装备
        
        for i in `cat $file |awk '{print $2}'`; do
            if [[ "${baotable[@]}" =~ " ${i}" ]]; then
                # 如果装备在列表中，删除该装备爆率
                sed -i "/$i/d" $file
                
            fi
        done
        
        
        # 载入爆率模板
        
        cat ../默认分组/20级基础怪/Values.txt >> $file
        
        # 按血量微调爆率
        xueDiff=$((1000 - 500))
        realDiff=$((1000 - $hp))
        chaPercent=`echo "$realDiff / $xueDiff" | bc -l`
        echo "chapercent  = $chaPercent"
        
        step=20
        aaaa=20
        bbbb=40
        cccc=60
        aaaa=`echo "$aaaa + $step * $chaPercent" | bc -l`
        bbbb=`echo "$bbbb + $step * $chaPercent" | bc -l`
        cccc=`echo "$cccc + $step * $chaPercent" | bc -l`
        aaaa=`printf "%.0f" "$aaaa"`
        bbbb=`printf "%.0f" "$bbbb"`
        cccc=`printf "%.0f" "$cccc"`
        echo "aaaa # $aaaa"
        echo "bbbb # $bbbb"
        echo "cccc # $cccc"
        # 如果为特殊怪
        result=$(echo $monName | grep -E '0|8|3')
        if [[ $result != "" ]]; then
            upPercent=0.15
            aaaa=`echo "$aaaa * ( 1 - $upPercent)" | bc -l`
            bbbb=`echo "$bbbb * ( 1 - $upPercent)" | bc -l`
            cccc=`echo "$cccc * ( 1 - $upPercent)" | bc -l`
            aaaa=`printf "%.0f" "$aaaa"`
            bbbb=`printf "%.0f" "$bbbb"`
            cccc=`printf "%.0f" "$cccc"`
            echo "为特殊怪"
            echo "aaaa # $aaaa"
            echo "bbbb # $bbbb"
            echo "cccc # $cccc"
        fi
        
        # 如果为boss
        
        
        for e in "${bosstable[@]}"; do
            
            if [[ "$e" =~ .*"$monName".* ]]; then
                echo "This is a boss"
                echo "">> $file
                echo "1/5      金条">> $file
                echo "1/5      银元宝">> $file
                echo "1/15     金元宝">> $file
                break
            fi
        done
        
        
        
        
        # 写入爆率
        sed -i "s/aaaa/$aaaa/g" $file
        sed -i "s/bbbb/$bbbb/g" $file
        sed -i "s/cccc/$cccc/g" $file
        sed -i '/^[[:space:]]*$/d' $file
        
        
    fi
    
    if [ "$hp" -gt 1000 ] && [ "$hp" -le 2000 ]; then
        ## 两个条件都为真时要执行的语句
        echo "1000...2000"
        # 去掉爆率表中已有装备
        
        for i in `cat $file |awk '{print $2}'`; do
            if [[ "${baotable[@]}" =~ " ${i}" ]]; then
                # 如果装备在列表中，删除该装备爆率
                sed -i "/$i/d" $file
                
            fi
        done
        
        
        # 载入爆率模板
        
        cat ../默认分组/25级基础怪/Values.txt >> $file
        
        # 按血量微调爆率
        top=2000
        bottom=1000
        xueDiff=$(($top - $bottom))
        realDiff=$(($top - $hp))
        chaPercent=`echo "$realDiff / $xueDiff" | bc -l`
        echo "chapercent  = $chaPercent"
        
        step=20
        aaaa=20
        bbbb=40
        cccc=60
        dddd=80
        eeee=100
        aaaa=`echo "$aaaa + $step * $chaPercent" | bc -l`
        bbbb=`echo "$bbbb + $step * $chaPercent" | bc -l`
        cccc=`echo "$cccc + $step * $chaPercent" | bc -l`
        dddd=`echo "$dddd + $step * $chaPercent" | bc -l`
        eeee=`echo "$eeee + $step * $chaPercent" | bc -l`
        aaaa=`printf "%.0f" "$aaaa"`
        bbbb=`printf "%.0f" "$bbbb"`
        cccc=`printf "%.0f" "$cccc"`
        dddd=`printf "%.0f" "$dddd"`
        eeee=`printf "%.0f" "$eeee"`
        echo "aaaa # $aaaa"
        echo "bbbb # $bbbb"
        echo "cccc # $cccc"
        echo "dddd # $dddd"
        echo "eeee # $eeee"
        # 如果为特殊怪
        result=$(echo $monName | grep -E '0|8|3')
        if [[ $result != "" ]]; then
            upPercent=0.15
            aaaa=`echo "$aaaa * ( 1 - $upPercent)" | bc -l`
            bbbb=`echo "$bbbb * ( 1 - $upPercent)" | bc -l`
            cccc=`echo "$cccc * ( 1 - $upPercent)" | bc -l`
            dddd=`echo "$dddd * ( 1 - $upPercent)" | bc -l`
            eeee=`echo "$eeee * ( 1 - $upPercent)" | bc -l`
            aaaa=`printf "%.0f" "$aaaa"`
            bbbb=`printf "%.0f" "$bbbb"`
            cccc=`printf "%.0f" "$cccc"`
            dddd=`printf "%.0f" "$dddd"`
            eeee=`printf "%.0f" "$eeee"`
            echo "为特殊怪"
            echo "aaaa # $aaaa"
            echo "bbbb # $bbbb"
            echo "cccc # $cccc"
            echo "dddd # $dddd"
            echo "eeee # $eeee"
        fi
        
        # 如果为boss
        
        
        for e in "${bosstable[@]}"; do
            
            if [[ "$e" =~ .*"$monName".* ]]; then
                echo "This is a boss"
                echo "">> $file
                echo "1/5      金条">> $file
                echo "1/5      银元宝">> $file
                echo "1/15     金元宝">> $file
                break
            fi
        done
        
        
        
        
        # 写入爆率
        sed -i "s/aaaa/$aaaa/g" $file
        sed -i "s/bbbb/$bbbb/g" $file
        sed -i "s/cccc/$cccc/g" $file
        sed -i "s/dddd/$dddd/g" $file
        sed -i "s/eeee/$eeee/g" $file
        sed -i '/^[[:space:]]*$/d' $file
        
    fi
    
    if [ "$hp" -gt 2000 ] && [ "$hp" -le 3000 ]; then
        ## 两个条件都为真时要执行的语句
        echo "2000...3000"
        # 去掉爆率表中已有装备
        
        for i in `cat $file |awk '{print $2}'`; do
            if [[ "${baotable[@]}" =~ " ${i}" ]]; then
                # 如果装备在列表中，删除该装备爆率
                sed -i "/$i/d" $file
                
            fi
        done
        
        
        # 载入爆率模板
        
        cat ../默认分组/30级基础怪/Values.txt >> $file
        
        # 按血量微调爆率
        top=3000
        bottom=2000
        xueDiff=$(($top - $bottom))
        realDiff=$(($top - $hp))
        chaPercent=`echo "$realDiff / $xueDiff" | bc -l`
        echo "chapercent  = $chaPercent"
        
        step=20
        aaaa=20
        bbbb=40
        cccc=60
        dddd=80
        eeee=100
        aaaa=`echo "$aaaa + $step * $chaPercent" | bc -l`
        bbbb=`echo "$bbbb + $step * $chaPercent" | bc -l`
        cccc=`echo "$cccc + $step * $chaPercent" | bc -l`
        dddd=`echo "$dddd + $step * $chaPercent" | bc -l`
        eeee=`echo "$eeee + $step * $chaPercent" | bc -l`
        aaaa=`printf "%.0f" "$aaaa"`
        bbbb=`printf "%.0f" "$bbbb"`
        cccc=`printf "%.0f" "$cccc"`
        dddd=`printf "%.0f" "$dddd"`
        eeee=`printf "%.0f" "$eeee"`
        echo "aaaa # $aaaa"
        echo "bbbb # $bbbb"
        echo "cccc # $cccc"
        echo "dddd # $dddd"
        echo "eeee # $eeee"
        # 如果为特殊怪
        result=$(echo $monName | grep -E '0|8|3')
        if [[ $result != "" ]]; then
            upPercent=0.15
            aaaa=`echo "$aaaa * ( 1 - $upPercent)" | bc -l`
            bbbb=`echo "$bbbb * ( 1 - $upPercent)" | bc -l`
            cccc=`echo "$cccc * ( 1 - $upPercent)" | bc -l`
            dddd=`echo "$dddd * ( 1 - $upPercent)" | bc -l`
            eeee=`echo "$eeee * ( 1 - $upPercent)" | bc -l`
            aaaa=`printf "%.0f" "$aaaa"`
            bbbb=`printf "%.0f" "$bbbb"`
            cccc=`printf "%.0f" "$cccc"`
            dddd=`printf "%.0f" "$dddd"`
            eeee=`printf "%.0f" "$eeee"`
            echo "为特殊怪"
            echo "aaaa # $aaaa"
            echo "bbbb # $bbbb"
            echo "cccc # $cccc"
            echo "dddd # $dddd"
            echo "eeee # $eeee"
        fi
        
        # 如果为boss
        
        
        for e in "${bosstable[@]}"; do
            
            if [[ "$e" =~ .*"$monName".* ]]; then
                echo "This is a boss"
                # 清空爆率
                for i in `cat $file |awk '{print $2}'`; do
                    if [[ "${baotable[@]}" =~ " ${i}" ]]; then
                        # 如果装备在列表中，删除该装备爆率
                        sed -i "/$i/d" $file
                        
                    fi
                done
                
                
                # 载入boss爆率模板
                
                cat ../默认分组/30级boss/Values.txt >> $file
                cccc=100
                break
            fi
        done
        
        
        
        dddd=200
        eeee=300
        ffff=400
        gggg=500
        hhhh=600
        iiii=700
        # 写入爆率
        sed -i "s/aaaa/$aaaa/g" $file
        sed -i "s/bbbb/$bbbb/g" $file
        sed -i "s/cccc/$cccc/g" $file
        sed -i "s/dddd/$dddd/g" $file
        sed -i "s/eeee/$eeee/g" $file
        sed -i "s/ffff/$ffff/g" $file
        sed -i "s/gggg/$gggg/g" $file
        sed -i "s/hhhh/$hhhh/g" $file
        sed -i "s/iiii/$iiii/g" $file
        sed -i '/^[[:space:]]*$/d' $file
        
        
        
    fi
    
    if [ "$hp" -gt 3000 ] && [ "$hp" -le 5000 ]; then
        ## 两个条件都为真时要执行的语句
        echo "3000...5000"
        # 去掉爆率表中已有装备
        
        for i in `cat $file |awk '{print $2}'`; do
            if [[ "${baotable[@]}" =~ " ${i}" ]]; then
                # 如果装备在列表中，删除该装备爆率
                sed -i "/$i/d" $file
                
            fi
        done
        
        
        # 载入爆率模板
        
        cat ../默认分组/35级基础怪/Values.txt >> $file
        
        # 按血量微调爆率
        top=5000
        bottom=3000
        xueDiff=$(($top - $bottom))
        realDiff=$(($top - $hp))
        chaPercent=`echo "$realDiff / $xueDiff" | bc -l`
        echo "chapercent  = $chaPercent"
        
        step=20
        aaaa=20
        bbbb=40
        cccc=60
        dddd=80
        eeee=100
        aaaa=`echo "$aaaa + $step * $chaPercent" | bc -l`
        bbbb=`echo "$bbbb + $step * $chaPercent" | bc -l`
        cccc=`echo "$cccc + $step * $chaPercent" | bc -l`
        dddd=`echo "$dddd + $step * $chaPercent" | bc -l`
        eeee=`echo "$eeee + $step * $chaPercent" | bc -l`
        aaaa=`printf "%.0f" "$aaaa"`
        bbbb=`printf "%.0f" "$bbbb"`
        cccc=`printf "%.0f" "$cccc"`
        dddd=`printf "%.0f" "$dddd"`
        eeee=`printf "%.0f" "$eeee"`
        echo "aaaa # $aaaa"
        echo "bbbb # $bbbb"
        echo "cccc # $cccc"
        echo "dddd # $dddd"
        echo "eeee # $eeee"
        # 如果为特殊怪
        result=$(echo $monName | grep -E '0|8|3')
        if [[ $result != "" ]]; then
            upPercent=0.15
            aaaa=`echo "$aaaa * ( 1 - $upPercent)" | bc -l`
            bbbb=`echo "$bbbb * ( 1 - $upPercent)" | bc -l`
            cccc=`echo "$cccc * ( 1 - $upPercent)" | bc -l`
            dddd=`echo "$dddd * ( 1 - $upPercent)" | bc -l`
            eeee=`echo "$eeee * ( 1 - $upPercent)" | bc -l`
            aaaa=`printf "%.0f" "$aaaa"`
            bbbb=`printf "%.0f" "$bbbb"`
            cccc=`printf "%.0f" "$cccc"`
            dddd=`printf "%.0f" "$dddd"`
            eeee=`printf "%.0f" "$eeee"`
            echo "为特殊怪"
            echo "aaaa # $aaaa"
            echo "bbbb # $bbbb"
            echo "cccc # $cccc"
            echo "dddd # $dddd"
            echo "eeee # $eeee"
        fi
        
        # 如果为boss
        
        
        for e in "${bosstable[@]}"; do
            
            if [[ "$e" =~ .*"$monName".* ]]; then
                echo "This is a boss"
                # 清空爆率
                for i in `cat $file |awk '{print $2}'`; do
                    if [[ "${baotable[@]}" =~ " ${i}" ]]; then
                        # 如果装备在列表中，删除该装备爆率
                        sed -i "/$i/d" $file
                        
                    fi
                done
                
                
                # 载入boss爆率模板
                
                cat ../默认分组/35级boss/Values.txt >> $file
                cccc=100
                break
            fi
        done
        
        
        
        dddd=200
        eeee=300
        ffff=400
        gggg=500
        hhhh=600
        iiii=700
        # 写入爆率
        sed -i "s/aaaa/$aaaa/g" $file
        sed -i "s/bbbb/$bbbb/g" $file
        sed -i "s/cccc/$cccc/g" $file
        sed -i "s/dddd/$dddd/g" $file
        sed -i "s/eeee/$eeee/g" $file
        sed -i "s/ffff/$ffff/g" $file
        sed -i "s/gggg/$gggg/g" $file
        sed -i "s/hhhh/$hhhh/g" $file
        sed -i "s/iiii/$iiii/g" $file
        sed -i '/^[[:space:]]*$/d' $file
        
        
        
        # 如果为boss
        # 清空爆率
        # 载入boss爆率模板
        
    fi
    
    if [ "$hp" -gt 5000 ] && [ "$hp" -le 8000 ]; then
        ## 两个条件都为真时要执行的语句
        echo "5000...8000"
        # 去掉爆率表中已有装备
        
        for i in `cat $file |awk '{print $2}'`; do
            if [[ "${baotable[@]}" =~ " ${i}" ]]; then
                # 如果装备在列表中，删除该装备爆率
                sed -i "/$i/d" $file
                
            fi
        done
        
        
        # 载入爆率模板
        
        cat ../默认分组/40级基础怪/Values.txt >> $file
        
        # 按血量微调爆率
        top=8000
        bottom=5000
        xueDiff=$(($top - $bottom))
        realDiff=$(($top - $hp))
        chaPercent=`echo "$realDiff / $xueDiff" | bc -l`
        echo "chapercent  = $chaPercent"
        
        step=20
        aaaa=20
        bbbb=40
        cccc=60
        dddd=80
        eeee=100
        aaaa=`echo "$aaaa + $step * $chaPercent" | bc -l`
        bbbb=`echo "$bbbb + $step * $chaPercent" | bc -l`
        cccc=`echo "$cccc + $step * $chaPercent" | bc -l`
        dddd=`echo "$dddd + $step * $chaPercent" | bc -l`
        eeee=`echo "$eeee + $step * $chaPercent" | bc -l`
        aaaa=`printf "%.0f" "$aaaa"`
        bbbb=`printf "%.0f" "$bbbb"`
        cccc=`printf "%.0f" "$cccc"`
        dddd=`printf "%.0f" "$dddd"`
        eeee=`printf "%.0f" "$eeee"`
        echo "aaaa # $aaaa"
        echo "bbbb # $bbbb"
        echo "cccc # $cccc"
        echo "dddd # $dddd"
        echo "eeee # $eeee"
        # 如果为特殊怪
        result=$(echo $monName | grep -E '0|8|3')
        if [[ $result != "" ]]; then
            upPercent=0.15
            aaaa=`echo "$aaaa * ( 1 - $upPercent)" | bc -l`
            bbbb=`echo "$bbbb * ( 1 - $upPercent)" | bc -l`
            cccc=`echo "$cccc * ( 1 - $upPercent)" | bc -l`
            dddd=`echo "$dddd * ( 1 - $upPercent)" | bc -l`
            eeee=`echo "$eeee * ( 1 - $upPercent)" | bc -l`
            aaaa=`printf "%.0f" "$aaaa"`
            bbbb=`printf "%.0f" "$bbbb"`
            cccc=`printf "%.0f" "$cccc"`
            dddd=`printf "%.0f" "$dddd"`
            eeee=`printf "%.0f" "$eeee"`
            echo "为特殊怪"
            echo "aaaa # $aaaa"
            echo "bbbb # $bbbb"
            echo "cccc # $cccc"
            echo "dddd # $dddd"
            echo "eeee # $eeee"
        fi
        
        # 如果为boss
        
        
        for e in "${bosstable[@]}"; do
            
            if [[ "$e" =~ .*"$monName".* ]]; then
                echo "This is a boss"
                # 清空爆率
                for i in `cat $file |awk '{print $2}'`; do
                    if [[ "${baotable[@]}" =~ " ${i}" ]]; then
                        # 如果装备在列表中，删除该装备爆率
                        sed -i "/$i/d" $file
                        
                    fi
                done
                
                
                # 载入boss爆率模板
                
                cat ../默认分组/40级boss/Values.txt >> $file
                bbbb=100
                cccc=200
                break
            fi
        done
        
        
        
        dddd=300
        eeee=400
        ffff=500
        gggg=600
        hhhh=700
        iiii=800
        # 写入爆率
        sed -i "s/aaaa/$aaaa/g" $file
        sed -i "s/bbbb/$bbbb/g" $file
        sed -i "s/cccc/$cccc/g" $file
        sed -i "s/dddd/$dddd/g" $file
        sed -i "s/eeee/$eeee/g" $file
        sed -i "s/ffff/$ffff/g" $file
        sed -i "s/gggg/$gggg/g" $file
        sed -i "s/hhhh/$hhhh/g" $file
        sed -i "s/iiii/$iiii/g" $file
        sed -i '/^[[:space:]]*$/d' $file
        
        
    fi
    
    
    if [ "$hp" -gt 8000 ] && [ "$hp" -le 15000 ]; then
        ## 两个条件都为真时要执行的语句
        echo "8000...15000"
        # 去掉爆率表中已有装备
        
        for i in `cat $file |awk '{print $2}'`; do
            if [[ "${baotable[@]}" =~ " ${i}" ]]; then
                # 如果装备在列表中，删除该装备爆率
                sed -i "/$i/d" $file
                
            fi
        done
        
        
        # 载入爆率模板
        
        cat ../默认分组/45级基础怪/Values.txt >> $file
        
        # 按血量微调爆率
        top=15000
        bottom=8000
        xueDiff=$(($top - $bottom))
        realDiff=$(($top - $hp))
        chaPercent=`echo "$realDiff / $xueDiff" | bc -l`
        echo "chapercent  = $chaPercent"
        
        step=20
        aaaa=20
        bbbb=40
        cccc=60
        dddd=80
        eeee=100
        aaaa=`echo "$aaaa + $step * $chaPercent" | bc -l`
        bbbb=`echo "$bbbb + $step * $chaPercent" | bc -l`
        cccc=`echo "$cccc + $step * $chaPercent" | bc -l`
        dddd=`echo "$dddd + $step * $chaPercent" | bc -l`
        eeee=`echo "$eeee + $step * $chaPercent" | bc -l`
        aaaa=`printf "%.0f" "$aaaa"`
        bbbb=`printf "%.0f" "$bbbb"`
        cccc=`printf "%.0f" "$cccc"`
        dddd=`printf "%.0f" "$dddd"`
        eeee=`printf "%.0f" "$eeee"`
        echo "aaaa # $aaaa"
        echo "bbbb # $bbbb"
        echo "cccc # $cccc"
        echo "dddd # $dddd"
        echo "eeee # $eeee"
        # 如果为特殊怪
        result=$(echo $monName | grep -E '0|8|3')
        if [[ $result != "" ]]; then
            upPercent=0.15
            aaaa=`echo "$aaaa * ( 1 - $upPercent)" | bc -l`
            bbbb=`echo "$bbbb * ( 1 - $upPercent)" | bc -l`
            cccc=`echo "$cccc * ( 1 - $upPercent)" | bc -l`
            dddd=`echo "$dddd * ( 1 - $upPercent)" | bc -l`
            eeee=`echo "$eeee * ( 1 - $upPercent)" | bc -l`
            aaaa=`printf "%.0f" "$aaaa"`
            bbbb=`printf "%.0f" "$bbbb"`
            cccc=`printf "%.0f" "$cccc"`
            dddd=`printf "%.0f" "$dddd"`
            eeee=`printf "%.0f" "$eeee"`
            echo "为特殊怪"
            echo "aaaa # $aaaa"
            echo "bbbb # $bbbb"
            echo "cccc # $cccc"
            echo "dddd # $dddd"
            echo "eeee # $eeee"
        fi
        
        # 如果为boss
        
        
        for e in "${bosstable[@]}"; do
            
            if [[ "$e" =~ .*"$monName".* ]]; then
                echo "This is a boss"
                # 清空爆率
                for i in `cat $file |awk '{print $2}'`; do
                    if [[ "${baotable[@]}" =~ " ${i}" ]]; then
                        # 如果装备在列表中，删除该装备爆率
                        sed -i "/$i/d" $file
                        
                    fi
                done
                
                
                # 载入boss爆率模板
                
                cat ../默认分组/45级boss/Values.txt >> $file
                bbbb=100
                cccc=200
                break
            fi
        done
        
        
        
        dddd=300
        eeee=400
        ffff=500
        gggg=600
        hhhh=700
        iiii=800
        # 写入爆率
        sed -i "s/aaaa/$aaaa/g" $file
        sed -i "s/bbbb/$bbbb/g" $file
        sed -i "s/cccc/$cccc/g" $file
        sed -i "s/dddd/$dddd/g" $file
        sed -i "s/eeee/$eeee/g" $file
        sed -i "s/ffff/$ffff/g" $file
        sed -i "s/gggg/$gggg/g" $file
        sed -i "s/hhhh/$hhhh/g" $file
        sed -i "s/iiii/$iiii/g" $file
        sed -i '/^[[:space:]]*$/d' $file
        
    fi
    
    if [ "$hp" -gt 15000 ] && [ "$hp" -le 24000 ]; then
        ## 两个条件都为真时要执行的语句
        echo "15000...24000"
        # 去掉爆率表中已有装备
        
        for i in `cat $file |awk '{print $2}'`; do
            if [[ "${baotable[@]}" =~ " ${i}" ]]; then
                # 如果装备在列表中，删除该装备爆率
                sed -i "/$i/d" $file
                
            fi
        done
        
        
        # 载入爆率模板
        
        cat ../默认分组/50级基础怪/Values.txt >> $file
        
        # 按血量微调爆率
        top=24000
        bottom=15000
        xueDiff=$(($top - $bottom))
        realDiff=$(($top - $hp))
        chaPercent=`echo "$realDiff / $xueDiff" | bc -l`
        echo "chapercent  = $chaPercent"
        
        step=20
        aaaa=20
        bbbb=40
        cccc=60
        dddd=80
        eeee=100
        aaaa=`echo "$aaaa + $step * $chaPercent" | bc -l`
        bbbb=`echo "$bbbb + $step * $chaPercent" | bc -l`
        cccc=`echo "$cccc + $step * $chaPercent" | bc -l`
        dddd=`echo "$dddd + $step * $chaPercent" | bc -l`
        eeee=`echo "$eeee + $step * $chaPercent" | bc -l`
        aaaa=`printf "%.0f" "$aaaa"`
        bbbb=`printf "%.0f" "$bbbb"`
        cccc=`printf "%.0f" "$cccc"`
        dddd=`printf "%.0f" "$dddd"`
        eeee=`printf "%.0f" "$eeee"`
        echo "aaaa # $aaaa"
        echo "bbbb # $bbbb"
        echo "cccc # $cccc"
        echo "dddd # $dddd"
        echo "eeee # $eeee"
        # 如果为特殊怪
        result=$(echo $monName | grep -E '0|8|3')
        if [[ $result != "" ]]; then
            upPercent=0.15
            aaaa=`echo "$aaaa * ( 1 - $upPercent)" | bc -l`
            bbbb=`echo "$bbbb * ( 1 - $upPercent)" | bc -l`
            cccc=`echo "$cccc * ( 1 - $upPercent)" | bc -l`
            dddd=`echo "$dddd * ( 1 - $upPercent)" | bc -l`
            eeee=`echo "$eeee * ( 1 - $upPercent)" | bc -l`
            aaaa=`printf "%.0f" "$aaaa"`
            bbbb=`printf "%.0f" "$bbbb"`
            cccc=`printf "%.0f" "$cccc"`
            dddd=`printf "%.0f" "$dddd"`
            eeee=`printf "%.0f" "$eeee"`
            echo "为特殊怪"
            echo "aaaa # $aaaa"
            echo "bbbb # $bbbb"
            echo "cccc # $cccc"
            echo "dddd # $dddd"
            echo "eeee # $eeee"
        fi
        
        # 如果为boss
        
        
        for e in "${bosstable[@]}"; do
            
            if [[ "$e" =~ .*"$monName".* ]]; then
                echo "This is a boss"
                # 清空爆率
                for i in `cat $file |awk '{print $2}'`; do
                    if [[ "${baotable[@]}" =~ " ${i}" ]]; then
                        # 如果装备在列表中，删除该装备爆率
                        sed -i "/$i/d" $file
                        
                    fi
                done
                
                
                # 载入boss爆率模板
                
                cat ../默认分组/50级boss/Values.txt >> $file
                bbbb=100
                cccc=200
                break
            fi
        done
        
        
        
        dddd=300
        eeee=400
        ffff=500
        gggg=600
        hhhh=700
        iiii=800
        # 写入爆率
        sed -i "s/aaaa/$aaaa/g" $file
        sed -i "s/bbbb/$bbbb/g" $file
        sed -i "s/cccc/$cccc/g" $file
        sed -i "s/dddd/$dddd/g" $file
        sed -i "s/eeee/$eeee/g" $file
        sed -i "s/ffff/$ffff/g" $file
        sed -i "s/gggg/$gggg/g" $file
        sed -i "s/hhhh/$hhhh/g" $file
        sed -i "s/iiii/$iiii/g" $file
        sed -i '/^[[:space:]]*$/d' $file
        
    fi
    
    if [ "$hp" -gt 24000 ] && [ "$hp" -le 32000 ]; then
        ## 两个条件都为真时要执行的语句
        echo "24000...32000"
        
        # 去掉爆率表中已有装备
        
        for i in `cat $file |awk '{print $2}'`; do
            if [[ "${baotable[@]}" =~ " ${i}" ]]; then
                # 如果装备在列表中，删除该装备爆率
                sed -i "/$i/d" $file
                
            fi
        done
        
        
        # 载入爆率模板
        
        cat ../默认分组/55级基础怪/Values.txt >> $file
        
        # 按血量微调爆率
        top=32000
        bottom=24000
        xueDiff=$(($top - $bottom))
        realDiff=$(($top - $hp))
        chaPercent=`echo "$realDiff / $xueDiff" | bc -l`
        echo "chapercent  = $chaPercent"
        
        step=20
        aaaa=20
        bbbb=40
        cccc=60
        dddd=80
        eeee=100
        aaaa=`echo "$aaaa + $step * $chaPercent" | bc -l`
        bbbb=`echo "$bbbb + $step * $chaPercent" | bc -l`
        cccc=`echo "$cccc + $step * $chaPercent" | bc -l`
        dddd=`echo "$dddd + $step * $chaPercent" | bc -l`
        eeee=`echo "$eeee + $step * $chaPercent" | bc -l`
        aaaa=`printf "%.0f" "$aaaa"`
        bbbb=`printf "%.0f" "$bbbb"`
        cccc=`printf "%.0f" "$cccc"`
        dddd=`printf "%.0f" "$dddd"`
        eeee=`printf "%.0f" "$eeee"`
        echo "aaaa # $aaaa"
        echo "bbbb # $bbbb"
        echo "cccc # $cccc"
        echo "dddd # $dddd"
        echo "eeee # $eeee"
        # 如果为特殊怪
        result=$(echo $monName | grep -E '0|8|3')
        if [[ $result != "" ]]; then
            upPercent=0.15
            aaaa=`echo "$aaaa * ( 1 - $upPercent)" | bc -l`
            bbbb=`echo "$bbbb * ( 1 - $upPercent)" | bc -l`
            cccc=`echo "$cccc * ( 1 - $upPercent)" | bc -l`
            dddd=`echo "$dddd * ( 1 - $upPercent)" | bc -l`
            eeee=`echo "$eeee * ( 1 - $upPercent)" | bc -l`
            aaaa=`printf "%.0f" "$aaaa"`
            bbbb=`printf "%.0f" "$bbbb"`
            cccc=`printf "%.0f" "$cccc"`
            dddd=`printf "%.0f" "$dddd"`
            eeee=`printf "%.0f" "$eeee"`
            echo "为特殊怪"
            echo "aaaa # $aaaa"
            echo "bbbb # $bbbb"
            echo "cccc # $cccc"
            echo "dddd # $dddd"
            echo "eeee # $eeee"
        fi
        
        # 如果为boss
        
        
        for e in "${bosstable[@]}"; do
            
            if [[ "$e" =~ .*"$monName".* ]]; then
                echo "This is a boss"
                # 清空爆率
                for i in `cat $file |awk '{print $2}'`; do
                    if [[ "${baotable[@]}" =~ " ${i}" ]]; then
                        # 如果装备在列表中，删除该装备爆率
                        sed -i "/$i/d" $file
                        
                    fi
                done
                
                
                # 载入boss爆率模板
                
                cat ../默认分组/55级boss/Values.txt >> $file
                
                break
            fi
        done
        
        
        cccc=200
        dddd=300
        eeee=400
        ffff=500
        gggg=600
        hhhh=700
        iiii=800
        # 写入爆率
        sed -i "s/aaaa/$aaaa/g" $file
        sed -i "s/bbbb/$bbbb/g" $file
        sed -i "s/cccc/$cccc/g" $file
        sed -i "s/dddd/$dddd/g" $file
        sed -i "s/eeee/$eeee/g" $file
        sed -i "s/ffff/$ffff/g" $file
        sed -i "s/gggg/$gggg/g" $file
        sed -i "s/hhhh/$hhhh/g" $file
        sed -i "s/iiii/$iiii/g" $file
        sed -i '/^[[:space:]]*$/d' $file
        
    fi
    #break
done
