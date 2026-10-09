import java.sql.*;

String url = "jdbc:postgresql://localhost:5432/alfresco262";
String user = "alfresco";
String pass = "alfresco";

try (Connection conn = DriverManager.getConnection(url, user, pass)) {
    System.out.println("Connected OK");

    String uuid = "09931e98-1aa3-4790-931e-981aa3f790ff";

    try (PreparedStatement ps = conn.prepareStatement("SELECT id FROM alf_node WHERE uuid = ?")) {
        ps.setString(1, uuid);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                long nodeId = rs.getLong(1);
                System.out.println("documentLibrary node found in DB, internal id=" + nodeId);

                try (PreparedStatement ps2 = conn.prepareStatement(
                        "SELECT count(*) FROM alf_child_assoc WHERE parent_node_id = ?")) {
                    ps2.setLong(1, nodeId);
                    try (ResultSet rs2 = ps2.executeQuery()) {
                        rs2.next();
                        System.out.println("Direct children count in DB: " + rs2.getLong(1));
                    }
                }

                try (PreparedStatement ps3 = conn.prepareStatement(
                        "SELECT ca.child_node_name, n.uuid FROM alf_child_assoc ca JOIN alf_node n ON n.id = ca.child_node_id WHERE ca.parent_node_id = ?")) {
                    ps3.setLong(1, nodeId);
                    try (ResultSet rs3 = ps3.executeQuery()) {
                        while (rs3.next()) {
                            System.out.println("  child: " + rs3.getString(1) + " uuid=" + rs3.getString(2));
                        }
                    }
                }
            } else {
                System.out.println("documentLibrary node uuid " + uuid + " NOT FOUND in current DB!");
            }
        }
    }
} catch (Exception e) {
    e.printStackTrace();
}

/exit
