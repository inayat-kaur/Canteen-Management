// For running in Phone Use ipconfig and paste ipv4 wifi ip address instead of localhost
String baseUrl = 'https://canteenmanagementserver.onrender.com/';
//String baseUrl = 'http://localhost:3000/';
Uri addMenuItem = Uri.parse('${baseUrl}menu/addItem/');
Uri deleteMenuItem(String id) => Uri.parse('${baseUrl}menu/deleteItem/$id');
Uri updateItemPrice(String id) => Uri.parse('${baseUrl}menu/updatePrice/$id');
Uri updateItemAvailability(String id) =>
    Uri.parse('${baseUrl}menu/updateAvailability/$id');
Uri updateItemRating(String id) => Uri.parse('${baseUrl}menu/updateRating/$id');
Uri getMenu = Uri.parse('${baseUrl}menu/getMenu/');
Uri getCategories = Uri.parse('${baseUrl}menu/getCategories/');

Uri addOrder = Uri.parse('${baseUrl}orders/addOrder/');
Uri deleteOrder(String id, String item) =>
    Uri.parse('${baseUrl}orders/deleteOrder/$id/$item');
Uri updateOrderStatus(String id, String item) =>
    Uri.parse('${baseUrl}orders/updateOrderStatus/$id/$item');
Uri updatePaymentStatus(String id, String item) =>
    Uri.parse('${baseUrl}orders/updatePaymentStatus/$id/$item');
Uri getOrders = Uri.parse('${baseUrl}orders/getOrders/');
Uri getOrdersByUser(String id) =>
    Uri.parse('${baseUrl}orders/getOrdersByUser/$id');
Uri getOrdersByStatus(String status) =>
    Uri.parse('${baseUrl}orders/getOrdersByStatus/$status');

Uri updateUserPhone = Uri.parse('${baseUrl}users/updatePhone/');
Uri updateUserName = Uri.parse('${baseUrl}users/updateName/');
Uri getUserProfile = Uri.parse('${baseUrl}users/getProfile/');

Uri signUp = Uri.parse('${baseUrl}auth/signUp/');
Uri login = Uri.parse('${baseUrl}auth/login/');
Uri mailOTP = Uri.parse('${baseUrl}auth/mailOTP/');
Uri resetPassword1 = Uri.parse('${baseUrl}auth/resetPassword1');
Uri resetPassword2 = Uri.parse('${baseUrl}auth/resetPassword2');

Uri addCartItem = Uri.parse('${baseUrl}cart/addItem');
Uri deleteCartItem(String id) => Uri.parse('${baseUrl}cart/deleteItem/$id');
Uri emptyCart = Uri.parse('${baseUrl}cart/deleteAllItems');
Uri getMyCart = Uri.parse('${baseUrl}cart/getMyCart/');
Uri updateCartItemQuantity(String id) =>
    Uri.parse('${baseUrl}cart/updateQuantity/$id');
