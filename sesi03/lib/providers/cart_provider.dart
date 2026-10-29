
import 'package:flutter/foundation.dart';

import '../models/book.dart';

class CartItem {
  final Book book;
  int quantity;

  CartItem({
    required this.book,
    this.quantity = 1,
  });

  int get subtotal => book.price * quantity;
}

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => Map.unmodifiable(_items);

  int get totalItems {
    return _items.values.fold(
      0,
      (total, item) => total + item.quantity,
    );
  }

  int get totalPrice {
    return _items.values.fold(
      0,
      (total, item) => total + item.subtotal,
    );
  }

  void addItem(Book book) {
    if (_items.containsKey(book.id)) {
      _items[book.id]!.quantity++;
    } else {
      _items[book.id] = CartItem(book: book);
    }

    notifyListeners();
  }

  void removeItem(String bookId) {
    final item = _items[bookId];

    if (item == null) return;

    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _items.remove(bookId);
    }

    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
