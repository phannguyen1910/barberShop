package babershopDAO;

import babershopDatabase.databaseInfo;
import model.Advise;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AdviseDAO {
    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    // Lấy danh sách tư vấn theo từ khóa tìm kiếm (tìm theo cả question và answer)
    public List<Advise> searchAdvises(String keyword) throws Exception {
        List<Advise> advises = new ArrayList<>();
        String query = "SELECT * FROM Advise WHERE question LIKE ? OR answer LIKE ?";
        try {
            Class.forName(databaseInfo.DRIVERNAME);
            conn = java.sql.DriverManager.getConnection(databaseInfo.DBURL, databaseInfo.USERDB, databaseInfo.PASSDB);
            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                Advise advise = new Advise();
                advise.setId(rs.getInt("id"));
                advise.setQuestion(rs.getString("question"));
                advise.setAnswer(rs.getString("answer"));
                advise.setServiceId(rs.getInt("serviceId"));
                advise.setType(rs.getString("type"));
                advise.setTargetAge(rs.getString("targetAge"));
                advise.setFaceShape(rs.getString("faceShape"));
                advise.setMinPrice((Integer)rs.getObject("minPrice"));
                advise.setMaxPrice((Integer)rs.getObject("maxPrice"));
                advise.setDuration((Integer)rs.getObject("duration"));
                advise.setColorFadeTime((Integer)rs.getObject("colorFadeTime"));
                advise.setImage(rs.getString("image"));
                advises.add(advise);
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return advises;
    }

    // Lấy tất cả dữ liệu tư vấn
    public List<Advise> getAllAdvises() throws Exception {
        List<Advise> advises = new ArrayList<>();
        String query = "SELECT * FROM Advise";
        try {
            Class.forName(databaseInfo.DRIVERNAME);
            conn = java.sql.DriverManager.getConnection(databaseInfo.DBURL, databaseInfo.USERDB, databaseInfo.PASSDB);
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Advise advise = new Advise();
                advise.setId(rs.getInt("id"));
                advise.setQuestion(rs.getString("question"));
                advise.setAnswer(rs.getString("answer"));
                advise.setServiceId(rs.getInt("serviceId"));
                advise.setType(rs.getString("type"));
                advise.setTargetAge(rs.getString("targetAge"));
                advise.setFaceShape(rs.getString("faceShape"));
                advise.setMinPrice((Integer)rs.getObject("minPrice"));
                advise.setMaxPrice((Integer)rs.getObject("maxPrice"));
                advise.setDuration((Integer)rs.getObject("duration"));
                advise.setColorFadeTime((Integer)rs.getObject("colorFadeTime"));
                advise.setImage(rs.getString("image"));
                advises.add(advise);
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return advises;
    }

    // Lấy danh sách tư vấn theo service_id
    public List<Advise> getAdvisesByServiceId(int serviceId) throws Exception {
        List<Advise> advises = new ArrayList<>();
        String query = "SELECT * FROM Advise WHERE service_id = ?";
        try {
            Class.forName(databaseInfo.DRIVERNAME);
            conn = java.sql.DriverManager.getConnection(databaseInfo.DBURL, databaseInfo.USERDB, databaseInfo.PASSDB);
            ps = conn.prepareStatement(query);
            ps.setInt(1, serviceId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Advise advise = new Advise();
                advise.setId(rs.getInt("id"));
                advise.setQuestion(rs.getString("question"));
                advise.setAnswer(rs.getString("answer"));
                advise.setServiceId(rs.getInt("serviceId"));
                advise.setType(rs.getString("type"));
                advise.setTargetAge(rs.getString("targetAge"));
                advise.setFaceShape(rs.getString("faceShape"));
                advise.setMinPrice((Integer)rs.getObject("minPrice"));
                advise.setMaxPrice((Integer)rs.getObject("maxPrice"));
                advise.setDuration((Integer)rs.getObject("duration"));
                advise.setColorFadeTime((Integer)rs.getObject("colorFadeTime"));
                advise.setImage(rs.getString("image"));
                advises.add(advise);
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return advises;
    }

    // Lấy tư vấn theo id
    public Advise getAdviseById(int id) throws Exception {
        Advise advise = null;
        String query = "SELECT * FROM Advise WHERE id = ?";
        try {
            Class.forName(databaseInfo.DRIVERNAME);
            conn = java.sql.DriverManager.getConnection(databaseInfo.DBURL, databaseInfo.USERDB, databaseInfo.PASSDB);
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                advise = new Advise();
                advise.setId(rs.getInt("id"));
                advise.setQuestion(rs.getString("question"));
                advise.setAnswer(rs.getString("answer"));
                advise.setServiceId(rs.getInt("serviceId"));
                advise.setType(rs.getString("type"));
                advise.setTargetAge(rs.getString("targetAge"));
                advise.setFaceShape(rs.getString("faceShape"));
                advise.setMinPrice((Integer)rs.getObject("minPrice"));
                advise.setMaxPrice((Integer)rs.getObject("maxPrice"));
                advise.setDuration((Integer)rs.getObject("duration"));
                advise.setColorFadeTime((Integer)rs.getObject("colorFadeTime"));
                advise.setImage(rs.getString("image"));
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return advise;
    }
}