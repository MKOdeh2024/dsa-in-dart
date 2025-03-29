// linked_list.dart

class Node<T> {
  T value;
  Node<T>? next;

  Node(this.value, this.next);
}

class LinkedList<T> {
  Node<T>? _head;
  int _length = 0;

  // Basic List Operations

  void add(T value) {
    _head = Node<T>(value, _head);
    _length++;
  }

  void insert(int index, T value) {
    if (index < 0 || index > _length) {
      throw RangeError('Index out of range');
    }
    if (index == 0) {
      add(value);
    } else {
      Node<T> current = _head!;
      for (int i = 0; i < index - 1; i++) {
        current = current.next!;
      }
      current.next = Node<T>(value, current.next);
      _length++;
    }
  }

  T removeAt(int index) {
    if (index < 0 || index >= _length) {
      throw RangeError('Index out of range');
    }
    if (index == 0) {
      T value = _head!.value;
      _head = _head!.next;
      _length--;
      return value;
    } else {
      Node<T> current = _head!;
      for (int i = 0; i < index - 1; i++) {
        current = current.next!;
      }
      T value = current.next!.value;
      current.next = current.next!.next;
      _length--;
      return value;
    }
  }

  void clear() {
    _head = null;
    _length = 0;
  }

  int get length => _length;

  // Element Queries

  bool contains(T value) {
    Node<T>? current = _head;
    while (current != null) {
      if (current.value == value) {
        return true;
      }
      current = current.next;
    }
    return false;
  }

  int indexOf(T value) {
    Node<T>? current = _head;
    int index = 0;
    while (current != null) {
      if (current.value == value) {
        return index;
      }
      current = current.next;
      index++;
    }
    return -1;
  }

  // Additional

  void forEach(void Function(T) action) {
    Node<T>? current = _head;
    while (current != null) {
      action(current.value);
      current = current.next;
    }
  }

  LinkedList<S> map<S>(S Function(T) transform) {
    LinkedList<S> result = LinkedList<S>();
    Node<T>? current = _head;
    while (current != null) {
      result.add(transform(current.value));
      current = current.next;
    }
    return result;
  }

  LinkedList<T> where(bool Function(T) test) {
    LinkedList<T> result = LinkedList<T>();
    Node<T>? current = _head;
    while (current != null) {
      if (test(current.value)) {
        result.add(current.value);
      }
      current = current.next;
    }
    return result;
  }

  // Operator Overloading

  T operator [](int index) {
    if (index < 0 || index >= _length) {
      throw RangeError('Index out of range');
    }
    Node<T>? current = _head;
    for (int i = 0; i < index; i++) {
      current = current?.next!;
    }
    return current!.value;
  }

  void operator []=(int index, T value) {
    if (index < 0 || index >= _length) {
      throw RangeError('Index out of range');
    }
    Node<T>? current = _head;
    for (int i = 0; i < index; i++) {
      current = current?.next!;
    }
    current?.value = value;
  }

  LinkedList<T> operator +(LinkedList<T> other) {
    LinkedList<T> result = LinkedList<T>();
    Node<T>? current = _head;
    while (current != null) {
      result.add(current.value);
      current = current.next;
    }
    current = other._head;
    while (current != null) {
      result.add(current.value);
      current = current.next;
    }
    return result;
  }

  LinkedList<T> operator -(T value) {
    LinkedList<T> result = LinkedList<T>();
    Node<T>? current = _head;
    while (current != null) {
      if (current.value != value) {
        result.add(current.value);
      }
      current = current.next;
    }
    return result;
  }

  // Additional Methods (Optional)

  @override
  String toString() {
    List<String> elements = [];
    Node<T>? current = _head;
    while (current != null) {
      elements.add(current.value.toString());
      current = current.next;
    }
    return elements.join(' -> ');
  }
}

void main() {
  LinkedList<int> list = LinkedList<int>();
  list.add(1);
  list.add(2);
  list.add(3);
  list.add(4);
  list.add(5);
  print(list); // 5 -> 4 -> 3 -> 2 -> 1
  print(list.length); // 5
  print(list.contains(3)); // true
  print(list.indexOf(3)); // 2
  list.insert(2, 6);
  print(list); // 5 -> 4 -> 6 -> 3 -> 2 ->
  list.removeAt(2);
  print(list); // 5 -> 4 -> 3 -> 2 ->
  list.clear();
  print(list); // []
}
