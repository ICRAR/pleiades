
#include <mpi.h>
#include <string.h>
#include <stdio.h>
 
int main(int argc, char* argv[])
{
        int my_rank;                    // rank of process
        int p;                                  // number of processes
        int source;                     // rank of sender
        int dest;                               // rank of receiver
        int tag;                                // tag for messages
        char message[100];      // storage for messages
	char host[256];
        MPI_Status status;              // return status for receive
 
        // Start up MPI
        MPI_Init(&argc, &argv);
 
        // Find out process rank
        MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
 
        // Find out number of processes
        MPI_Comm_size(MPI_COMM_WORLD, &p);
 	gethostname(host);

        if(my_rank != 0) {                                                                          // for slave processes
		printf("I am slave %d on %s!\n", my_rank, host);
                sprintf(message, "Greetings from process %d!", my_rank);
                dest = 0;
 
                // lets send message
                MPI_Send(message, strlen(message)+1, MPI_CHAR, dest, tag, MPI_COMM_WORLD);
        } else {                                                                                         // for master process
                printf("I am the Master! My rank is %d.\n ", my_rank);
                for(source = 1; source < p; source++) {
                // lets receive message from source
                        MPI_Recv(message, 100, MPI_CHAR, source, tag, MPI_COMM_WORLD, &status);
                        printf("%s\n", message);
                }
        }
 
        // Shut down MPI
        MPI_Finalize();
}
