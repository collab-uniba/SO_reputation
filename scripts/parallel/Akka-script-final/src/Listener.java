import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Timestamp;

import akka.actor.UntypedActor;


public class Listener extends UntypedActor
{
    @Override
    public void onReceive( Object message ) throws Exception
    {
        if( message instanceof Result )
        {
        	
        	Result result = ( Result )message;
        	BufferedWriter bw = null;
            
    		try
    		{
    			bw = new BufferedWriter(new FileWriter("Report.txt", true));
    			bw.write(Master.start.toString());
    			bw.write("\n");
    			for(String value : result.getResults())
    			{
    				if (!value.equals(""))
    					bw.write(value);
    			}
    			Timestamp end = new Timestamp(System.currentTimeMillis());
    			bw.write(end.toString() + "   " + Worker.getDifference(Master.start, end));
    			bw.write("\n\n");
    		}
    		catch(IOException e)
    		{
    			e.printStackTrace();
    		}
    		finally
    		{
    			if (bw != null)
    			{
    				try
    				{
    					bw.close();
    				}
    				catch(IOException e)
    				{
    					e.printStackTrace();
    				}
    			}
    		}

            // Exit
            getContext().system().shutdown();
        }
        else
        {
            unhandled( message );
        }
    }
}