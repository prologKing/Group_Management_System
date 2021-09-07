/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.gpms.dbconnection;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import org.jooq.Configuration;
import org.jooq.SQLDialect;
import org.jooq.impl.DefaultConfiguration;

public class DbUtils
{
  private InitialContext initialContext;
  private static Context context;
  private static DataSource ds;
  private static final DbUtils INSTANCE = new DbUtils();
  
  public static DbUtils getInstance()
  {
    return INSTANCE;
  }
  
  private DbUtils()
  {
    try
    {
      context = new InitialContext();
      ds = (DataSource)context.lookup("java:comp/env/jdbc/gpmsdb");
    }
    catch (NamingException ex)
    {
      Logger.getLogger(DbUtils.class.getName()).log(Level.SEVERE, null, ex);
    }
  }
  
  public Connection getConnection()
  {
    Connection con = null;
    try
    {
      con = ds.getConnection();
    }
    catch (SQLException ex)
    {
      Logger.getLogger(DbUtils.class.getName()).log(Level.SEVERE, null, ex);
    }
    return con;
  }
  
  public Configuration getConfig()
  {
    Configuration configuration = new DefaultConfiguration().set(getConnection()).set(SQLDialect.MYSQL);
    return configuration;
  }
  
  public String getNextId(String fieldname, String tablename, String company_code)
    throws Exception
  {
    ResultSet rs = null;
    Connection con = null;
    
    int i = 0;
    String result = null;
    try
    {
      con = getConnection();
      int len = company_code.length() + 1;
      String SQL = "SELECT MAX(cast(SUBSTRING(? , ? ,100) as unsigned))as int_code FROM ? WHERE company_code = ? ";
      PreparedStatement prepstat = con.prepareStatement(SQL);
      prepstat.setString(1, fieldname);
      prepstat.setInt(2, len);
      prepstat.setString(3, tablename);
      prepstat.setString(4, company_code);
      rs = prepstat.executeQuery();
      while (rs.next()) {
        i = rs.getInt("int_code");
      }
      i++;
      if (i < 10) {
        result = company_code + "0" + Integer.toString(i);
      } else {
        result = company_code + "" + Integer.toString(i);
      }
    }
    catch (Exception ex)
    {
      throw new Exception("Error generating Id: " + ex.getMessage());
    }
    finally
    {
      closeConnections(rs, con);
    }
    PreparedStatement prepstat;
    String SQL;
    return result;
  }
  
  public static void closeConnections(ResultSet result, Connection con)
  {
    if (result != null)
    {
      try
      {
        result.close();
      }
      catch (SQLException ex)
      {
        Logger.getLogger(DbUtils.class.getName()).log(Level.SEVERE, null, ex);
      }
      Logger.getLogger(DbUtils.class.getName()).log(Level.INFO, "ResultSet Closed!");
    }
    if (con != null)
    {
      try
      {
        con.close();
      }
      catch (SQLException ex)
      {
        Logger.getLogger(DbUtils.class.getName()).log(Level.SEVERE, null, ex);
      }
      Logger.getLogger(DbUtils.class.getName()).log(Level.INFO, "Connection Closed!");
    }
  }
  
  public static void closeConnections(Connection con)
  {
    if (con != null) {
      try
      {
        con.close();
      }
      catch (SQLException ex)
      {
        Logger.getLogger(DbUtils.class.getName()).log(Level.SEVERE, null, ex);
      }
    }
    Logger.getLogger(DbUtils.class.getName()).log(Level.INFO, "Connection Closed!");
  }
  
  public static void closeResultSet(ResultSet result)
  {
    if (result != null)
    {
      try
      {
        result.close();
      }
      catch (SQLException ex)
      {
        Logger.getLogger(DbUtils.class.getName()).log(Level.SEVERE, null, ex);
      }
      Logger.getLogger(DbUtils.class.getName()).log(Level.INFO, "ResultSet Closed!");
    }
  }
}
