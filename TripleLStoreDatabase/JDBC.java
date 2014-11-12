
import java.sql.*;

public class JDBCConnection {
   static final String JDBCDriver = "com.mysql.jdbc.Driver";
   static final String DBURL = "jdbc:mysql://localhost/";
    
   static final String USER = "root";
   static final String PW = "tripleLDB123";
   private static Connection conn = null;
   private static Statement stmt = null;
   
   public static void main(String [] args) throws SQLException
   {
       try
       {
           Class.forName("com.mysql.jdbc.Driver");
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
      conn = DriverManager.getConnection(DBURL, USER, PW);
      String database = "DROP DATABASE IF EXISTS store";
      Statement statement = conn.createStatement();
      statement.execute(database);
      
      System.out.println("Creating database");
      stmt = conn.createStatement();
      stmt.execute("CREATE DATABASE store");
      System.out.println("Created database");
      
    }
    
   
}
