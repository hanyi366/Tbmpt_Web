package com.crfeb.tbmpt.zsjk.xmb.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.crfeb.tbmpt.commons.base.BaseController;
import com.crfeb.tbmpt.commons.utils.ExportDto;
import com.crfeb.tbmpt.commons.utils.ExportExcelUtil;
import com.crfeb.tbmpt.commons.utils.ExportPdfUtil;
import com.crfeb.tbmpt.commons.utils.ExportSetUtil;
import com.crfeb.tbmpt.commons.utils.PageInfo;
import com.crfeb.tbmpt.commons.utils.StringUtils;
import com.crfeb.tbmpt.zsjk.xmb.model.ZsJkXmbXlJdXx;
import com.crfeb.tbmpt.zsjk.xmb.model.dto.ZsJkXmbXlJdXxDto;
import com.crfeb.tbmpt.zsjk.xmb.service.ZsJkXmbXlJdXxService;

/**
 * <p>项目部角度 项目各线路进度信息controlle</p>
 * <p>系统：展示界面接口</p>
 * <p>模块：项目部角度模块</p>
 * <p>日期：2017-01-09</p>
 * @version 1.0
 * @author YangYJ
 */
@Controller
@RequestMapping(value="/zsjk/xmb/zsJkXmbXlJdXx")
public class ZsJkXmbXlJdXxController extends BaseController{

    @Autowired
    private ZsJkXmbXlJdXxService zsJkXmbXlJdXxService;

  @RequestMapping(value = "", method = RequestMethod.GET)
    public String manager() {
        return "zsjk/xmb/zsJkXmbXlJdXx";
    }

    /**
     * 获取项目部角度 项目各线路进度信息easyUi列表
     * @param pageNo 页码
     * @param pageSize 每页条数
     * @param dto 查询条件dto
     * @return 返回查询结果信息
     */
    @RequestMapping(value = "/dataGrid", method = RequestMethod.POST)
    @ResponseBody
    public Object dataGrid(ZsJkXmbXlJdXxDto dto,Integer page, Integer rows, String sort, String order)
    {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        pageInfo.setCondition(condition);
        try {
           zsJkXmbXlJdXxService.selectDataGrid(pageInfo);
        } catch (Exception e) {
           e.printStackTrace();
        }
        return pageInfo;
    }

    /**
     * 添加项目部角度 项目各线路进度信息
     * @param gczlYdxjGPZLDDInfo 要新增的实体信息
     * @return 返回保存成功/失败的提示信息
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public Object add(ZsJkXmbXlJdXxDto zsJkXmbXlJdXxDto) {
    	String errmessage = "";
        try {
          zsJkXmbXlJdXxService.save(zsJkXmbXlJdXxDto,getCurrentUser());
          log(null, true, "新增成功!");
        } catch (Exception e) {
          log(null, false, "新增失败!");
          e.printStackTrace();
        }
        return renderSuccess("添加成功！");
    }

    /**
     * 删除项目部角度 项目各线路进度信息
     * @param ids 要删除的数据的ID集合
     * @return 返回删除成功/失败的提示信息
     */
    @RequestMapping("/delete")
    @ResponseBody
    public Object delete(String ids) {
    	String[] idss = ids.split(",");
    	List<String> idlist = new ArrayList<String>();
    	Collections.addAll(idlist, idss);
    	zsJkXmbXlJdXxService.deleteBatchIds(idlist);
    	log(null, true, "删除："+ids);
    	return renderSuccess("删除成功！");
    }

    /**
     * 修改项目部角度 项目各线路进度信息
     * @param gczlYdxjGPZLDDInfo 要修改的实体信息
     * @return 返回编辑成功/失败的提示信息
     */
    @RequestMapping("/edit")
    @ResponseBody
    public Object edit(ZsJkXmbXlJdXxDto zsJkXmbXlJdXxDto) {
    	String errmessage = "";
        try {
           errmessage = zsJkXmbXlJdXxService.update(zsJkXmbXlJdXxDto,getCurrentUser());
           if(StringUtils.isNotBlank(errmessage)){
             log(null, false, errmessage);
             return renderError(errmessage);
           }
//           log(null, true, "编辑成功:"+zsJkXmbXlJdXxDto.getId());
        } catch (Exception e) {
           log(null, false, "编辑失败!");
           e.printStackTrace();
        }
	      log(null, true, errmessage);
        return renderSuccess("编辑成功!");
    }

    /**     
    * 数据导出     
    * @param exportDto     
    * @param Dto     
    * @param response     
    */
    @SuppressWarnings({"unchecked", "rawtypes"})
    	@RequestMapping(value="/expXls")
    	public void expXls(ExportDto exportDto,ZsJkXmbXlJdXx dto, HttpServletResponse response){
    		try {
    			if(StringUtils.isNotBlank(exportDto.getIds())){
	    			List<String> idsList =new ArrayList<String>();
    				Collections.addAll(idsList, exportDto.getIds().split(ExportDto.SPLIT_STR));
    				List list = zsJkXmbXlJdXxService.selectBatchIds(idsList);
    				ExportExcelUtil.writeExcelToClient(response, exportDto, ExportSetUtil.objectToListMap(list));
	    		}else{
	    	        PageInfo pageInfo = new PageInfo(0, 65530, "id", "desc");
    		        Map<String, Object> condition = new HashMap<String, Object>();
	    	        pageInfo.setCondition(condition);
	    	        zsJkXmbXlJdXxService.selectDataGrid(pageInfo);
	    			ExportExcelUtil.writeExcelToClient(response, exportDto, ExportSetUtil.objectToListMap(pageInfo.getRows()));
	    		}
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    	}
	    }

    /**
     * 数据导出
     * @param exportDto
     * @param Dto
     * @param response
     */
     @SuppressWarnings({"unchecked", "rawtypes"})
     @RequestMapping(value="/expPdf")
     public void expPdf(ExportDto exportDto,ZsJkXmbXlJdXx dto, HttpServletResponse response){
	     	try {
	     		if(StringUtils.isNotBlank(exportDto.getIds())){
	     			List<String> idsList =new ArrayList<String>();
	     			 Collections.addAll(idsList, exportDto.getIds().split(ExportDto.SPLIT_STR));
	     			 List list = zsJkXmbXlJdXxService.selectBatchIds(idsList);
	     			 ExportPdfUtil.writePdfToClient(response, exportDto, ExportSetUtil.objectToListMap(list));
	     		}else{
	     	        PageInfo pageInfo = new PageInfo(0, 65530, "id", "desc");
	     	        Map<String, Object> condition = new HashMap<String, Object>();
	     	        pageInfo.setCondition(condition);
	     	        zsJkXmbXlJdXxService.selectDataGrid(pageInfo);
	     			ExportPdfUtil.writePdfToClient(response, exportDto, ExportSetUtil.objectToListMap(pageInfo.getRows()));
	     		}
	     	} catch (Exception e) {
	     		e.printStackTrace();
	     	}
     }

}