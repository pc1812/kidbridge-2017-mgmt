package net.$51zhiyuan.development.kidbridge.module.typehandler;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * Created by hkhl.cn on 2017/4/1.
 */

public class JsonTypeHandler extends BaseTypeHandler {

    private ObjectMapper mapper = new ObjectMapper();

    @Override
    public void setNonNullParameter(PreparedStatement preparedStatement, int i, Object o, JdbcType jdbcType) throws SQLException {
        try {
            if (o != null) {
                String value = this.mapper.writeValueAsString(o);
                //preparedStatement.setString(i, ((value.equals("{}") || value.equals("[]")) ? "" : value));
                preparedStatement.setString(i, value);
            }
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Object getNullableResult(ResultSet resultSet, String s) throws SQLException {
        Object o = null;
        String value = resultSet.getString(s);

        try {
            if(!StringUtils.isBlank(value)){
                o = value.indexOf("[") == 0 ? this.mapper.readValue(value, List.class) : this.mapper.readValue(value, Map.class);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return o;
    }

    @Override
    public Object getNullableResult(ResultSet resultSet, int i) {
        System.out.println("getNullableResult");
        return null;
    }

    @Override
    public Object getNullableResult(CallableStatement callableStatement, int i) {
        System.out.println("getNullableResult");
        return null;
    }

    public static void main(String[] args) {
        System.out.println(UUID.randomUUID().toString().replace("-",""));
    }
}
