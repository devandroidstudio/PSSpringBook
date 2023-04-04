package WebProject.WebProject.controller;

import java.io.IOException;
import java.security.Principal;
import java.sql.Date;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import WebProject.WebProject.entity.Category;
import WebProject.WebProject.entity.Order;
import WebProject.WebProject.entity.Order_Item;
import WebProject.WebProject.entity.Product;
import WebProject.WebProject.entity.ProductImage;
import WebProject.WebProject.entity.User;
import WebProject.WebProject.model.Mail;
import WebProject.WebProject.service.CategoryService;
import WebProject.WebProject.service.CloudinaryService;
import WebProject.WebProject.service.MailService;
import WebProject.WebProject.service.OrderService;
import WebProject.WebProject.service.Order_ItemService;
import WebProject.WebProject.service.ProductImageService;
import WebProject.WebProject.service.ProductService;
import WebProject.WebProject.service.UserService;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class AdminController {
	@Autowired
	OrderService orderService;

	@Autowired
	UserService userService;

	@Autowired
	ProductService productService;

	@Autowired
	CategoryService categoryService;

	@Autowired
	Order_ItemService order_ItemService;

	@Autowired
	CloudinaryService cloudinaryService;

	@Autowired
	MailService mailService;

	@Autowired
	HttpSession session;

	@Autowired
	ProductImageService productImageService;

	@GetMapping("signin-admin")
	public String SignInAdminView(Model model) {
		String err_sign_admin = (String) session.getAttribute("err_sign_admin");
		model.addAttribute("err_sign_admin", err_sign_admin);
		session.setAttribute("err_sign_admin", null);
		return "signin-admin";
	}

	@PostMapping("signin-admin")
	public String SignInAdminHandel(@ModelAttribute("login-name") String login_name,
									@ModelAttribute("pass") String pass, Model model) throws Exception {
		User admin = userService.findByIdAndRole(login_name, "admin");
		if (admin == null) {
			session.setAttribute("err_sign_admin", "UserName or Password is not correct!");
			return "redirect:/signin-admin";
		} else {
			String decodedValue = new String(Base64.getDecoder().decode(admin.getPassword()));
			if (!decodedValue.equals(pass)) {
				session.setAttribute("err_sign_admin", "UserName or Password is not correct!");
				return "redirect:/signin-admin";
			} else {
				session.setAttribute("admin", admin);
				return "redirect:/dashboard";
			}
		}

	}

	@GetMapping("logout-admin")
	public String LogOutAdmin(Model model) {
		session.setAttribute("admin", null);
		return "redirect:/signin-admin";
	}

	@GetMapping("dashboard")
	public String DashboardView(Model model) {
		User admin = (User) session.getAttribute("admin");
		if (admin == null) {
			return "redirect:/signin-admin";
		} else {
			List<Order> listOrder = orderService.findAll();
			List<Product> listProduct = productService.getAllProduct();
			List<User> listUser = userService.findAll();
			List<Category> listCategory = categoryService.findAll();

			List<Order> recentOrders = orderService.findTop5RecentOrder();
			List<String> recentUser = orderService.findTop5RecentCustomer();
			List<User> recentCustomer = new ArrayList<>();
			for (String y : recentUser) {
				recentCustomer.add(userService.findByIdAndRole(y, "user"));
			}
			model.addAttribute("Total_Order", listOrder.size());
			model.addAttribute("Total_Product", listProduct.size());
			model.addAttribute("Total_User", listUser.size());
			model.addAttribute("Total_Category", listCategory.size());
			model.addAttribute("recentOrders", recentOrders);
			model.addAttribute("recentCustomer", recentCustomer);
			System.out.println(recentCustomer);
			return "dashboard";
		}
	}

	@GetMapping("/dashboard-invoice/{id}")
	public String InvoiceView(@PathVariable int id, Model model, HttpServletRequest request) {
		Order order = orderService.findById(id);
		List<Order_Item> listOrder_Item = order_ItemService.getAllByOrder_Id(order.getId());
		List<String> list = new ArrayList<>();
		list.add("Cho xu ly");
		list.add("Chuan bi hang");
		list.add("Da roi kho");
		list.add("Giao hang thanh cong");
		model.addAttribute("listOrder_Item", listOrder_Item);
		model.addAttribute("order", order);
		model.addAttribute("listStatus", list);
		return "dashboard-invoice";
	}

	@GetMapping("/dashboard-invoice/update/{id}")
	public String updateInvoice(@PathVariable("id") Integer id, @ModelAttribute("statusOrderABC")  String status){
		User admin = (User) session.getAttribute("admin");
		if (admin == null) {
			return "redirect:/signin-admin";
		} else {
			Order order = orderService.findById(1);
			System.out.println(status);
			System.out.println("hello");
			order.setStatus(status);
			orderService.saveOrder(order);
			return "redirect:/dashboard-orders";
		}

	}


	@GetMapping("/dashboard-orders")
	public String DashboardOrderView(Model model) {
		User admin = (User) session.getAttribute("admin");
		if (admin == null) {
			return "redirect:/signin-admin";
		} else {
			Pageable pageable = PageRequest.of(0, 3);
			Page<Order> pageOrder = orderService.findAll(pageable);
			model.addAttribute("pageOrder", pageOrder);
			return "dashboard-orders";
		}
	}

	@GetMapping("/dashboard-orders/{page}")
	public String DashboardOrderPageView(@PathVariable int page, Model model) {
		User admin = (User) session.getAttribute("admin");
		if (admin == null) {
			return "redirect:/signin-admin";
		} else {
			Pageable pageable = PageRequest.of(page, 3);
			Page<Order> pageOrder = orderService.findAll(pageable);
			model.addAttribute("pageOrder", pageOrder);
			return "dashboard-orders";
		}
	}

	@PostMapping("/send-message")
	public String SendMessage(Model model, @ModelAttribute("message") String message,
							  @ModelAttribute("email") String email, HttpServletRequest request) throws Exception {
		String referer = request.getHeader("Referer");
		System.out.println(message);
		System.out.println(email);
		Mail mail = new Mail();
		mail.setMailFrom("haovo1512@gmail.com");
		mail.setMailTo(email);
		mail.setMailSubject("This is message from Male fashion.");
		mail.setMailContent(message);
		mailService.sendEmail(mail);
		return "redirect:" + referer;
	}

	@GetMapping("/delete-order/{id}")
	public String DeleteOrder(@PathVariable int id, Model model, HttpServletRequest request) throws Exception {
		User admin = (User) session.getAttribute("admin");
		if (admin == null) {
			return "redirect:/signin-admin";
		} else {
			String referer = request.getHeader("Referer");
			Order order = orderService.findById(id);
			System.out.println(order);
			if (order != null) {
				for (Order_Item y : order.getOrder_Item()) {
					order_ItemService.deleteById(y.getId());
				}
				orderService.deleteById(id);
			}
			return "redirect:" + referer;
		}
	}

	@GetMapping("dashboard-wallet")
	public String DashboardWalletView(Model model) {
		User admin = (User) session.getAttribute("admin");
		if (admin == null) {
			return "redirect:/signin-admin";
		} else {
			List<Order> listOrder = orderService.findAll();
			List<Order> listPaymentWithMomo = orderService.findAllByPayment_Method("Payment with momo");
			List<Order> listPaymentOnDelivery = orderService.findAllByPayment_Method("Payment on delivery");
			int TotalMomo = 0;
			int TotalDelivery = 0;
			for (Order y : listPaymentWithMomo) {
				TotalMomo = TotalMomo + y.getTotal();
			}
			for (Order y : listPaymentOnDelivery) {
				TotalDelivery = TotalDelivery + y.getTotal();
			}
			List<Order> listRecentMomo = orderService.findTop5OrderByPaymentMethod("Payment with momo");
			List<Order> listRecentDelivery = orderService.findTop5OrderByPaymentMethod("Payment on delivery");

			model.addAttribute("TotalMomo", TotalMomo);
			model.addAttribute("TotalDelivery", TotalDelivery);
			model.addAttribute("TotalOrder", listOrder.size());
			model.addAttribute("listRecentDelivery", listRecentDelivery);
			model.addAttribute("listRecentMomo", listRecentMomo);
			return "dashboard-wallet";
		}
	}

	@GetMapping("dashboard-myproducts")
	public String DashboardMyProductView(Model model) {
		User admin = (User) session.getAttribute("admin");
		if (admin == null) {
			return "redirect:/signin-admin";
		} else {
			List<Category> listCategories = categoryService.findAll();
			Pageable pageable = PageRequest.of(0, 3);
			Page<Product> pageProduct = productService.findAll(pageable);
			model.addAttribute("pageProduct", pageProduct);
			model.addAttribute("listCategories", listCategories);
			return "dashboard-myproducts";
		}
	}

	@GetMapping("/dashboard-myproducts/edit/{id}")
	public String DashboardMyProductEditView(@PathVariable int id, Model model) {
		User admin = (User) session.getAttribute("admin");
		if (admin == null) {
			return "redirect:/signin-admin";
		} else {
			List<Category> listCategories = categoryService.findAll();
			Product product = productService.getProductById(id);
			model.addAttribute("product", product);
			model.addAttribute("listCategories", listCategories);
			String editProduct = (String) session.getAttribute("editProduct");
			model.addAttribute("editProduct", editProduct);
			session.setAttribute("editProduct", null);
			return "dashboard-my-products-edit";
		}
	}

	@PostMapping("/dashboard-myproducts/edit")
	public String DashboardMyProductEditHandel(Model model, @ModelAttribute("product_id") int product_id,
											   @ModelAttribute("product_name") String product_name, @ModelAttribute("price") String price,
											   @ModelAttribute("availability") String availability, @ModelAttribute("category") int category,
											   @ModelAttribute("description") String description, @ModelAttribute("listImage") MultipartFile[] listImage)
			throws Exception {
		User admin = (User) session.getAttribute("admin");
		if (admin == null) {
			return "redirect:/signin-admin";
		} else {
			if (listImage != null) {
				Category cate = categoryService.getCategoryById(category);
				Product product = productService.getProductById(product_id);
//				System.out.println(cate);
//				long millis = System.currentTimeMillis();
//				Date create_at = new java.sql.Date(millis);
//				Product newPro = new Product();
				product.setProduct_Name(product_name);
				product.setPrice(Integer.parseInt(price));
				product.setQuantity(Integer.parseInt(availability));
				product.setCategory(cate);
				product.setDescription(description);
				productService.saveProduct(product);
				for (MultipartFile y : listImage) {
					if (!y.isEmpty()) {
						String urlImg = cloudinaryService.uploadFile(y);
						ProductImage img = new ProductImage();
						img.setProduct(product);
						img.setUrl_Image(urlImg);
						productImageService.save(img);
					}
				}
				session.setAttribute("editProduct", "editProductSuccess");
				return "redirect:/dashboard-myproducts/edit/" + product_id;
			} else {
				return "redirect:/dashboard-myproducts/edit/" + product_id;
			}

		}
	}

	@GetMapping("/dashboard-myproducts/delete-image/{id}")
	public String DeleteImage(@PathVariable int id, HttpServletRequest request) {
		String referer = request.getHeader("Referer");
		productImageService.deleteById(id);

		return "redirect:"+referer;
	}

	@GetMapping("/dashboard-myproducts/delete/{id}")
	public String DeleteMyProducts(@PathVariable int id, Model model, HttpServletRequest request) throws Exception {
		User admin = (User) session.getAttribute("admin");
		if (admin == null) {
			return "redirect:/dashboard-myproducts";
		} else {
			String referer = request.getHeader("Referer");
			productImageService.deleteAllByProductId(id);
			productService.deleteProductById(id);


			return "redirect:" + referer;
		}


	}

	@GetMapping("dashboard-myproducts/{page}")
	public String DashboardMyProductPageView(@PathVariable int page, Model model) {
		User admin = (User) session.getAttribute("admin");
		if (admin == null) {
			return "redirect:/signin-admin";
		} else {
			List<Category> listCategories = categoryService.findAll();
			Pageable pageable = PageRequest.of(page, 3);
			Page<Product> pageProduct = productService.findAll(pageable);
			model.addAttribute("pageProduct", pageProduct);
			model.addAttribute("listCategories", listCategories);
			return "dashboard-myproducts";
		}
	}

	@PostMapping("/dashboard-myproduct/search")
	public String DashboardMyproductSearch(@ModelAttribute("search-input") String search_input, Model model) {
		User admin = (User) session.getAttribute("admin");
		if (admin == null) {
			return "redirect:/signin-admin";
		} else {
			Page<Product> pageProduct = null;
			Pageable pageable = PageRequest.of(0, 3);

			// Thực hiện tìm kiếm sản phẩm theo tên
			if (search_input != null && !search_input.isEmpty()) {
				pageProduct = productService.findByProduct_NameContaining(search_input, pageable);
			}
			if (search_input == null || search_input.isEmpty()) {
				session.setAttribute("err_not_input", "Bạn chưa nhập vào ô tìm kiếm!");
				return "dashboard";
			}

			model.addAttribute("pageProduct", pageProduct);
			model.addAttribute("search_dashboard", "search_dashboard");
			model.addAttribute("search_input", search_input);
			session.setAttribute("search_input_dashboard", search_input);
			return "dashboard-myproducts";
		}}

	@GetMapping("/dashboard-myproduct/search/{page}")
	public String DashboardMyproductSearchPage(@PathVariable int page, Model model) {
		User admin = (User) session.getAttribute("admin");
		if (admin == null) {
			return "redirect:/signin-admin";
		} else {
			String search_input = (String) session.getAttribute("search_input_dashboard");
			int category_selected = (int) session.getAttribute("category_selected");
//			int category_selected = 0;
			Page<Product> pageProduct = null;
			Pageable pageable = PageRequest.of(page, 3);
			if (category_selected > 0) {
				pageProduct = productService.findByProduct_NameAndCategory_idContaining(search_input, category_selected,
						pageable);
			} else {
				pageProduct = productService.findByProduct_NameContaining(search_input, pageable);
			}
			List<Category> listCategories = categoryService.findAll();
			model.addAttribute("pageProduct", pageProduct);
			model.addAttribute("listCategories", listCategories);
			model.addAttribute("search_dashboard", "search_dashboard");
			model.addAttribute("search_input", search_input);
			model.addAttribute("category_selected", category_selected);
			session.setAttribute("search_input_dashboard", search_input);
			return "dashboard-myproducts";
		}
	}

	@GetMapping("dashboard-addproduct")
	public String DashboardAddProductView(Model model) {
		User admin = (User) session.getAttribute("admin");
		if (admin == null) {
			return "redirect:/signin-admin";
		} else {
			String addProduct = (String) session.getAttribute("addProduct");
			model.addAttribute("addProduct", addProduct);
			session.setAttribute("addProduct", null);
			List<Category> listCategories = categoryService.findAll();
			model.addAttribute("listCategories", listCategories);
			return "dashboard-addproduct";
		}
	}


	@PostMapping("dashboard-addproduct")
	public String DashboardAddProductHandel(Model model, @ModelAttribute("product_name") String product_name,
											@ModelAttribute("price") String price, @ModelAttribute("availability") String availability,
											@ModelAttribute("category") int category, @ModelAttribute("description") String description,
											@ModelAttribute("listImage") MultipartFile[] listImage) throws Exception {
		User admin = (User) session.getAttribute("admin");
		if (admin == null) {
			return "redirect:/signin-admin";
		} else {
			if (listImage != null) {
				Category cate = categoryService.getCategoryById(category);
				System.out.println(cate);
				long millis = System.currentTimeMillis();
				Date create_at = new java.sql.Date(millis);
				Product newPro = new Product();
				newPro.setCreated_At(create_at);
				newPro.setDescription(description);
				newPro.setIs_Active(1);
				newPro.setIs_Selling(1);
				newPro.setPrice(Integer.parseInt(price));
				newPro.setProduct_Name(product_name);
				newPro.setQuantity(Integer.parseInt(availability));
				newPro.setSold(0);
				newPro.setCategory(cate);
				productService.saveProduct(newPro);
				List<Product> listProducts = productService.getAllProduct();
				newPro = listProducts.get(listProducts.size() - 1);
				for (MultipartFile y : listImage) {
					String urlImg = cloudinaryService.uploadFile(y);
					ProductImage img = new ProductImage();
					img.setProduct(newPro);
					img.setUrl_Image(urlImg);
					productImageService.save(img);
				}
				session.setAttribute("addProduct", "addProductSuccess");
				return "redirect:/dashboard-addproduct";
			} else {
				return "redirect:/dashboard-addproduct";
			}

		}
	}

	@GetMapping("dashboard-myprofile")
	public String DashboardMyProfile(Model model) {
		User admin = (User) session.getAttribute("admin");
		if (admin == null) {
			return "redirect:/signin-admin";
		} else {
			String error_change_pass = (String) session.getAttribute("error_change_pass");
			String ChangePassSuccess = (String) session.getAttribute("ChangePassSuccess");
			String messageChangeProfile = (String) session.getAttribute("messageChangeProfile");
			model.addAttribute("messageChangeProfile", messageChangeProfile);
			model.addAttribute("error_change_pass", error_change_pass);
			model.addAttribute("ChangePassSuccess", ChangePassSuccess);
			session.setAttribute("error_change_pass", null);
			session.setAttribute("ChangePassSuccess", null);
			session.setAttribute("messageChangeProfile", null);
			model.addAttribute("admin", admin);
			return "dashboard-my-profile";
		}
	}

	@PostMapping("/dashboard-myprofile/changepassword")
	public String DashboardChangePassword(Model model, @ModelAttribute("current_password") String current_password,
										  @ModelAttribute("new_password") String new_password,
										  @ModelAttribute("confirm_password") String confirm_password, HttpServletRequest request) {
		String referer = request.getHeader("Referer");
		User admin = (User) session.getAttribute("admin");
		if (admin == null) {
			return "redirect:/signin-admin";
		} else {
			String decodedValue = new String(Base64.getDecoder().decode(admin.getPassword()));
			if (!decodedValue.equals(current_password)) {
				session.setAttribute("error_change_pass", "Current Password not correct!");
				return "redirect:/dashboard-myprofile";
			} else {

				if (!new_password.equals(confirm_password)) {
					session.setAttribute("error_change_pass", "Confirm New Password not valid!");
					return "redirect:/dashboard-myprofile";
				} else {
					String encodedValue = Base64.getEncoder().encodeToString(new_password.getBytes());
					admin.setPassword(encodedValue);
					userService.saveUser(admin);
					session.setAttribute("admin", admin);
				}
			}
			session.setAttribute("ChangePassSuccess", "ChangePassSuccess");
			return "redirect:" + referer;
		}
	}

	@PostMapping("/dashboard-myprofile/changeProfile")
	public String ChangeProfile(Model model, @ModelAttribute("avatar") MultipartFile avatar,
								@ModelAttribute("fullname") String fullname, @ModelAttribute("phone") String phone,
								@ModelAttribute("email") String email) throws IOException {
		User admin = (User) session.getAttribute("admin");
		if (admin == null) {
			return "redirect:/signin-admin";
		} else {
			if (!avatar.isEmpty()) {
				String url = cloudinaryService.uploadFile(avatar);
				admin.setAvatar(url);
			}
			admin.setUser_Name(fullname);
			admin.setEmail(email);
			admin.setPhone_Number(phone);
			userService.saveUser(admin);
			session.setAttribute("admin", admin);
			session.setAttribute("messageChangeProfile", "Change Success.");
			return "redirect:/dashboard-myprofile";
		}
	}

	@GetMapping("/dashboard-user")
	public String usersPage(Model model){
		model.addAttribute("users",userService.findAll());
		return "/dashboard-user";
	}

	@GetMapping("/admins/users/edit/{id}")
	public String showEditFormUser(@PathVariable("id") String id, Model model){
		try {
			User user = userService.findById(id);
			model.addAttribute("user",user);
			model.addAttribute("pageTitle","Edit User (ID: "+ id+")");
//			List<Role> list = (List<Role>) roleRepository.findAll();
//			model.addAttribute("roles",list);
//			for (UserRole ur : userRolesRepository.findAll()) {
//				if (ur.getUser().getId().equals(id)){
//					model.addAttribute("roleID", ur.getRole().getRoleId());
//				}
//			}
		}catch (Exception e){
			e.printStackTrace();
		}
		return "dashboard-user-edit";
	}
	@PostMapping("/dashboard-user-edit/save")
	public String showNewForm( User userCurrent){
		User user = new User();
		user.setId(userCurrent.getId());
		user.setUser_Name(userCurrent.getUser_Name());
		user.setEmail(userCurrent.getEmail());

		user.setPhone_Number(userCurrent.getPhone_Number());

		if(!userCurrent.getPassword().isEmpty() || userCurrent.getPassword() != null){
			String encryptedPassword = Base64.getEncoder().encodeToString(userCurrent.getPassword().getBytes());
			user.setPassword(encryptedPassword);
		}
		else {
			user.setPassword(userCurrent.getPassword());
		}
//		for (UserRole ur : userRolesRepository.findAll()) {
//			if (ur.getUser().getId().equals(userCurrent.getId())){
//				Role role = roleRepository.findById(id).orElse(new Role());
//				ur.setRole(role);
//				userRolesRepository.save(ur);
//			}
//		}
		userService.saveUser(user);
		return "redirect:/admins/users";
	}
	@GetMapping("/admins/users/delete/{id}")
	public String deleteUserPage(@PathVariable("id") String id, RedirectAttributes ra, Model model, Principal principal){
		try {
			if(Objects.equals(principal.getName(), userService.findById(id).getUser_Name())){
				ra.addFlashAttribute("message","Delete user ID:"+id+" failure. Don't delete yourself.");
			}else {
				userService.deleteUserById(id);
//				for (UserRole ur : userRolesRepository.findAll()) {
//					if(Objects.equals(ur.getUser().getId(), id)){
//						userRolesRepository.delete(ur);
//					}
//				}
				ra.addFlashAttribute("message","Delete user ID:"+id+" successfully");
			}
		}catch (Exception e){
			ra.addFlashAttribute("message", e.getMessage());
		}
		return "redirect:/admins/users";
	}


}
