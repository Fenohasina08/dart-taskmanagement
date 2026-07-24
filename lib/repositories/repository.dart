abstract interface class Repository<T> { 

  T create(T item);  

  List<T> readAll(); 

  T? readById(String id);  

  void update(String id, T item); 

  void delete(String id);  
}