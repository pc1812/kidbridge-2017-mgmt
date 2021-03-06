package net.$51zhiyuan.development.kidbridge.service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import net.$51zhiyuan.development.kidbridge.ui.model.*;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.xssf.usermodel.*;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 用户绘本跟读
 */
@Service
public class UserBookRepeatService {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    private final String namespace = "net.$51zhiyuan.development.kidbridge.dao.userBookRepeat.";

    public Map detailList(Map param){
        int show = 20;
        int currPage = (param.get("page") == null || StringUtils.isBlank(param.get("page").toString())) ? 1 : Integer.parseInt(param.get("page").toString());
        int maxLabel = 9;
        int z = (maxLabel / 2 + 1);
        Page page = PageHelper.startPage(currPage,show);
        List dataList = this.sqlSessionTemplate.selectList(this.namespace + "detailList",param);
        int totalPage = page.getPages();
        List pageNumberList = new ArrayList(maxLabel);
        // 分页参数处理
        for(int i=0;i<(totalPage < maxLabel ? totalPage : maxLabel);i++){
            if(currPage <= z){
                pageNumberList.add(i + 1);
            }else if(currPage > z && currPage <= totalPage - z + 1){
                int c = currPage - z;
                pageNumberList.add(c + 1 + i);
            }else {
                pageNumberList.add(totalPage < maxLabel ? i + 1 : totalPage - maxLabel + i+1);
            }
        }
        return new HashMap(){{
            this.put("page",new HashMap(){{ // 分页信息
                this.put("numberList",pageNumberList);
                this.put("min",1);
                this.put("max",totalPage);
                this.put("current",currPage);
            }});
            this.put("dataList",dataList);
        }};
    }

    public byte[] detailExport(Map param) throws IOException {
        List<UserBookRepeat> dataList = this.sqlSessionTemplate.selectList(this.namespace + "detailList",param);
        XSSFWorkbook xssfWorkbook = new XSSFWorkbook();
        XSSFSheet xssfSheet = xssfWorkbook.createSheet();// 创建一个工作薄对象
        xssfWorkbook.setSheetName(0, "绘本跟读明细");
        xssfSheet.setColumnWidth(0, 10*256);
        xssfSheet.setColumnWidth(1, 50*256);
        xssfSheet.setColumnWidth(2, 10*256);
        xssfSheet.setColumnWidth(3, 50*256);
        xssfSheet.setColumnWidth(4, 20*256);
        xssfSheet.setColumnWidth(5, 20*256);
        xssfSheet.setDefaultRowHeightInPoints(20);
        //header.setHeightInPoints(23);// 设置行高23像素
        XSSFCellStyle xssfCellStyleHeader = xssfWorkbook.createCellStyle();// 创建样式对象
        XSSFFont xssfFont = xssfWorkbook.createFont();// 创建字体对象
        xssfFont.setBold(true);// 设置粗体
        xssfCellStyleHeader.setFont(xssfFont);// 将字体加入到样式对象
        xssfCellStyleHeader.setAlignment(HorizontalAlignment.CENTER);// 水平居中
        xssfCellStyleHeader.setVerticalAlignment(VerticalAlignment.CENTER);// 垂直居中
        xssfCellStyleHeader.setBorderTop(BorderStyle.THIN);// 顶部边框粗线
        xssfCellStyleHeader.setBorderBottom(BorderStyle.THIN);// 底部边框双线
        xssfCellStyleHeader.setBorderLeft(BorderStyle.THIN);// 左边边框
        xssfCellStyleHeader.setBorderRight(BorderStyle.THIN);// 右边边框
        xssfCellStyleHeader.setShrinkToFit(true);


        XSSFCellStyle xssfCellStyleBody = xssfWorkbook.createCellStyle();// 创建样式对象
        xssfCellStyleBody.setAlignment(HorizontalAlignment.CENTER);// 水平居中
        xssfCellStyleBody.setVerticalAlignment(VerticalAlignment.CENTER);// 垂直居中
        xssfCellStyleBody.setBorderTop(BorderStyle.THIN);// 顶部边框粗线
        xssfCellStyleBody.setBorderBottom(BorderStyle.THIN);// 底部边框双线
        xssfCellStyleBody.setBorderLeft(BorderStyle.THIN);// 左边边框
        xssfCellStyleBody.setBorderRight(BorderStyle.THIN);// 右边边框
        xssfCellStyleBody.setShrinkToFit(true);

        XSSFRow xssfRowHeader = xssfSheet.createRow(0);// 创建一个行对象
        XSSFCell headerUserId = xssfRowHeader.createCell(0);
        headerUserId.setCellValue("用户编号");
        headerUserId.setCellStyle(xssfCellStyleHeader);
        XSSFCell headerUserNickname = xssfRowHeader.createCell(1);
        headerUserNickname.setCellValue("用户昵称");
        headerUserNickname.setCellStyle(xssfCellStyleHeader);
        XSSFCell headerBookId = xssfRowHeader.createCell(2);
        headerBookId.setCellValue("绘本编号");
        headerBookId.setCellStyle(xssfCellStyleHeader);
        XSSFCell headerBookName = xssfRowHeader.createCell(3);
        headerBookName.setCellValue("绘本名称");
        headerBookName.setCellStyle(xssfCellStyleHeader);
        XSSFCell headerCreateTime = xssfRowHeader.createCell(4);
        headerCreateTime.setCellValue("首次跟读时间");
        headerCreateTime.setCellStyle(xssfCellStyleHeader);
        XSSFCell headerUpdateTime = xssfRowHeader.createCell(5);
        headerUpdateTime.setCellValue("最近跟读时间");
        headerUpdateTime.setCellStyle(xssfCellStyleHeader);

        for(int i=0;i<dataList.size();i++){
            UserBookRepeat userBookRepeat = dataList.get(i);
            UserBook userBook = userBookRepeat.getUserBook();
            XSSFRow xssfRowBody = xssfSheet.createRow(i+1);// 创建一个行对象
            XSSFCell bodyUserId = xssfRowBody.createCell(0);
            bodyUserId.setCellValue(userBook.getUser().getId());
            bodyUserId.setCellStyle(xssfCellStyleBody);
            XSSFCell bodyUserNickname = xssfRowBody.createCell(1);
            bodyUserNickname.setCellValue(userBook.getUser().getNickname());
            bodyUserNickname.setCellStyle(xssfCellStyleBody);
            XSSFCell bodyBookId = xssfRowBody.createCell(2);
            bodyBookId.setCellValue(userBook.getBook().getId());
            bodyBookId.setCellStyle(xssfCellStyleBody);
            XSSFCell bodyBookName = xssfRowBody.createCell(3);
            bodyBookName.setCellValue(userBook.getBook().getName());
            bodyBookName.setCellStyle(xssfCellStyleBody);
            XSSFCell bodyCreateTime = xssfRowBody.createCell(4);
            bodyCreateTime.setCellValue(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(userBookRepeat.getCreateTime()));
            bodyCreateTime.setCellStyle(xssfCellStyleBody);
            XSSFCell bodyUpdateTime = xssfRowBody.createCell(5);
            bodyUpdateTime.setCellValue(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(userBookRepeat.getUpdateTime()));
            bodyUpdateTime.setCellStyle(xssfCellStyleBody);

        }
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        xssfWorkbook.write(byteArrayOutputStream);
        return byteArrayOutputStream.toByteArray();
    }
}
