package common;

import java.util.Scanner;

public class ScannerUtil {
    private static Scanner scan = new Scanner(System.in);

    private ScannerUtil() {

    }

    public static int getInt(String msg) {
        int num = 0;
        while (true) {
            try {
                System.out.print(msg + " : ");
                num = scan.nextInt();
                scan.nextLine();
                return num;
            } catch (Exception e) {
                System.out.println("숫자만 입력 가능합니다.");
                scan.nextLine();
            }            
        }
    }

    public static String getString(String str) {
        System.out.print(str + " : ");
        return scan.nextLine();
    }
}
