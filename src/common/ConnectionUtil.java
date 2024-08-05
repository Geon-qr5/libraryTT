package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConnectionUtil {
    /**
     * 데이터베이스 커넥션 생성 및 반환
     * !!!! DB에 접근하기 위해 라이브러리를 추가 해야 합니다.
     * 
     * 생성하지 않고 사용하기 위해서 static 키워드를 붙여 줍니다.
     */
    public static Connection getConnection() {
        Connection con = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            // Connection객체를 반환해주는 메서드 호출
            // 접속정보를 매개변수로 넣어줍니다.
            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl"
                                                , "user01", "1234");
        } catch (ClassNotFoundException e) {
            System.out.println("라이브러리를 확인해주세요.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("접속정보를 확인해주세요.");
            e.printStackTrace();
        }

        return con;
    }

    public static void main(String[] args) {
        // try 문장의 ()안에 생성할 경우, try 문이 끝날때 자동으로 자원을 반납처리
        try (
                Connection con = ConnectionUtil.getConnection();
                // 동적쿼리를 작성할때 유용
                PreparedStatement pstmt = con.prepareStatement("SELECT SYSDATE FROM DUAL");
                // 결과집합을 받아오기
                ResultSet rs = pstmt.executeQuery();) {
            // 다음줄로 넘어가기
            rs.next();
            System.out.println(rs.getString(1));
        } catch (SQLException e) {
            System.out.println("쿼리를 확인 해주세요.");
            e.printStackTrace();
        }
    }
}
