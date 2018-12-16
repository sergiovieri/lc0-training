python selfplay --no-share-trees --resign-playthrough=100 --no-noise --cpuct=2.0 --tempdecay-moves=10 --backend=multiplexing \
--parallelism=32 --games=$1 \
--player1.backend-opts="(backend=cudnn-fp16,gpu=0)" \
--player1.visits=$2 --player2.backend-opts="(backend=cudnn-fp16,gpu=1)" --player2.weights="/home/s/sergio-v/$3" \
--player2.visits=$2 | grep -E --line-buffered 'gameready|tournamentstatus'
