//
// class LookUpCollection<TKey, TValue> {
//   final List<_KeyValue<TKey, TValue>> _array = [];
//   add(TKey key, TValue value) {
//     _array.add(_KeyValue(key, value));
//   }
//
//   Iterable<TValue> operator [](TKey key) =>
//       _array.where((element) => element.key == key).map((e) => e.value);
//
//   TValue? firstOrNull(bool Function(TValue element) predicat){
//     try{
//       var value = _array.map((e) => e.value)
//           .firstWhere(predicat);
//       return value;
//     } catch (ex){
//       return null;
//     }
//   }
//
//   int? findElementIndex(bool Function(TValue element) predicat){
//     var item = firstOrNull(predicat);
//     if(item == null) return null;
//     return _array.map((e) => e.value).toList().indexWhere(predicat);
//   }
//
//   void changeElement(int index, TValue newElement){
//     if(index == -1) return;
//     var oldElement = _array[index];
//     oldElement.value = newElement;
//   }
// }
//
// class _KeyValue<TKey, TValue> {
//   TKey key;
//   TValue value;
//   _KeyValue(this.key, this.value);
// }
