#!/bin/bash
#PBS -l nodes=2
home_dir="/home/derek"
test_hosts="$home_dir/benchmarks/mpi/hosts/pleiades_all_hosts"
test_dir="$home_dir/workspace/void/external/omb-openmpi/libexec/lnx/osu-micro-benchmarks"
test_pre="/opt/openmpi/1.6/bin/mpiexec -np 2 --mca pml cm --mca mtl mxm --mca mtl_mxm_verbose 1 --mca base_verbose 1 -hostfile /home/derek/benchmarks/mpi/hosts/pleiades_all_hosts $test_dir"
# test_pre="/opt/openmpi/1.6/bin/mpiexec -np 2 --mca pml ob1 --mca btl openib,self --mca base_verbose 1 -hostfile /home/derek/benchmarks/mpi/hosts/pleiades_all_hosts $test_dir"
test_cmd=""

# -----------------------------------------------------------------------------

function run_test()
{
	local test_name="$1"
	local test_cmd="$2"

	echo "------------------------------------------------------------------------"
	echo $test_name
	echo "------------------------------------------------------------------------"
	echo $test_cmd
	eval $test_cmd
}

# -----------------------------------------------------------------------------

echo "------------------------------------------------------------------------"
echo "Modules loaded:"
echo "------------------------------------------------------------------------"

module load openmpi/1.6
module list

echo "------------------------------------------------------------------------"
echo "Test Configuration:"
echo "------------------------------------------------------------------------"

echo "Home Dir: '$home_dir'"
echo "Test Dir: '$test_dir'"
echo "Test Pre: '$test_pre'"
echo "Test Hosts: "
cat "$test_hosts"

# -----------------------------------------------------------------------------
# MPI-1
# -----------------------------------------------------------------------------

echo "------------------------------------------------------------------------"
echo "MPI-1 OSU MicroBenchmarks"
echo "------------------------------------------------------------------------"

test_cmd=osu_bcast
test_name="Broadcast Latency Test"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_bibw
test_name="Bidirectional Bandwidth Test"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_bw
test_name="Bandwidth Test"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_latency
test_name="Latency Test"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_mbw_mr 
test_name="Multiple Bandwidth / Message Rate Test"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_multi_lat 
test_name="Multi-pair Latency Test"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_allgather
test_name="MPI_Allgather Latency Test"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_allgatherv
test_name="MPI_Allgatherv Latency Test"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_allreduce 
test_name="MPI_Allreduce Latency Test"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_alltoall  
test_name="MPI_Alltoall Latency Test"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_alltoallv 
test_name="MPI_Alltoallv Latency Test"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_barrier  
test_name="MPI_Barrier Latency Test"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_bcast   
test_name="MPI_Bcast Latency Test"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_gather  
test_name="MPI_Gather Latency Test"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_gatherv 
test_name="MPI_Gatherv Latency Test"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_reduce  
test_name="MPI_Reduce Latency Test"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_reduce_scatter 
test_name="MPI_Reduce_scatter Latency Test"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_scatter
test_name="MPI_Scatter Latency Test"  
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_scatterv
test_name="MPI_Scatterv Latency Test"
run_test "$test_name" "$test_pre/$test_cmd"

# -----------------------------------------------------------------------------
# MPI-2
# -----------------------------------------------------------------------------

echo " "
echo "------------------------------------------------------------------------"
echo "MPI-2 OSU MicroBenchmarks"
echo "------------------------------------------------------------------------"
echo " "

test_cmd=osu_acc_latency
test_name="Latency Test for Accumulate with Active Synchronization"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_get_bw
test_name="Bandwidth Test for Get with Active Synchronization"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_get_latency
test_name="Latency Test for Get with Active Synchronization"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_latency_mt          
test_name="Multi-threaded Latency Test"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_passive_acc_latency
test_name="Latency Test for Accumulate with Passive Synchronization"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_passive_get_bw
test_name="Bandwidth Test for Get with Passive Synchronization"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_passive_get_latency
test_name="Latency Test for Get with Passive Synchronization"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_passive_put_bw
test_name="Bandwidth Test for Put with Passive Synchronization"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_passive_put_latency
test_name="Latency Test for Put with Passive Synchronization"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_put_bibw
test_name="Bi-directional Bandwidth Test for Put with Active Synchronization"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_put_bw
test_name="Bandwidth Test for Put with Active Synchronization"
run_test "$test_name" "$test_pre/$test_cmd"

test_cmd=osu_put_latency
test_name="Latency Test for Put with Active Synchronization"
run_test "$test_name" "$test_pre/$test_cmd"

# -----------------------------------------------------------------------------

