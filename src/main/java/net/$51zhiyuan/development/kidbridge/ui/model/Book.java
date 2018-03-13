package net.$51zhiyuan.development.kidbridge.ui.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * Created by hkhl.cn on 2017/7/31.
 */
public class Book implements Serializable {

    private Integer id;
    private String name;
    private List icon;
    private BookCopyright copyright;
    private BigDecimal price;
    private String richText;
    private Integer fit;
    private String outline;
    private String feeling;
    private String difficulty;
    private String audio;
    private List tag;
    private Integer repeatActiveTime;
    private Boolean active;
    private List<BookSegment> bookSegmentList;
    private Integer sort;
    private Boolean delFlag;
    private Date createTime;
    private Date updateTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List getIcon() {
        return icon;
    }

    public void setIcon(List icon) {
        this.icon = icon;
    }

    public BookCopyright getCopyright() {
        return copyright;
    }

    public void setCopyright(BookCopyright copyright) {
        this.copyright = copyright;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getRichText() {
        return richText;
    }

    public void setRichText(String richText) {
        this.richText = richText;
    }

    public Integer getFit() {
        return fit;
    }

    public void setFit(Integer fit) {
        this.fit = fit;
    }

    public String getOutline() {
        return outline;
    }

    public void setOutline(String outline) {
        this.outline = outline;
    }

    public String getFeeling() {
        return feeling;
    }

    public void setFeeling(String feeling) {
        this.feeling = feeling;
    }

    public String getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(String difficulty) {
        this.difficulty = difficulty;
    }

    public String getAudio() {
        return audio;
    }

    public void setAudio(String audio) {
        this.audio = audio;
    }

    public List getTag() {
        return tag;
    }

    public void setTag(List tag) {
        this.tag = tag;
    }

    public Integer getRepeatActiveTime() {
        return repeatActiveTime;
    }

    public void setRepeatActiveTime(Integer repeatActiveTime) {
        this.repeatActiveTime = repeatActiveTime;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public List<BookSegment> getBookSegmentList() {
        return bookSegmentList;
    }

    public void setBookSegmentList(List<BookSegment> bookSegmentList) {
        this.bookSegmentList = bookSegmentList;
    }

    public Boolean getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(Boolean delFlag) {
        this.delFlag = delFlag;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    @Override
    public String toString() {
        return "Book{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", icon=" + icon +
                ", copyright=" + copyright +
                ", price=" + price +
                ", richText='" + richText + '\'' +
                ", fit=" + fit +
                ", outline='" + outline + '\'' +
                ", feeling='" + feeling + '\'' +
                ", difficulty='" + difficulty + '\'' +
                ", audio='" + audio + '\'' +
                ", tag=" + tag +
                ", repeatActiveTime=" + repeatActiveTime +
                ", active=" + active +
                ", bookSegmentList=" + bookSegmentList +
                ", sort=" + sort +
                ", delFlag=" + delFlag +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                '}';
    }
}
