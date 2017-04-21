import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.*;

/**
 * Servlet implementation class ClientServlet
 */
@WebServlet("/ClientServlet")
public class ClientServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ClientServlet() 
    {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		String day = request.getParameter("day");
		String month = request.getParameter("month");
		String year = request.getParameter("year");
		String date = year + "-" + month + "-" + day;
		String userId = request.getParameter("userId");
		
		System.out.println(userId + " " + date);
		
		ServletContext context = getServletContext();
		String fullPath = context.getRealPath("/WEB-INF/config.txt");
		String key = "";
		FileReader file = new FileReader(fullPath);
		BufferedReader reader = new BufferedReader(file);
		String myfile = reader.readLine();
		while (myfile != null)
		{
			key += myfile;
			myfile = reader.readLine();
		}
		file.close();
		
		String host = "";
		String port = "";
		try
		{
			JSONObject address = new JSONObject(key);
			host = address.getString("host");
			port = address.getString("port");
		}
		catch(JSONException e)
		{
			e.printStackTrace();
		}
		
		URL url = new URL("http://" + host + ":" + port + "/StackOverflowRESTfulWebService/api/StackOverflow/getReputation/" + userId + "/" + date);
		URLConnection connection = url.openConnection();
		connection.setDoOutput(true);
		connection.setRequestProperty("Content-Type", "application/json");
		BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
		
		String line = null;
		StringBuilder output = new StringBuilder();
		while ((line = in.readLine()) != null) 
		{
			output.append(line);
		}
		in.close();
		System.out.println("Client = " + output);
		
		try 
		{
			JSONObject obj = new JSONObject(output.toString());
			request.setAttribute("ID", obj.getString("id"));
			request.setAttribute("NAME", obj.get("name"));
			request.setAttribute("REPUTATION", obj.getString("reputation"));
			request.setAttribute("TIME", obj.get("time"));
		} 
		catch (JSONException e) 
		{
			e.printStackTrace();
		}
		

		request.getRequestDispatcher("/result.jsp").forward(request, response);
	}

}