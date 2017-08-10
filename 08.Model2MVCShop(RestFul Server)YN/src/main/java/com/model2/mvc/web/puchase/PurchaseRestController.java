package com.model2.mvc.web.puchase;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	public PurchaseRestController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="json/addPurchase/{prodNo}", method=RequestMethod.GET)
	public Product addPurchase(@PathVariable int prodNo) throws Exception{
		
		System.out.println("/purchase/json/addPurchase : GET");

		return productService.getProduct(prodNo);
	}
	
	@RequestMapping(value="json/addPurchase", method=RequestMethod.POST)
	public int addPurchase(@RequestBody Purchase purchase) throws Exception{
		
		System.out.println("/purchase/json/addPurchase : GET");

		return purchaseService.addPurchase(purchase);
	}
	
	@RequestMapping(value = "json/getPurchase/{tranNo}", method=RequestMethod.GET)
	public Purchase getPurchase(@PathVariable("tranNo") int tranNo) throws Exception{
		
		System.out.println("/product/json/getProduct : GET");

		return purchaseService.getPurchase(tranNo);
	}
	
//	@RequestMapping(value = "json/getPurchase/{prodNo}", method=RequestMethod.GET)
//	public Purchase getPurchase2(@PathVariable("prodNo") int prodNo) throws Exception{
//		
//		System.out.println("/product/json/getProduct2 : GET");
//
//		return purchaseService.getPurchase2(prodNo);
//	}
}
