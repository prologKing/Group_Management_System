
package com.gpms.dbconnection;


import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBConnection
{

    public static Connection getConnection() throws SQLException, NamingException {
        Connection con = null;
        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            DataSource datasource = (DataSource) envContext.lookup("jdbc/gpmsdb");
            con = datasource.getConnection();
        } catch (NamingException e) {
            System.out.println(e);
        }
        return con;
    }
}