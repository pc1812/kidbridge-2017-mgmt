package net.$51zhiyuan.development.kidbridge.test.module;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.xssf.usermodel.*;
import org.junit.Test;

import java.io.FileOutputStream;
import java.util.Date;

public class Excel {

    @Test
    public void test1() throws Exception {
        XSSFWorkbook xssfWorkbook = new XSSFWorkbook();
        XSSFSheet xssfSheet = xssfWorkbook.createSheet();// 创建一个工作薄对象
        xssfWorkbook.setSheetName(0, "绘本跟读明细");
        //xssfSheet.setColumnWidth(1, 10000);// 设置第二列的宽度为
        XSSFRow xssfRowHeader = xssfSheet.createRow(0);// 创建一个行对象
        //header.setHeightInPoints(23);// 设置行高23像素
        XSSFCellStyle xssfCellStyle = xssfWorkbook.createCellStyle();// 创建样式对象
        // 设置字体
        XSSFFont xssfFont = xssfWorkbook.createFont();// 创建字体对象
//        xssfFont.setFontHeightInPoints((short) 15);// 设置字体大小
        xssfFont.setBold(true);// 设置粗体
//        xssfFont.setFontName("黑体");// 设置为黑体字
        xssfCellStyle.setFont(xssfFont);// 将字体加入到样式对象
        // 设置对齐方式
        xssfCellStyle.setAlignment(HorizontalAlignment.CENTER);// 水平居中
        xssfCellStyle.setVerticalAlignment(VerticalAlignment.CENTER);// 垂直居中

        // 设置边框
        xssfCellStyle.setBorderTop(BorderStyle.THIN);// 顶部边框粗线
        //xssfCellStyle.setTopBorderColor(HSSFColor.RED.index);// 设置为红色
        xssfCellStyle.setBorderBottom(BorderStyle.THIN);// 底部边框双线
        xssfCellStyle.setBorderLeft(BorderStyle.THIN);// 左边边框
        xssfCellStyle.setBorderRight(BorderStyle.THIN);// 右边边框
        xssfCellStyle.setShrinkToFit(true);
        // 格式化日期
        //XSSFDataFormat xssfDataFormat = xssfWorkbook.createDataFormat();
        //xssfCellStyle.setDataFormat(xssfDataFormat.getFormat("yyyy-mm-dd hh:mm:ss"));
        //XSSFCell cell = xssfRowHeader.createCell(0);// 创建单元格
        //cell.setCellValue(new Date());// 写入当前日期
        //cell.setCellStyle(xssfCellStyle);// 应用样式对象

        XSSFCell headerUserId = xssfRowHeader.createCell(0);
        headerUserId.setCellValue("用户编号");
        headerUserId.setCellStyle(xssfCellStyle);
        XSSFCell headerUserNickname = xssfRowHeader.createCell(1);
        headerUserNickname.setCellValue("用户昵称");
        headerUserNickname.setCellStyle(xssfCellStyle);
        XSSFCell headerBookId = xssfRowHeader.createCell(2);
        headerBookId.setCellValue("绘本编号");
        headerBookId.setCellStyle(xssfCellStyle);
        XSSFCell headerBookName = xssfRowHeader.createCell(3);
        headerBookName.setCellValue("绘本名称");
        headerBookName.setCellStyle(xssfCellStyle);
        XSSFCell headerCreateTime = xssfRowHeader.createCell(4);
        headerCreateTime.setCellValue("首次跟读时间");
        headerCreateTime.setCellStyle(xssfCellStyle);
        XSSFCell headerUpdateTime = xssfRowHeader.createCell(5);
        headerUpdateTime.setCellValue("最近跟读时间");
        headerUpdateTime.setCellStyle(xssfCellStyle);


        // 文件输出流
        FileOutputStream os = new FileOutputStream("X:\\excel\\style_2007.xlsx");
        xssfWorkbook.write(os);// 将文档对象写入文件输出流
        os.close();// 关闭文件输出流
        System.out.println("创建成功 office 2007 excel");
    }


//    @Test
//    public void test1() throws Exception{
//        // HSSFWorkbook workBook = new HSSFWorkbook();// 创建 一个excel文档对象
//        XSSFWorkbook workBook = new XSSFWorkbook();
//        XSSFSheet sheet = workBook.createSheet();// 创建一个工作薄对象
//        sheet.setColumnWidth(1, 10000);// 设置第二列的宽度为
//        XSSFRow row = sheet.createRow(1);// 创建一个行对象
//        row.setHeightInPoints(23);// 设置行高23像素
//        XSSFCellStyle style = workBook.createCellStyle();// 创建样式对象
//// 设置字体
//        XSSFFont font = workBook.createFont();// 创建字体对象
//        font.setFontHeightInPoints((short) 15);// 设置字体大小
//        font.setBold(true);// 设置粗体
//        font.setFontName("黑体");// 设置为黑体字
//        style.setFont(font);// 将字体加入到样式对象
//// 设置对齐方式
//        style.setAlignment(HorizontalAlignment.CENTER);// 水平居中
//        style.setVerticalAlignment(VerticalAlignment.CENTER);// 垂直居中
//
//// 设置边框
//        style.setBorderTop(BorderStyle.DASHED);// 顶部边框粗线
//        style.setTopBorderColor(HSSFColor.RED.index);// 设置为红色
//        style.setBorderBottom(BorderStyle.DASHED);// 底部边框双线
//        style.setBorderLeft(BorderStyle.DASHED);// 左边边框
//        style.setBorderRight(BorderStyle.DASHED);// 右边边框
//// 格式化日期
//        XSSFDataFormat xssfDataFormat = workBook.createDataFormat();
//        //HSSFDataFormat format= workBook.createDataFormat();
//        style.setDataFormat(HSSFDataFormat.getBuiltinFormat("yyyy/m/d h:mm"));
//        XSSFCell cell = row.createCell(1);// 创建单元格
//        cell.setCellValue(new Date());// 写入当前日期
//        cell.setCellStyle(style);// 应用样式对象
//// 文件输出流
//        FileOutputStream os = new FileOutputStream("X:\\excel\\style_2007.xlsx");
//        workBook.write(os);// 将文档对象写入文件输出流
//        os.close();// 关闭文件输出流
//        System.out.println("创建成功 office 2007 excel");
//    }
}
