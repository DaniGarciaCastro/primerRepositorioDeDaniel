package eshop.model;

import java.util.Hashtable;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Enumeration;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import eshop.beans.Category;
import eshop.beans.Book;
import eshop.beans.Customer;
import eshop.beans.CartItem;

public class DataManager {
	private String dbURL = "";
	private String dbUserName = "";
	private String dbPassword = "";

	public void setDbURL(String dbURL) {
		this.dbURL = dbURL;
	}

	public String getDbURL() {
		return dbURL;
	}

	public void setDbUserName(String dbUserName) {
		this.dbUserName = dbUserName;
	}

	public String getDbUserName() {
		return dbUserName;
	}

	public void setDbPassword(String dbPassword) {
		this.dbPassword = dbPassword;
	}

	public String getDbPassword() {
		return dbPassword;
	}

	public Connection getConnection() {
		Connection conn = null;
		try {
			conn = DriverManager.getConnection(getDbURL(), getDbUserName(), getDbPassword());
		} catch (SQLException e) {
			System.out.println("Could not connect to DB: " + e.getMessage());
		}
		return conn;
	}

	public void putConnection(Connection conn) {
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
			}
		}
	}
	
	

	// ---------- Category operations ----------
	public String getCategoryName(String categoryID) {
		Category category = CategoryPeer.getCategoryById(this, categoryID);
		return (category == null) ? null : category.getName();
	}

	public Hashtable<String, String> getCategories() {
		return CategoryPeer.getAllCategories(this);
	}

	public Enumeration<String> getCatIDs() {
		return CategoryPeer.getAllCategories(this).keys();
	}

	// ---------- Book operations ----------
	public ArrayList<Book> getSearchResults(String keyword) {
		return BookPeer.searchBooks(this, keyword);
	}

	public ArrayList<Book> getBooksInCategory(String categoryID) {
		return BookPeer.getBooksByCategory(this, categoryID);
	}

	public Book getBookDetails(String bookID) {
		return BookPeer.getBookById(this, bookID);
	}
	
	public boolean validaLogin(HttpServletRequest request, DataManager datamanager){
		Connection connection = datamanager.getConnection();
		String user = request.getParameter("user");
		String pass = request.getParameter("psw");
		if (connection != null) {
		      try {
		        Statement s = connection.createStatement();
		        String sql = "SELECT usuario , clave from usuarios WHERE usuario ='"
		        + user + "' AND + clave ='"+ pass +"';";
		        try {
		            ResultSet rs = s.executeQuery(sql);
		            try {             
		            	  return rs.isBeforeFirst();         
		              }
		            finally { rs.close(); }
		            }
		          finally { s.close(); }
		          }
		      catch (SQLException ignore){
		        	
		        }
		      }
		return false;
		}


	// ---------- Order operations ----------
	public long insertOrder(Customer customer, Hashtable<String, CartItem> shoppingCart) {
		long returnValue = 0L;
		long orderId = System.currentTimeMillis();
		Connection connection = getConnection();
		if (connection != null) {
			Statement stmt = null;
			try {
				connection.setAutoCommit(false);
				stmt = connection.createStatement();
				try {
					OrderPeer.insertOrder(stmt, orderId, customer);
					OrderDetailsPeer.insertOrderDetails(stmt, orderId, shoppingCart);
					try {
						stmt.close();
					} finally {
						stmt = null;
					}
					connection.commit();
					returnValue = orderId;
				} catch (SQLException e) {
					System.out.println("Could not insert order: " + e.getMessage());
					try {
						connection.rollback();
					} catch (SQLException ee) {
					}
				}
			} catch (SQLException e) {
				System.out.println("Could not insert order: " + e.getMessage());
			} finally {
				if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
					}
				}
				putConnection(connection);
			}
		}
		return returnValue;
	}
	
	public static ArrayList<CartItem> pedidoLibros(HttpServletRequest request, DataManager dataManager) {
		String pedidoId = request.getParameter("pedido");
		    ArrayList<CartItem> books = new ArrayList<CartItem>();
		    Connection connection = dataManager.getConnection();
		    if (connection != null) {
		      try {
		        Statement s = connection.createStatement();
		        String sql = "SELECT book_id, title, author, quantity, price FROM order_details WHERE order_id='" + pedidoId +"'";
		        try {
		          ResultSet rs = s.executeQuery(sql);
		          try {
		            while (rs.next()) {
		              Book book = new Book();
		              int cantidad;
		              book.setId(rs.getString(1));
		              book.setTitle(rs.getString(2));
		              book.setAuthor(rs.getString(3));
		              cantidad = Integer.parseInt(rs.getString(4));
		              book.setPrice(rs.getDouble(5));
		              CartItem libro = new CartItem(book,cantidad);
		              books.add(libro);
		              
		              }
		            }
		          finally { rs.close(); }
		          }
		        finally { s.close(); }
		        }
		      catch (SQLException e) {
		        System.out.println("Could not get books: " + e.getMessage());
		        }
		      finally {
		        dataManager.putConnection(connection);
		        }
		      }
		    return books;
		    }
}
