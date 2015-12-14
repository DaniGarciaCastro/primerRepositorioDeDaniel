package eshop;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import eshop.beans.Book;
import eshop.beans.CartItem;
import eshop.beans.Customer;
import eshop.model.DataManager;

import java.util.ArrayList;
import java.util.Hashtable;

public class ShopServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
	private static final long serialVersionUID = 1L;

	public ShopServlet() {
		super();
	}

	public void init(ServletConfig config) throws ServletException {
		System.out.println("*** initializing controller servlet.");
		super.init(config);

		DataManager dataManager = new DataManager();
		dataManager.setDbURL(config.getInitParameter("dbURL"));
		dataManager.setDbUserName(config.getInitParameter("dbUserName"));
		dataManager.setDbPassword(config.getInitParameter("dbPassword"));

		ServletContext context = config.getServletContext();
		context.setAttribute("base", config.getInitParameter("base"));
		context.setAttribute("imageURL", config.getInitParameter("imageURL"));
		context.setAttribute("dataManager", dataManager);

		try { // load the database JDBC driver
			Class.forName(config.getInitParameter("jdbcDriver"));
		} catch (ClassNotFoundException e) {
			System.out.println(e.toString());
		}
	}

	protected void addItem(HttpServletRequest request, DataManager dm) {
		HttpSession session = request.getSession(true);
		Hashtable<String, CartItem> shoppingCart = (Hashtable<String, CartItem>) session.getAttribute("carrito");
		if (shoppingCart == null) {
			shoppingCart = new Hashtable<String, CartItem>(10);
		}
		try {
			String bookId = request.getParameter("bookId");
			Book book = dm.getBookDetails(bookId);
			if (book != null) {
				CartItem item = new CartItem(book, 1);
				shoppingCart.remove(bookId);
				shoppingCart.put(bookId, item);
				session.setAttribute("carrito", shoppingCart);
			}
		} catch (Exception e) {
			System.out.println("Error adding the selected book to the shopping cart!");
		}
		// }
	}

	protected void updateItem(HttpServletRequest request) {
		HttpSession session = request.getSession(true);
		Hashtable<String, CartItem> shoppingCart = (Hashtable<String, CartItem>) session.getAttribute("carrito");
		String bookId = request.getParameter("bookId");
		String cantidad = request.getParameter("quantity");
		CartItem book = shoppingCart.get(bookId);
		try {
			if (Integer.parseInt(cantidad) > 0) {
				book.setQuantity(Integer.parseInt(cantidad));
				shoppingCart.put(bookId, book);
			}
		} catch (NumberFormatException e) {

		}

	}

	protected void deleteItem(HttpServletRequest request) {
		HttpSession session = request.getSession(true);
		Hashtable<String, CartItem> shoppingCart = (Hashtable<String, CartItem>) session.getAttribute("carrito");
		String bookId = request.getParameter("bookId");
		shoppingCart.remove(bookId);
	}

	private void orderConfirmation(HttpServletRequest request, DataManager datamanager) {
		HttpSession session = request.getSession(true);
		Customer customer = new Customer();
		Hashtable<String, CartItem> cart = (Hashtable<String, CartItem>) session.getAttribute("carrito");
		customer.setCcExpiryDate(request.getParameter("ccExpiryDate"));
		customer.setCcName(request.getParameter("ccName"));
		customer.setCcNumber(request.getParameter("ccNumber"));
		customer.setContactName(request.getParameter("contactName"));
		customer.setDeliveryAddress(request.getParameter("deliveryAddress"));
		long orderId = datamanager.insertOrder(customer, cart);
		request.setAttribute("orderId", orderId);
		if (orderId > 0L)
			session.invalidate();

	}

	private void librosEnCategoria(HttpServletRequest request, DataManager datamanager) {
		String categoryId = request.getParameter("id");
		String categoryName = datamanager.getCategoryName(categoryId);
		request.setAttribute("categoryName", categoryName);
		request.setAttribute("books", datamanager.getBooksInCategory(categoryId));
	}

	private void detallesLibro(HttpServletRequest request, DataManager datamanager) {
		String bookId = request.getParameter("bookId");
		Book book = datamanager.getBookDetails(bookId);
		request.setAttribute("book", book);
	}

	private void librosEncontrados(HttpServletRequest request, DataManager datamanager) {
		String keyword = request.getParameter("keyword");
		ArrayList<Book> searchBooks = datamanager.getSearchResults(keyword);
		request.setAttribute("keyword", keyword);
		request.setAttribute("searchBooks", searchBooks);
	}

	private boolean validarLogin(HttpServletRequest request, DataManager datamanager) {
		return datamanager.validaLogin(request, datamanager);
	}
	
	private void buscarPedido(HttpServletRequest request, DataManager datamanager) {
		ArrayList<CartItem> librosPedido = DataManager.pedidoLibros(request, datamanager);
		request.setAttribute("librosPedido", librosPedido);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String base = "/jsp/";
		String url = base + "Login.jsp";
		String action = request.getParameter("action");
		// recuperar datamanager del contexto
		DataManager datamanager = (DataManager) request.getServletContext().getAttribute("dataManager");
		request.setAttribute("categorias", datamanager.getCategories());
		HttpSession sesion = request.getSession(true);
		if (action != null) {
			switch (action) {
			case "search":
				librosEncontrados(request, datamanager);
				url = base + "SearchOutcome.jsp";
				break;
			case "searchOrder":
				buscarPedido(request, datamanager);
				url = base + "indexA.jsp";
				break;
			case "home":
				
				if(sesion.getAttribute("user").equals("admin")) {
					url = base + "indexA.jsp";
				} else {
					url = base + "indexU.jsp";
				}
				break;
			case "selectCatalog":
				librosEnCategoria(request, datamanager);
				url = base + "SelectCatalog.jsp";
				break;
			case "bookDetails":
				detallesLibro(request, datamanager);
				url = base + "BookDetails.jsp";
				break;
			case "checkOut":
				url = base + "Checkout.jsp";
				break;
			case "orderConfirmation":
				orderConfirmation(request, datamanager);
				url = base + "OrderConfirmation.jsp";
				break;
			case "addItem":
				addItem(request, datamanager);
				url = base + "ShoppingCart.jsp";
				break;
			case "updateItem":
				updateItem(request);
				url = base + "ShoppingCart.jsp";
				break;
			case "deleteItem":
				deleteItem(request);
				url = base + "ShoppingCart.jsp";
				break;
			case "showCart":
				url = base + "ShoppingCart.jsp";
				break;
			case "log":
				// System.out.println("Estoy dentro");
				//url = base;
				//url +=  validarLogin(request, datamanager)?"indexA.jsp":"Login.jsp";
				String usuario = request.getParameter("user");
				sesion = request.getSession(true);
				sesion.setAttribute("user", usuario);
				if (validarLogin(request, datamanager) == true) {
					System.out.println("Entro!");
					if (request.getParameter("user").equals("admin")) {
						url = base + "indexA.jsp";
					} else {	
						url = base + "indexU.jsp";
					}
				}
				break;
			}
		}
		RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher(url);
		requestDispatcher.forward(request, response);
	}
}
