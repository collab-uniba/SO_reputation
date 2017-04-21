import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Scanner;

import akka.actor.*;

public class Main
{
    public void calculate( Timestamp start, ArrayList<String> inputList, int startNumber, int endNumber )
    {
        // Create our ActorSystem, which owns and configures the classes
        ActorSystem actorSystem = ActorSystem.create( "Calculator" );

        // Create our listener
        final ActorRef Listener = actorSystem.actorOf( new Props( Listener.class ), "Listener" );

        // Create the PrimeMaster: we need to define an UntypedActorFactory so that we can control
        // how PrimeMaster instances are created (pass in the number of workers and listener reference
        ActorRef primeMaster = actorSystem.actorOf( new Props( new UntypedActorFactory() {
            public UntypedActor create() {
                return new Master( start, 8, Listener );
            }
        }), "Master" );

        // Start the calculation
        primeMaster.tell( new NumberRangeMessage( inputList, startNumber, endNumber ) );
    }
    
    private static boolean isValideDate(String date)
    {
		DateFormat df = new SimpleDateFormat("yyyy-mm-dd");
		String after;
		try 
		{
			after = df.format(df.parse(date));
		} 
		catch (ParseException e) 
		{
			return false;
		}
		
		return after.equals(date);
    }
    
    private static void setInputList(ArrayList<String> inputList)
    {
    	String[] id_data = null;
    	String line;
    	Scanner scan = new Scanner(System.in);
		System.out.println("Enter UserId and a Date (yyyy-mm-dd) separated by a space!");
		System.out.println("Enter -1 as UserId to stop");
		do
		{
			try
			{
				line = scan.nextLine();
				id_data = line.split(" ");
				Integer.parseInt(id_data[0]);
				if (!id_data[0].equals("-1") && isValideDate(id_data[1]))
					inputList.add(line);
				
			}
			catch(NumberFormatException e)
			{
				
			}
		}while(!id_data[0].equals("-1"));
		scan.close();
    }

    public static void main( String[] args )
    {	
    	ArrayList<String> inputList = new ArrayList<String>();
    	
    	setInputList(inputList);
    	
    	Timestamp start = new Timestamp(System.currentTimeMillis());
    	
    	int startNumber = 0;
        int endNumber = inputList.size() - 1;

        Main calculator = new Main();
        
        if (inputList.size() > 0) 
        	calculator.calculate( start, inputList, startNumber, endNumber );
        
    }
}