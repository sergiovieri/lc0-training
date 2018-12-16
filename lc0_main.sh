cd
cd cpp
source ~/.profile
for i in $(eval echo {0..$1})
do
    tmux new-session -d -s "$i" ./exec.sh $i ${HOSTNAME}$i
done
