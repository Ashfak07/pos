// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductListModelAdapter extends TypeAdapter<ProductListModel> {
  @override
  final int typeId = 2;

  @override
  ProductListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductListModel(
      image: fields[0] as Uint8List,
      pname: fields[1] as String,
      qty: fields[2] as String,
      itemcode: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductListModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.pname)
      ..writeByte(2)
      ..write(obj.qty)
      ..writeByte(3)
      ..write(obj.itemcode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
