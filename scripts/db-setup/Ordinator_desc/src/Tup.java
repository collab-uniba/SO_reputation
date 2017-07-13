import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.Collections;

import com.opencsv.CSVReader;

public class Tup implements Comparable<Tup>
{

	private int id;
	private String line;
	
	Tup(int id, String line)
	{
		this.id = id;
		this.line = line;
	}
	
	@Override
	public int compareTo(Tup t) 
	{
		if (this.id < t.id)
			return 1;
		if (this.id == t.id)
			return 0;
		return -1;
	}
	
	private static void load(String filename, int col, int maxId, ArrayList<Tup> list)
	{
		//int maxId = 4038903; //id massimo stackoverflow_march;
		int halfId = maxId/3; //1/3 utenti
		
		/*int maxId = 12058;
		int halfId = 6029;*/
		
		CSVReader br = null;
		BufferedReader br_line = null;
		String line = "";
		String[] values = null;
		try
		{
			br = new CSVReader(new FileReader(filename));
			br_line = new BufferedReader(new FileReader(filename));
			while (( values = br.readNext()) != null)
			{
				line = br_line.readLine();
				if (!values[col].equals("N"))
				{
					if (Integer.parseInt(values[col]) > halfId)
						list.add(new Tup(Integer.parseInt(values[col]), line));
				}
			} 
			br.close();
			br_line.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	private static void save(ArrayList<Tup> t)
	{
		BufferedWriter bw = null;
		try
		{
			bw = new BufferedWriter(new FileWriter("new_file.csv"));
			for(int i = 0; i < t.size(); i++)
				bw.write(t.get(i).line + "\n");
			bw.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}
		
	
	public static void main(String[] args)
	{
		ArrayList<Tup> t = new ArrayList<Tup>();
		load(args[0], Integer.parseInt(args[1]), Integer.parseInt(args[2]), t);
		Collections.sort(t);
		save(t);
	}

}
