total=$(cat xgp* | grep "fp_th" | wc -l)
idx=`expr $total / 20`
mid=`expr $total / 2`
echo $idx/$total
#cat xgp* | grep "fp_th" | sort | head -n 1
cat xgp* | grep "fp_th" | sort | head -n $idx
echo ""
cat xgp* | grep "fp_th" | sort | head -n $mid | tail -n 1
cat xgp* | grep "fp_th" | sort | tail -n 1
