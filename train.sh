start() {
    echo "Starting clients"
    ssh sunfire -q './start.sh'
}

stop() {
    echo "Stopping clients"
    ssh sunfire -q './stop.sh'
}

stop

if [ -f stop ]; then
    echo "stop received"
    exit 1
fi

while true
do
    echo "Start training cycle"
    start

    while true
    do
        count=$(./count.sh)
        target=$(cat target)
        echo $count/$target
        if [ $count -ge $target  ]
        then
            break
        fi
        sleep 30
    done

    python3 splitter.py
    find . -type d -empty -delete
    net_id=$(cat net_id)
    net_id=`expr $net_id + 1`
    tr/tf/train.py --cfg tr/tf/configs/256x40.yaml --output networks/net$net_id
    cp /temp/lc0/networks/256x40/*swa* networks/net${net_id}-swa.pb.gz
    rm /temp/lc0/networks/256x40/*swa*
    echo $net_id > net_id
    stop
    if [ -f stop ]; then
        echo "stop received"
        exit 1
    fi
done
