Uri addMenuItem = Uri.parse('http://localhost:8000/menu/addItem/');
Uri deleteMenuItem(String id) =>
    Uri.parse('http://localhost:8000/menu/deleteItem/$id');
Uri updateItemPrice(String id) =>
    Uri.parse('http://localhost:8000/menu/updatePrice/$id');
Uri updateItemAvailability(String id) =>
    Uri.parse('http://localhost:8000/menu/updateAvailability/$id');
Uri updateItemRating(String id) =>
    Uri.parse('http://localhost:8000/menu/updateRating/$id');
Uri getMenu = Uri.parse('http://localhost:8000/menu/getMenu/');

Uri addOrder = Uri.parse('http://localhost:8000/orders/addOrder/');
Uri deleteOrder(int id, String item) =>
    Uri.parse('http://localhost:8000/orders/deleteOrder/$id/$item');
Uri updateOrderStatus(int id, String item) =>
    Uri.parse('http://localhost:8000/orders/updateOrderStatus/$id/$item');
Uri updatePaymentStatus(int id, String item) =>
    Uri.parse('http://localhost:8000/orders/updatePaymentStatus/$id/$item');
Uri getOrders = Uri.parse('http://localhost:8000/orders/getOrders/');
Uri getOrdersByUser(String id) =>
    Uri.parse('http://localhost:8000/orders/deleteOrder/$id');
Uri getOrdersByStatus(String status) =>
    Uri.parse('http://localhost:8000/orders/getOrdersByStatus/$status');

Uri updateUserPhone(String id) =>
    Uri.parse('http://localhost:8000/users/updatePhone/$id');
Uri updateUserName(String id) =>
    Uri.parse('http://localhost:8000/users/updateName/$id');
Uri getUserProfile(String id) =>
    Uri.parse('http://localhost:8000/users/getProfile/$id');

Uri signUp = Uri.parse('http://localhost:8000/auth/signUp/');
Uri login = Uri.parse('http://localhost:8000/auth/login/');

Uri addCartItem = Uri.parse('http://localhost:8000/cart/addItem');
Uri deleteCartItem(String id) =>
    Uri.parse('http://localhost:8000/cart/deleteItem/$id');
