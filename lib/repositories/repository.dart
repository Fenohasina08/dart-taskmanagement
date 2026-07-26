abstract class Repository<T> { 

  T create(T item);  

  List<T> readAll(); 

  T? readById(String id);  

  void updateTask(String id, T item); 

  void deleteTask(String id);  
}