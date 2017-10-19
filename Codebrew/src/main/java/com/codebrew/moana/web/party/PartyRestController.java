package com.codebrew.moana.web.party;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.FileUploadException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.codebrew.moana.service.party.PartyService;




@RestController
@RequestMapping("/partyRest/*")
public class PartyRestController {

	///Field///
	@Autowired
	@Qualifier("partyServiceImpl")
	private PartyService partyService;
	
	
	///Constructor///
	public PartyRestController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass()+"Default Constructor Call");
	}
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	
	/*@RequestMapping( value="json/addProduct", method=RequestMethod.GET )
	public String addProduct(){
		
		System.out.println(">>> /product/json/addProduct GET start <<<");

		return "forward:/product/addProductView.jsp";
	}
	
	@RequestMapping( value="json/addProduct", method=RequestMethod.POST )
	public Product addProduct( HttpServletRequest request, @RequestBody Product product) throws Exception{
		
		System.out.println(">>> /product/json/addProduct :: POST start <<<");

		MultipartFile uploadFile = product.getUploadFile();
		
		if(uploadFile != null){
			String fileName = uploadFile.getOriginalFilename();
			System.out.println("uploaded file name :: "+fileName);
			
			String fileDirectory = request.getServletContext().getInitParameter("fileDirectory");
			System.out.println("uploaded file Directory :: "+fileDirectory);

//			File file = new File("C:\\Users\\Seri\\git\\07.Model2MVCShop\\07.Model2MVCShop(URI,pattern)\\WebContent\\images\\uploadFiles\\"+fileName);
			
			if(fileName != null && !fileName.equals("")){
				fileName = System.currentTimeMillis()+"_"+fileName;
				
				File file = new File(fileDirectory+fileName);
				uploadFile.transferTo(file);
				product.setFileName(fileName);
			}
			
		}
		
		System.out.println("addProduct product :: "+product);

		productService.addProduct(product);	
		
		return productService.getProductByName(product.getProdName());
	}
	
	
	@RequestMapping( value="json/listProduct/{menu}", method=RequestMethod.GET)
	public Map listProduct( @PathVariable String menu, Model model) throws Exception{
		
		System.out.println(">>> /product/listProduct :: GET start <<<");

		Search search = new Search();
				
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business Logic ����
		Map<String, Object> map = productService.getProductList(search);
		
		Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("menu", menu);
		
		
		return map;
	}
	
	
	@RequestMapping( value="json/listProduct/{menu}", method=RequestMethod.POST)
	public Map listProduct( @ModelAttribute("search") Search search, @PathVariable String menu, Model model) throws Exception{
		
		System.out.println(">>> /product/listProduct:: POST start <<<");
		System.out.println("listProduct search :: "+search);
		System.out.println(menu );
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business Logic ����
		Map<String, Object> map = productService.getProductList(search);
		
		Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("menu", menu);
		
		return map;
	}
	
	
	@RequestMapping("json/getProduct/{prodNo}")
	public Product getProduct( @PathVariable String prodNo) throws Exception{
		
		System.out.println(">>> /product/getProduct:: GET start <<<");
		
		// Business Logic ����
		int prodNoInt = Integer.parseInt(prodNo);
		//Product product = productService.getProduct(prodNoInt);
		
		// Model �� View ����
		model.addAttribute("product", product);
		model.addAttribute("menu", menu);
		
		if(menu.equals("manage")){
			return "forward:/product/updateProductView.jsp";
		}else if(menu.equals("search")){
			return "forward:/product/getProduct.jsp";
		}else{
			return null;
		}
		Product product = productService.getProduct(prodNoInt);
		System.out.println("Ȯ�� :: "+product);
		
		return product;
	}
	
	
	@RequestMapping( value="json/updateProduct/{prodNo}", method=RequestMethod.GET)
	public Product updateProduct( @PathVariable String prodNo, Model model) throws Exception{
		
		System.out.println(">>> /product/updateProduct:: GET start <<<");
		
		int prodNoInt = Integer.parseInt(prodNo);
		
		// Business Logic ����
		Product product = productService.getProduct(prodNoInt);
		
		// Model �� View ����
		model.addAttribute("product", product);

		return product;
	}
	
	
	@RequestMapping( value="json/updateProduct", method=RequestMethod.POST)
	public Product updateProduct( HttpServletRequest request, @RequestBody Product product) throws Exception{
		
		System.out.println(">>> /product/updateProduct:: POST start <<<");
		
		MultipartFile uploadFile = product.getUploadFile();
		
		if(uploadFile != null){
			String fileName = uploadFile.getOriginalFilename();
			System.out.println("uploaded file name :: "+fileName);
			
			String fileDirectory = request.getServletContext().getInitParameter("fileDirectory");
			System.out.println("uploaded file Directory :: "+fileDirectory);
			
			if(fileName != null && !fileName.equals("")){
				fileName = System.currentTimeMillis()+"_"+fileName;
				
				File file = new File(fileDirectory+fileName);
				uploadFile.transferTo(file);
				product.setFileName(fileName);
			}
			
		}
						
		// Business Logic ����
		productService.updateProduct(product);
		Product product01 = productService.getProduct(product.getProdNo());
		// Model �� View ����
		model.addAttribute("product", product);
		model.addAttribute("menu", "manage");
		
		return product01;
	}*/
	
	
	
}

