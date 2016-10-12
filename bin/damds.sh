#!/usr/bin/env bash

#jar=damds-1.1-jar-with-dependencies.jar
jar=damds-1.1-lrt-jar-with-dependencies.jar
x='x'
#opts="-XX:+UseConcMarkSweepGC -XX:ParallelCMSThreads=4 -Xms2G -Xmx2G"
opts="-XX:+UseG1GC -Xms768m -Xmx1024m"
tpn=1
wd=`pwd`
summary=summary.txt
timing=timing.txt
p=$9
n=${10}
#$BUILD/bin/mpirun --report-bindings --mca btl ^tcp -np $p --hostfile nodes.txt java $opts -cp ../target/$jar -DDistanceMatrixFile=$1 -DWeightMatrixFile=$2 -DPointsFile=$3.txt -DNumberDataPoints=$4 -DTimingFile=$5 -DSummaryFile=$6 -DInitialPointsFile=$7 edu.indiana.soic.spidal.damds.Program -c $8 -n $n -t $tpn | tee $6
#$BUILD/bin/mpirun --report-bindings  --map-by ppr:1:core --mca btl ^openib --mca btl_tcp_if_include eth2 -np $p --hostfile nodes.txt java $opts -cp ../target/$jar -DDistanceMatrixFile=$1 -DWeightMatrixFile=$2 -DPointsFile=$3.txt -DNumberDataPoints=$4 -DTimingFile=$5 -DSummaryFile=$6 -DInitialPointsFile=$7 edu.indiana.soic.spidal.damds.Program -c $8 -n $n -t $tpn 2>&1 | tee $6
$BUILD/bin/mpirun --report-bindings  --map-by ppr:1:core --mca btl ^openib --mca btl_tcp_if_include eth2 -np $p --hostfile nodes.txt java $opts -cp ../target/$jar -DDistanceMatrixFile=$1 -DWeightMatrixFile=$2 -DPointsFile=$3.txt -DNumberDataPoints=$4 -DTimingFile=$5 -DSummaryFile=$6 -DInitialPointsFile=$7 edu.indiana.soic.spidal.damds.ProgramLRT -c $8 -n $n -t $tpn 2>&1 | tee $6
#$BUILD/bin/mpirun --report-bindings --mca btl ^openib --mca btl_tcp_if_include eth2 -np $p --hostfile nodes.txt java $opts -cp ../target/$jar -DDistanceMatrixFile=$1 -DWeightMatrixFile=$2 -DPointsFile=$3.txt -DNumberDataPoints=$4 -DTimingFile=$5 -DSummaryFile=$6 -DInitialPointsFile=$7 edu.indiana.soic.spidal.damds.Program -c $8 -n $n -t $tpn 2>&1 -mmapdir=/scratch/skamburu/mpi | tee $6
echo "Finished $0 on `date`" >> status.txt