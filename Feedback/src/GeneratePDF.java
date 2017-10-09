
 
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
 import java.sql.*;

import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
 
public class GeneratePDF {
	
	private static Font TIME_ROMAN = new Font(Font.FontFamily.TIMES_ROMAN, 18,Font.BOLD);
	private static Font TIME_ROMAN_SMALL = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD);
 
	/**
	 * @param args
	 */
	public static Document createPDF(String file,String dept) {
 
		Document document = null;
 
		try {
			document = new Document();
			PdfWriter.getInstance(document, new FileOutputStream(file));
			document.open();
 
			addMetaData(document);
 
			addTitlePage(document,"Some Enginnering College");
 
			createTable(document,dept);
 
			document.close();
 
		} catch (FileNotFoundException e) {
 
			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		return document;
 
	}
 
	private static void addMetaData(Document document) {
		document.addTitle("PDF Report");
		document.addSubject("PDF Report");
		document.addAuthor("MREC");
		document.addCreator("MREC");
	}
 
	private static void addTitlePage(Document document,String string)
			throws DocumentException {
		
		
		
		Paragraph preface = new Paragraph();
		creteEmptyLine(preface, 1);
		
		preface.add(new Paragraph(string.toUpperCase(), new Font(Font.FontFamily.TIMES_ROMAN, 19)));
		
		creteEmptyLine(preface, 1);
	
		//preface.add(new Paragraph("Section: "+section, TIME_ROMAN_SMALL));
		document.add(preface);
 
	}
	private static void addDepartment(Document document,String string) throws DocumentException
	{
		if(string.equalsIgnoreCase("cse")){
			string="computer science and enginnering";
		}
		if(string.equalsIgnoreCase("me")){
			string="mechanical enginnering";
		}
		if(string.equalsIgnoreCase("eee")){
			string="electrical and electronic enginnering";
		}
		if(string.equalsIgnoreCase("ece")){
			string="electrical and comunication enginnering";
		}
		if(string.equalsIgnoreCase("civil")){
			string="civil enginnering";
		}
		if(string.equalsIgnoreCase("mine")){
			string="mining enginnering";
		}
		Paragraph preface = new Paragraph();
		creteEmptyLine(preface, 1);
		 Chunk sigUnderline = new Chunk("                                            ");
		    sigUnderline.setUnderline(0.5f, -2f);
		    
		preface.add(new Paragraph(string.toUpperCase(), new Font(Font.FontFamily.TIMES_ROMAN, 25, Font.BOLD)));
		preface.add(sigUnderline);
		preface.add(sigUnderline);
		preface.add(sigUnderline);
		
		creteEmptyLine(preface, 1);
	
		//preface.add(new Paragraph("Section: "+section, TIME_ROMAN_SMALL));
		document.add(preface);
	}
	private static void addSection(Document document,String string) throws DocumentException
	{
		Paragraph preface = new Paragraph();
		creteEmptyLine(preface, 1);
		
		preface.add(new Paragraph(string.toUpperCase(), new Font(Font.FontFamily.TIMES_ROMAN, 15)));
		
		creteEmptyLine(preface, 1);
	
		//preface.add(new Paragraph("Section: "+section, TIME_ROMAN_SMALL));
		document.add(preface);
	}
 
	private static void creteEmptyLine(Paragraph paragraph, int number) {
		for (int i = 0; i < number; i++) {
			paragraph.add(new Paragraph(" "));
		}
	}
	private static void addPage(Document document)
	{
		document.newPage();
	}
 
	private static void createTable(Document document,String department) throws DocumentException {
		int m=0;
		String dept[]=new String[7];
		String section[]={"a","b","c","d"};
		String semester[]={"1","2","3","4","5","6","7","8"};
		if(department.equalsIgnoreCase("all"))
		{
			
			dept[m++]="CSE";
			dept[m++]="ME";
			dept[m++]="MINE";
			dept[m++]="EEE";
			dept[m++]="ECE";
			dept[m++]="CIVIL";
			
			
		}
		else
		{
			dept[m++]=department;
		}
		Paragraph paragraph = new Paragraph();
		creteEmptyLine(paragraph, 2);
		document.add(paragraph);
		
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
		
			Statement st1=con.createStatement();
			ResultSet rs;
			for(int j=0;j<m;j++)
			{
				addDepartment(document, dept[j]);
				for(int k=0;k<semester.length;k++)//semester
				{
					addTitlePage(document, "Semester:"+semester[k]);
					for(int z=0;z<section.length;z++)//section
					{
						addSection(document, "Section:"+section[z]);
						 rs=st1.executeQuery("select semester,section,department,facultyname,avg(score) from facultyscore group by facultyname,section,semester,over having department='"+dept[j]+"' and section='"+section[z]+"' and semester='"+semester[k]+"' and over='yes'");
						 String faculty[]=new String[10];
						 String score[]=new String[10];
						 int n=0;
						 while(rs.next())
						 {
							 faculty[n]=rs.getString("facultyname");
							 score[n]=rs.getString("avg(score)");
							 n++;
						 }
						 
						 createPdfTable(document,faculty,score, n);
					}
				}
				addPage(document);
			}
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		
	}

	
	
	private static void createPdfTable(Document document,String faculty[],String score[],int n) throws DocumentException{
	PdfPTable table = new PdfPTable(2);
	Font boldFont=new Font(Font.FontFamily.TIMES_ROMAN,18,Font.BOLD);
	Phrase p=new Phrase("FACULTY", boldFont);
	Phrase p1=new Phrase("SCORE",boldFont);
	PdfPCell c1 = new PdfPCell(p);
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);

	c1 = new PdfPCell(p1);
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);

	
	table.setHeaderRows(1);

	for (int i = 0; i < n; i++) {
		table.setWidthPercentage(100);
		table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
		table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(faculty[i]);
		table.addCell(score[i]);
		
	}

	document.add(table);

}
 
}
