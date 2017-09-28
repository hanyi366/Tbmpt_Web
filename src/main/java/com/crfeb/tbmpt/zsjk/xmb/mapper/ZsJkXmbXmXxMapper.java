package com.crfeb.tbmpt.zsjk.xmb.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.baomidou.mybatisplus.mapper.CommonMapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.crfeb.tbmpt.zsjk.xmb.model.ZsJkXmbXmXx;

/**
 * <p>项目部角度 项目基本信息Mapper</p>
 * <p>系统：展示界面接口</p>
 * <p>模块：项目部角度模块</p>
 * <p>日期：2017-01-09</p>
 * @version 1.0
 * @author YangYJ
 */
public interface ZsJkXmbXmXxMapper extends CommonMapper<ZsJkXmbXmXx>{

    List<ZsJkXmbXmXx> selectZsJkXmbXmXxList(Page<ZsJkXmbXmXx> page,@Param("condition")Map<String, Object> condition) throws Exception;

}