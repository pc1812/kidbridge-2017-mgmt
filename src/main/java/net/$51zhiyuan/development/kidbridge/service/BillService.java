package net.$51zhiyuan.development.kidbridge.service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageRowBounds;
import net.$51zhiyuan.development.kidbridge.ui.model.*;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.xssf.usermodel.*;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 费用明细
 */
@Service
public class BillService {

    private final Logger logger = LogManager.getLogger(BillService.class);

    private final String namespace = "net.$51zhiyuan.development.kidbridge.dao.bill.";

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    @Deprecated
    public Bill get(Bill param){
        return this.sqlSessionTemplate.selectOne(this.namespace + "get",param);
    }

    @Deprecated
    public Map list(Map param){
        int show = 20;
        int currPage = (param.get("page") == null || StringUtils.isBlank(param.get("page").toString())) ? 1 : Integer.parseInt(param.get("page").toString());
        int maxLabel = 9;
        int z = (maxLabel / 2 + 1);
        Page page = PageHelper.startPage(currPage,show);
        List dataList = this.sqlSessionTemplate.selectList(this.namespace + "list",new Bill());
        int totalPage = page.getPages();
        List pageNumberList = new ArrayList(maxLabel);
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
            this.put("page",new HashMap(){{
                this.put("numberList",pageNumberList);
                this.put("min",1);
                this.put("max",totalPage);
                this.put("current",currPage);
            }});
            this.put("dataList",dataList);
        }};
    }

    @Deprecated
    public List<Bill> list(Bill param){
        return this.sqlSessionTemplate.selectList(this.namespace + "list",param);
    }

    @Deprecated
    public List<Bill> list(Object param, PageRowBounds page) {
        return this.sqlSessionTemplate.selectList(this.namespace + "list",param,page);
    }

    /**
     * 新增费用明细
     * @param param
     * @return
     */
    public Integer add(Bill param){
        return this.sqlSessionTemplate.insert(this.namespace + "add",param);
    }

    @Deprecated
    public BigDecimal sum(Bill param){
        return this.sqlSessionTemplate.selectOne(this.namespace + "sum",param);
    }

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
        List<Map> dataList = this.sqlSessionTemplate.selectList(this.namespace + "detailList",param);
        XSSFWorkbook xssfWorkbook = new XSSFWorkbook();
        XSSFSheet xssfSheet = xssfWorkbook.createSheet();// 创建一个工作薄对象
        xssfWorkbook.setSheetName(0, "课程跟读明细");
        xssfSheet.setColumnWidth(0, 10*256);
        xssfSheet.setColumnWidth(1, 10*256);
        xssfSheet.setColumnWidth(2, 50*256);
        xssfSheet.setColumnWidth(3, 70*256);
        xssfSheet.setColumnWidth(4, 10*256);
        xssfSheet.setColumnWidth(5, 10*256);
        xssfSheet.setColumnWidth(6, 20*256);
        xssfSheet.setColumnWidth(7, 20*256);
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
        headerUserId.setCellValue("明细编号");
        headerUserId.setCellStyle(xssfCellStyleHeader);
        XSSFCell headerUserNickname = xssfRowHeader.createCell(1);
        headerUserNickname.setCellValue("用户编号");
        headerUserNickname.setCellStyle(xssfCellStyleHeader);
        XSSFCell headerCourseId = xssfRowHeader.createCell(2);
        headerCourseId.setCellValue("用户昵称");
        headerCourseId.setCellStyle(xssfCellStyleHeader);
        XSSFCell headerReceiving = xssfRowHeader.createCell(3);
        headerReceiving.setCellValue("收件信息");
        headerReceiving.setCellStyle(xssfCellStyleHeader);
        XSSFCell headerCourseName = xssfRowHeader.createCell(4);
        headerCourseName.setCellValue("金额类别");
        headerCourseName.setCellStyle(xssfCellStyleHeader);
        XSSFCell headerBookId = xssfRowHeader.createCell(5);
        headerBookId.setCellValue("收支金额");
        headerBookId.setCellStyle(xssfCellStyleHeader);
        XSSFCell headerBookName = xssfRowHeader.createCell(6);
        headerBookName.setCellValue("收支类别");
        headerBookName.setCellStyle(xssfCellStyleHeader);
        XSSFCell headerCreateTime = xssfRowHeader.createCell(7);
        headerCreateTime.setCellValue("收支时间");
        headerCreateTime.setCellStyle(xssfCellStyleHeader);

        for(int i=0;i<dataList.size();i++){
            Map bill = dataList.get(i);
            Map user = (Map) bill.get("user");
            XSSFRow xssfRowBody = xssfSheet.createRow(i+1);// 创建一个行对象
            XSSFCell bodyUserId = xssfRowBody.createCell(0);
            bodyUserId.setCellValue(bill.get("bill_id").toString());
            bodyUserId.setCellStyle(xssfCellStyleBody);
            XSSFCell bodyUserNickname = xssfRowBody.createCell(1);
            bodyUserNickname.setCellValue(user.get("user_id").toString());
            bodyUserNickname.setCellStyle(xssfCellStyleBody);
            XSSFCell bodyCourseId = xssfRowBody.createCell(2);
            bodyCourseId.setCellValue(StringUtils.isBlank(user.get("user_nickname").toString()) ? "未知" : user.get("user_nickname").toString());
            bodyCourseId.setCellStyle(xssfCellStyleBody);
            XSSFCell bodyReceiving = xssfRowBody.createCell(3);
            if(!StringUtils.isBlank(user.get("user_receiving_contact").toString()) && !StringUtils.isBlank(user.get("user_receiving_phone").toString()) && !StringUtils.isBlank(user.get("user_receiving_region").toString()) && !StringUtils.isBlank(user.get("user_receiving_street").toString())){
                bodyReceiving.setCellValue(user.get("user_receiving_contact").toString() + " " + user.get("user_receiving_phone").toString() + " " + user.get("user_receiving_region").toString() +" " + user.get("user_receiving_street").toString());
            }else{
                bodyReceiving.setCellValue("未知");
            }
            bodyReceiving.setCellStyle(xssfCellStyleBody);
            XSSFCell bodyCourseName = xssfRowBody.createCell(4);
            bodyCourseName.setCellValue(bill.get("bill_fee_type").toString());
            bodyCourseName.setCellStyle(xssfCellStyleBody);
            XSSFCell bodyBookId = xssfRowBody.createCell(5);
            bodyBookId.setCellValue(bill.get("bill_fee").toString());
            bodyBookId.setCellStyle(xssfCellStyleBody);
            XSSFCell bodyBookName = xssfRowBody.createCell(6);
            bodyBookName.setCellValue(bill.get("bill_bill_type").toString());
            bodyBookName.setCellStyle(xssfCellStyleBody);
            XSSFCell bodyCreateTime = xssfRowBody.createCell(7);
            bodyCreateTime.setCellValue(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(bill.get("bill_create_time")));
            bodyCreateTime.setCellStyle(xssfCellStyleBody);

        }
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        xssfWorkbook.write(byteArrayOutputStream);
        return byteArrayOutputStream.toByteArray();
    }

}
