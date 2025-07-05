abstract class BaseRepository<T> {
  Future<T> get(String id);
  Future<List<T>> getAll();
  Future<T> create(T data);
  Future<T> update(String id, T data);
  Future<void> delete(String id);
}
