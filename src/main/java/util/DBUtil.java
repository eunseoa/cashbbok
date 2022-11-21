package util;

import java.sql.*;

public class DBUtil {
	public Connection getConnection() throws Exception {
		String driver = "org.mariadb.jdbc.Driver";
		String dbUrl = "jdbc:mariadb://127.0.0.1:3306/cashbook";
		String dbUser = "root";
		String dbPw = "dmstj1004";
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
		return conn;
	}
}
