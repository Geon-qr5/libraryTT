package dto;

import lombok.Data;

@Data
public class BookDTO {

    private String b_no;
    private String title;
    private String author;
    private int price;
    private String p_no;
    private String rentyn;
    private String delyn;
    private String regdate;
    private String r_no;

    // public BookDTO(String b_no, String title, String author, int price) {
    public BookDTO(String title, String author, int price) {
        this.title = title;
        this.author = author;
        this.price = price;
    }
}
