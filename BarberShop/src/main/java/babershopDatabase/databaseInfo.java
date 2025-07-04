package babershopDatabase;


public interface databaseInfo {

    public static String DRIVERNAME = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
<<<<<<< Updated upstream
    public static String DBURL = "jdbc:sqlserver://MICUN:1433;databaseName=baberShop;encrypt=false;trustServerCertificate=false;loginTimeout=30;";
=======
    public static String DBURL = "jdbc:sqlserver://MICUN\\SQLEXPRESS;databaseName=baberShop;encrypt=false;trustServerCertificate=false;loginTimeout=30;";
>>>>>>> Stashed changes
    public static String USERDB = "sa";
    public static String PASSDB = "123";
}
