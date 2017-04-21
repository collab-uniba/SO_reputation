import java.io.FileReader;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.TreeMap;

import com.opencsv.CSVReader;
import akka.actor.UntypedActor;

public class Worker extends UntypedActor
{
    /**
     * Invoked by the mailbox when it receives a thread timeslice and a message is available
     *
     * @param message   The message to process
     */
    public void onReceive( Object message )
    {
        // We only handle NumberRangeMessages
        if( message instanceof NumberRangeMessage )
        {
            // Cast the message to a NumberRangeMessage
            NumberRangeMessage numberRangeMessage = ( NumberRangeMessage )message;
            ArrayList<String> inputList = numberRangeMessage.getInputList();
            System.out.println( "Number Range: " + numberRangeMessage.getStartNumber() + " to " + numberRangeMessage.getEndNumber() );

            // Iterate over the range, compute primes, and return the list of numbers that are prime
            Result result = new Result();
            for( int i = numberRangeMessage.getStartNumber(); i <= numberRangeMessage.getEndNumber(); i++ )
            	result.getResults().add( getReputation(inputList.get(i)) );
            
           

            // Send a notification back to the sender
            getSender().tell( result, getSelf() );
        }
        else
        {
            // Mark this message as unhandled
            unhandled( message );
        }
    }


    
	private String getInfoUser(String userid)
	{
		String filename = "Users.csv";
		String result = "";
		String values[];
		CSVReader br = null;
		try
		{
			br = new CSVReader(new FileReader(filename));
			while((values = br.readNext()) != null)
			{
				if (values[0].equals(userid))
				{
					result = values[3] + "<###>" + values[2] + "<###>" + values[11] + "<###>" + values[1];
				}
				else if (Integer.parseInt(values[0]) > Integer.parseInt(userid))
					return result;
			}
		}
		catch(IOException e)
		{
			e.printStackTrace();
		}
		finally
		{
			try
			{
				br.close();
			}
			catch(IOException e)
			{
				e.printStackTrace();
			}
		}
		return result;
	}
	
	static String getDifference(Timestamp begin, Timestamp end)
	{
		long diff = end.getTime() - begin.getTime();
		
		long diffSeconds = diff / 1000 % 60;
		long diffMinutes = diff / (60 * 1000) % 60;
		long diffHours = diff / (60 * 60 * 1000) % 24;
		long diffDays = diff / (24 * 60 * 60 * 1000);
		
		return diffDays + " days, " + diffHours + " hours, " + diffMinutes + " minutes, " + diffSeconds + " seconds\n";
	}
	
	private String getReputation(String input)
	{
		Timestamp begin = new Timestamp(System.currentTimeMillis());
		
		String[] id_data = input.split(" ");
		String userid = id_data[0];
		String finalDate = id_data[1];
		String infoUser = getInfoUser(userid);
		
		if (!infoUser.equals("")) // se l'id dell'utente esiste
		{
			String[] results = getInfoUser(userid).split("<###>");
			String username = results[0];
			String downVotes = results[2];
			int estimated_reputation = 1;
			int real_reputation = Integer.parseInt(results[3]);
			String[] values = null;
			TreeMap<String, Reputation> rep = new TreeMap<String, Reputation>();
			CSVReader br = null;
			String[] current_data = null;
			if (Integer.parseInt(userid) <= 1346301)
			{
				try
				{
					br = new CSVReader(new FileReader("Question_Answer_2_asc.csv"));
					while ( (values = br.readNext()) != null )
					{
						current_data = values[5].split(" ");
						if (current_data[0].compareTo(finalDate) <= 0)
						{
							if (Integer.parseInt(values[2]) == Integer.parseInt(userid) && !values[4].equals(userid))
							{
								if (!rep.containsKey(current_data[0]))
									rep.put(current_data[0], new Reputation());
								rep.get(current_data[0]).acceptedAnswers = rep.get(current_data[0]).acceptedAnswers + 2; //(+2 to acceptor)
							}
							else if (Integer.parseInt(values[2]) > Integer.parseInt(userid))
								break;
						}
					}
					br.close();
					
					br = new CSVReader(new FileReader("Question_Answer_4_asc.csv"));
					while ( (values = br.readNext()) != null )
					{
						current_data = values[5].split(" ");
						if (current_data[0].compareTo(finalDate) <= 0)
						{
							if (Integer.parseInt(values[4]) == Integer.parseInt(userid) && !values[2].equals(userid))
							{
								if (!rep.containsKey(current_data[0]))
									rep.put(current_data[0], new Reputation());
								rep.get(current_data[0]).acceptedAnswers = rep.get(current_data[0]).acceptedAnswers + 15; //answer is marked “accepted”: +15
							}
							else if (Integer.parseInt(values[4]) > Integer.parseInt(userid))
								break;
						}
					}
					br.close();

					br = new CSVReader(new FileReader("Posts_Votes1_asc.csv"));
					while ( (values = br.readNext()) != null )
					{
						current_data = values[1].split(" ");
						if (current_data[0].compareTo(finalDate) <= 0)
						{
							if (Integer.parseInt(values[0]) == Integer.parseInt(userid))
							{
								if (!rep.containsKey(current_data[0]))
									rep.put(current_data[0], new Reputation());
								rep.get(current_data[0]).daily_points = rep.get(current_data[0]).daily_points + 5; //question is voted up: +5
							}
							else if (Integer.parseInt(values[0]) > Integer.parseInt(userid))
								break;
						}
					}
					br.close();
				
				
					br = new CSVReader(new FileReader("Posts_Votes2_asc.csv"));
					while ( (values = br.readNext()) != null )
					{
						current_data = values[1].split(" ");
						if (current_data[0].compareTo(finalDate) <= 0)
						{	
							if (Integer.parseInt(values[0]) == Integer.parseInt(userid))
							{
								if (!rep.containsKey(current_data[0]))
									rep.put(current_data[0], new Reputation());
								rep.get(current_data[0]).daily_points = rep.get(current_data[0]).daily_points - 2; //your question is voted down: -2
							}
							else if (Integer.parseInt(values[0]) > Integer.parseInt(userid))
								break;
						}
					}
					br.close();
				
					br = new CSVReader(new FileReader("Posts_Votes3_asc.csv"));
					while ( (values = br.readNext()) != null )
					{
						current_data = values[1].split(" ");
						if (current_data[0].compareTo(finalDate) <= 0)
						{
							if (Integer.parseInt(values[0]) == Integer.parseInt(userid))
							{
								if (!rep.containsKey(current_data[0]))
									rep.put(current_data[0], new Reputation());
								rep.get(current_data[0]).daily_points = rep.get(current_data[0]).daily_points + 10; //answer is voted up: +10
							}
							else if (Integer.parseInt(values[0]) > Integer.parseInt(userid))
								break;
						}
					}
					br.close();
				
					br = new CSVReader(new FileReader("Posts_Votes4_asc.csv"));
					while ( (values = br.readNext()) != null )
					{
						current_data = values[1].split(" ");
						if (current_data[0].compareTo(finalDate) <= 0)
						{
							if (Integer.parseInt(values[0]) == Integer.parseInt(userid))
							{
								if (!rep.containsKey(current_data[0]))
									rep.put(current_data[0], new Reputation());
								rep.get(current_data[0]).daily_points = rep.get(current_data[0]).daily_points - 2; //your answer is voted down: -2
							}
							else if (Integer.parseInt(values[0]) > Integer.parseInt(userid))
									break;
						}
					} 
					br.close();
				
				}
				catch(IOException e)
				{
					e.printStackTrace();
				}
			}
			
			else
			{
				try
				{
					br = new CSVReader(new FileReader("Question_Answer_2_desc.csv"));
					while ( (values = br.readNext()) != null )
					{
						current_data = values[5].split(" ");
						if (current_data[0].compareTo(finalDate) <= 0)
						{
							if (Integer.parseInt(values[2]) == Integer.parseInt(userid) && !values[4].equals(userid))
							{
								if (!rep.containsKey(current_data[0]))
									rep.put(current_data[0], new Reputation());
								rep.get(current_data[0]).acceptedAnswers = rep.get(current_data[0]).acceptedAnswers + 2; //(+2 to acceptor)
							}
							else if (Integer.parseInt(values[2]) < Integer.parseInt(userid))
									break;
						}
					}
					br.close();
					
					br = new CSVReader(new FileReader("Question_Answer_4_desc.csv"));
					while ( (values = br.readNext()) != null )
					{
						current_data = values[5].split(" ");
						if (current_data[0].compareTo(finalDate) <= 0)
						{
							if (Integer.parseInt(values[4]) == Integer.parseInt(userid) && !values[2].equals(values[4]))
							{
								if (!rep.containsKey(current_data[0]))
									rep.put(current_data[0], new Reputation());
								rep.get(current_data[0]).acceptedAnswers = rep.get(current_data[0]).acceptedAnswers + 15; //answer is marked “accepted”: +15
							}
							else if (Integer.parseInt(values[4]) < Integer.parseInt(userid))
								break;
						}
					}
					br.close();
				
					br = new CSVReader(new FileReader("Posts_Votes1_desc.csv"));
					while ( (values = br.readNext()) != null )
					{
						current_data = values[1].split(" ");
						if (current_data[0].compareTo(finalDate) <= 0)
						{
							if (Integer.parseInt(values[0]) == Integer.parseInt(userid))
							{
								if (!rep.containsKey(current_data[0]))
									rep.put(current_data[0], new Reputation());
								rep.get(current_data[0]).daily_points = rep.get(current_data[0]).daily_points + 5; //question is voted up: +5
							}
							else if (Integer.parseInt(values[0]) < Integer.parseInt(userid))
									break;
							}
					} 
					br.close();
				
				
					br = new CSVReader(new FileReader("Posts_Votes2_desc.csv"));
					while ( (values = br.readNext()) != null )
					{
						current_data = values[1].split(" ");
						if (current_data[0].compareTo(finalDate) <= 0)
						{	
							if (Integer.parseInt(values[0]) == Integer.parseInt(userid))
							{
								if (!rep.containsKey(current_data[0]))
									rep.put(current_data[0], new Reputation());
								rep.get(current_data[0]).daily_points = rep.get(current_data[0]).daily_points - 2; //your question is voted down: -2
							}
							else if (Integer.parseInt(values[0]) < Integer.parseInt(userid))
								break;
						}
					} 
					br.close();
				
					br = new CSVReader(new FileReader("Posts_Votes3_desc.csv"));
					while ( (values = br.readNext()) != null )
					{
						current_data = values[1].split(" ");
						if (current_data[0].compareTo(finalDate) <= 0)
						{
							if (Integer.parseInt(values[0]) == Integer.parseInt(userid))
							{
								if (!rep.containsKey(current_data[0]))
									rep.put(current_data[0], new Reputation());
								rep.get(current_data[0]).daily_points = rep.get(current_data[0]).daily_points + 10; //answer is voted up: +10
							}
							else if (Integer.parseInt(values[0]) < Integer.parseInt(userid))
								break;
						}
					} 
					br.close();
				
					br = new CSVReader(new FileReader("Posts_Votes4_desc.csv"));
					while ( (values = br.readNext()) != null )
					{
						current_data = values[1].split(" ");
						if (current_data[0].compareTo(finalDate) <= 0)
						{
							if (Integer.parseInt(values[0]) == Integer.parseInt(userid))
							{
								if (!rep.containsKey(current_data[0]))
									rep.put(current_data[0], new Reputation());
								rep.get(current_data[0]).daily_points = rep.get(current_data[0]).daily_points - 2; //your answer is voted down: -2
							}
							else if (Integer.parseInt(values[0]) < Integer.parseInt(userid))
									break;
						}
					} 
					br.close();
				
				}
				catch(IOException e)
				{
					e.printStackTrace();
				}
			}
				
			boolean flag = true;
			for (String key : rep.keySet())
			{
				Reputation r = rep.get(key);
				if (r.daily_points > 200)
					r.daily_points = 200;
				r.daily_points = r.daily_points + r.acceptedAnswers;
				estimated_reputation = estimated_reputation + r.daily_points;
				if (estimated_reputation < 1)
					estimated_reputation = 1;
				if (estimated_reputation >= 200 && flag)
				{
					estimated_reputation = estimated_reputation + 100;
					flag = false;
				}
			}
			
			estimated_reputation = estimated_reputation - Integer.parseInt(downVotes);
				
			if (estimated_reputation < 1)
				estimated_reputation = 1;
		
			Timestamp end = new Timestamp(System.currentTimeMillis());
		
			double error = estimated_reputation - real_reputation;
			error = error / real_reputation;
			error = error * 100;
			
			System.out.println("User id " + userid + " reputation calculated!" );
			
			return userid + "   " + username + "   " + estimated_reputation + "   " + real_reputation + "   " + Math.round(error * 100.00) / 100.00 + "%" + "   " + begin + "   " + end + "   " + getDifference(begin, end);
		}
		
		System.out.println("User id " + userid + " does not exist!" );
		
		return "";
	}
}

	


	
