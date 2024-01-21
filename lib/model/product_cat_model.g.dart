// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_cat_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductCatModelAdapter extends TypeAdapter<ProductCatModel> {
  @override
  final int typeId = 1;

  @override
  ProductCatModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductCatModel(
      image: fields[0] as Uint8List,
      pname: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductCatModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.pname);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductCatModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
