import java.sql.Timestamp;
import java.util.ArrayList;

import akka.actor.ActorRef;
import akka.actor.Props;
import akka.actor.UntypedActor;
import akka.routing.RoundRobinRouter;

public class Master extends UntypedActor
{
    private final ActorRef workerRouter;
    private final ActorRef listener;
    static Timestamp start;
    private int numberOfWorkers;
    private int numberOfResults = 0;
    
    private final int processors = 8;

    private Result finalResults = new Result();

    public Master( Timestamp start, final int numberOfWorkers, ActorRef listener )
    {
        // Save our parameters locally
    	this.start = start;
        this.numberOfWorkers = numberOfWorkers;
        this.listener = listener;

        // Create a new router to distribute messages out to the workers
        workerRouter = this.getContext()
                .actorOf( new Props(Worker.class )
                        .withRouter( new RoundRobinRouter( numberOfWorkers )), "workerRouter" );
    }

    @Override
    public void onReceive( Object message )
    {
        if( message instanceof NumberRangeMessage )
        {
            // We have a new set of work to perform
            NumberRangeMessage numberRangeMessage = ( NumberRangeMessage )message;

            // break the work up into numberOfWorkers chunks of numbers
            
            int numberOfNumbers = numberRangeMessage.getEndNumber() - numberRangeMessage.getStartNumber() + 1;
            
            if (numberOfWorkers > numberOfNumbers)
            {
            	if (numberOfNumbers > processors)
            		numberOfWorkers = processors;
            	else
            		numberOfWorkers = numberOfNumbers;
            }
            
            int segmentLength = numberOfNumbers / numberOfWorkers;

            for( int i=0; i<numberOfWorkers; i++ )
            {
                // Compute the start and end numbers for this worker
                int startNumber = numberRangeMessage.getStartNumber() + ( i * segmentLength );
                int endNumber = startNumber + segmentLength - 1;
                ArrayList<String >inputList = numberRangeMessage.getInputList();

                // Handle any remainder
                if( i == numberOfWorkers - 1 )
                {
                    // Make sure we get the rest of the list
                    endNumber = numberRangeMessage.getEndNumber();
                }

                // Send a new message to the work router for this subset of numbers
                workerRouter.tell( new NumberRangeMessage( inputList, startNumber, endNumber ), getSelf() );
            }
        }
        else if( message instanceof Result )
        {
            // We received results from our worker: add its results to our final results
            Result result = ( Result )message;
            finalResults.getResults().addAll( result.getResults() );

            if( ++numberOfResults >= numberOfWorkers )
            {
                // Notify our listener
                listener.tell( finalResults, getSelf() );

                // Stop our actor hierarchy
                getContext().stop( getSelf() );
            }

        }
        else
        {
            unhandled( message );
        }
    }
}