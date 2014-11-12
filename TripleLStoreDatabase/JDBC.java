
import java.sql.*;

public class JDBC {
   static final String JDBCDriver = "com.mysql.jdbc.Driver";
   static final String DBURL = "jdbc:mysql://localhost/cs157aproject";
    
   static final String USER = "root";
   static final String PW = "";
   private static Connection conn = null;
   private static Statement stmt = null;
   
   public static void main(String [] args) throws SQLException
   {
       try
       {
    	   // Register JDBC driver
           Class.forName("com.mysql.jdbc.Driver");
           
           // Open a connection
           System.out.println("Connecting to database...");
           conn = DriverManager.getConnection(DBURL, USER, PW);
           
           // Create the callable statement
           CallableStatement cs = conn.prepareCall("{CALL CheckStock(?)}");
           // Set the first int parameter
           cs.setInt(1, 2);
           ResultSet rs;
           boolean hasResult = cs.execute();
           
           if (hasResult)
           {
        	   // Get the result set
        	   rs=cs.getResultSet();
        	   // Move to first value of result set
        	   rs.first();
        	   // Print the first value
        	   System.out.println(rs.getInt(1));
           }
           
           
           
           makeDatabase();
       }
       catch(SQLException sqle)
       {
           sqle.printStackTrace();
       }
       catch(Exception ex)
       {
           ex.printStackTrace();
       }
       finally
       {
           try
           {
               if(stmt!=null) stmt.close();
           }
           catch(SQLException sqlex){}
       }
   }
    private static void makeDatabase() throws SQLException
    {
      String database = "DROP DATABASE IF EXISTS store";
      Statement statement = conn.createStatement();
      statement.execute(database);
      
      System.out.println("Creating database");
      stmt = conn.createStatement();
      stmt.execute("CREATE DATABASE store");
      System.out.println("Created database");
      
    }
    
    
   
}
