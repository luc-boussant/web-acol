package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;

/**
 *
 * @author delevoyj
 */
public class AccompagnateurDAO extends AbstractDataBaseDAO {

    public AccompagnateurDAO(DataSource ds) {
        super(ds);
    }

    /**
     * Permet de récupérer la liste des email des accompagnateurs
     *
     * @return Liste de string contenant les emails des accompagnateurs
     */
    public List<String> getListEmail() throws DAOException {
        List<String> result = new ArrayList<>();
        try (
                Connection conn = getConn();
                Statement st = conn.createStatement();) {
            ResultSet rs = st.executeQuery("SELECT mail FROM accompagnateur");
            while (rs.next()) {
                result.add(rs.getString("mail"));
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur BD " + e.getMessage(), e);
        }
        return result;
    }
}
