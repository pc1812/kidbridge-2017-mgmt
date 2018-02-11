package net.$51zhiyuan.development.kidbridge.service;

import android.content.res.AXmlResourceParser;
import android.util.TypedValue;
import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import net.$51zhiyuan.development.kidbridge.ui.model.Version;
import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipArchiveInputStream;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;

import java.io.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 客户端版本更新
 */
@Service
public class VersionService {

    private final Logger logger = LogManager.getLogger(VersionService.class);

    private final String namespace = "net.$51zhiyuan.development.kidbridge.dao.version.";

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    public Version check(String device){
        if(!(device.toLowerCase().equals("ios") || device.toLowerCase().equals("android"))){
            throw new KidbridgeSimpleException("未知的终端设备 ~");
        }
        return this.lastVersion(device.equals("ios") ? 1 : 0);
    }

    public Version lastVersion(Integer device){
        return this.sqlSessionTemplate.selectOne(this.namespace + "lastVersion",new Version().setDevice(device));
    }

    public void add(Version version){
        this.sqlSessionTemplate.insert(this.namespace + "add",version);
    }



    private static final float RADIX_MULTS[]={
            0.00390625F,3.051758E-005F,1.192093E-007F,4.656613E-010F
    };

    private static final String DIMENSION_UNITS[]={
            "px","dip","sp","pt","in","mm","",""
    };

    private static final String FRACTION_UNITS[]={
            "%","%p","","","","","",""
    };

    public String getNumber(byte[] apkFile) throws IOException, XmlPullParserException {
        String androidManifest =  this.androidManifestDecode(this.getAndroidManifest(apkFile));
        Matcher matcher = Pattern.compile("android:versionName=\"(.*?)\"").matcher(androidManifest);
        if(matcher.find()){
            String number = matcher.group(1);
            if(!number.matches("\\d+\\.\\d+\\.\\d+")){
                throw new KidbridgeSimpleException("不正确的版本号信息，请联系相关开发人员 ~");
            }
            return number;
        }
        throw new KidbridgeSimpleException("未查询到版本号信息，请确保文件格式正确 ~");
    }

    private InputStream getAndroidManifest(byte[] apkFile) {
        ZipArchiveInputStream zipArchiveInputStream = new ZipArchiveInputStream(new ByteArrayInputStream(apkFile));
        ZipArchiveEntry zipArchiveEntry = null;
        try{
            while ((zipArchiveEntry = zipArchiveInputStream.getNextZipEntry()) != null) {
                if(!zipArchiveEntry.isDirectory()){
                    if(zipArchiveEntry.getName().equals("AndroidManifest.xml")){
                        return new ByteArrayInputStream(IOUtils.toByteArray(zipArchiveInputStream));
                    }
                }
            }
        }catch (Exception ignored){

        }
        throw new KidbridgeSimpleException("未查询到版本号信息");
    }

    private String androidManifestDecode(InputStream inputStream) throws XmlPullParserException, IOException {
        AXmlResourceParser parser=new AXmlResourceParser();
        parser.open(inputStream);
        StringBuilder indent=new StringBuilder(10);
        StringBuilder result = new StringBuilder();
        final String indentStep="	";
        while (true) {
            int type=parser.next();
            if (type== XmlPullParser.END_DOCUMENT) {
                break;
            }
            switch (type) {
                case XmlPullParser.START_DOCUMENT:
                {
                    result.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
                    break;
                }
                case XmlPullParser.START_TAG:
                {
                    result.append(String.format("%s<%s%s",indent, getNamespacePrefix(parser.getPrefix()),parser.getName()));
                    indent.append(indentStep);

                    int namespaceCountBefore=parser.getNamespaceCount(parser.getDepth()-1);
                    int namespaceCount=parser.getNamespaceCount(parser.getDepth());
                    for (int i=namespaceCountBefore;i!=namespaceCount;++i) {
                        result.append(String.format("%sxmlns:%s=\"%s\"", indent, parser.getNamespacePrefix(i), parser.getNamespaceUri(i)));
                    }

                    for (int i=0;i!=parser.getAttributeCount();++i) {
                        result.append(String.format("%s%s%s=\"%s\"",indent, getNamespacePrefix(parser.getAttributePrefix(i)), parser.getAttributeName(i), getAttributeValue(parser,i)));
                    }
                    result.append(String.format("%s>",indent));
                    break;
                }
                case XmlPullParser.END_TAG:
                {
                    indent.setLength(indent.length()-indentStep.length());
                    result.append(String.format("%s</%s%s>",indent, getNamespacePrefix(parser.getPrefix()), parser.getName()));
                    break;
                }
                case XmlPullParser.TEXT:
                {
                    result.append(String.format("%s%s",indent,parser.getText()));
                    break;
                }
            }
        }
        return result.toString();
    }

    private static String getNamespacePrefix(String prefix) {
        if (prefix==null || prefix.length()==0) {
            return "";
        }
        return prefix+":";
    }

    private static String getAttributeValue(AXmlResourceParser parser,int index) {
        int type=parser.getAttributeValueType(index);
        int data=parser.getAttributeValueData(index);
        if (type== TypedValue.TYPE_STRING) {
            return parser.getAttributeValue(index);
        }
        if (type==TypedValue.TYPE_ATTRIBUTE) {
            return String.format("?%s%08X",getPackage(data),data);
        }
        if (type==TypedValue.TYPE_REFERENCE) {
            return String.format("@%s%08X",getPackage(data),data);
        }
        if (type==TypedValue.TYPE_FLOAT) {
            return String.valueOf(Float.intBitsToFloat(data));
        }
        if (type==TypedValue.TYPE_INT_HEX) {
            return String.format("0x%08X",data);
        }
        if (type==TypedValue.TYPE_INT_BOOLEAN) {
            return data!=0?"true":"false";
        }
        if (type==TypedValue.TYPE_DIMENSION) {
            return Float.toString(complexToFloat(data))+
                    DIMENSION_UNITS[data & TypedValue.COMPLEX_UNIT_MASK];
        }
        if (type==TypedValue.TYPE_FRACTION) {
            return Float.toString(complexToFloat(data))+
                    FRACTION_UNITS[data & TypedValue.COMPLEX_UNIT_MASK];
        }
        if (type>=TypedValue.TYPE_FIRST_COLOR_INT && type<=TypedValue.TYPE_LAST_COLOR_INT) {
            return String.format("#%08X",data);
        }
        if (type>=TypedValue.TYPE_FIRST_INT && type<=TypedValue.TYPE_LAST_INT) {
            return String.valueOf(data);
        }
        return String.format("<0x%X, type 0x%02X>",data,type);
    }

    private static String getPackage(int id) {
        if (id>>>24==1) {
            return "android:";
        }
        return "";
    }

    private static float complexToFloat(int complex) {
        return (float)(complex & 0xFFFFFF00)*RADIX_MULTS[(complex>>4) & 3];
    }
}
