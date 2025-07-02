import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting dates

class Product {
  final int id;
  final String name;
  final String category;
  final String brand;
  final double price;
  final int stock;
  final bool featured;
  final DateTime createdAt;
  bool isSelected;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.brand,
    required this.price,
    required this.stock,
    required this.featured,
    required this.createdAt,
    this.isSelected = false,
  });
}


class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late List<Product> products;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();

    // Dummy product list
    products = List.generate(20, (index) {
      return Product(
        id: index + 1,
        name: 'Product ${String.fromCharCode(65 + (index % 26))}$index',
        category: ['Electronics', 'Clothing', 'Books'][index % 3],
        brand: ['Apple', 'Samsung', 'Nike'][index % 3],
        price: (index + 1) * 10.0,
        stock: 10 + (index * 3),
        featured: index % 2 == 0,
        createdAt: DateTime.now().subtract(Duration(days: index * 2)),
      );
    });

  }

  void _sort<T>(
    Comparable<T> Function(Product p) getField,
    int columnIndex,
    bool ascending,
  ) {
    products.sort((a, b) {
      final aVal = getField(a);
      final bVal = getField(b);
      return ascending
          ? Comparable.compare(aVal, bVal)
          : Comparable.compare(bVal, aVal);
    });
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    final productDataSource = ProductDataSource(
      products,
      onSelectChanged: (index, value) {
        setState(() {
          products[index].isSelected = value ?? false;
        });
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        backgroundColor: Colors.black45,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to Add Product Page
          Navigator.pushNamed(context, '/dashboard/addproduct');
        },
        label: const Text('Add Product'),
        icon: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: PaginatedDataTable(
          header: const Text('Product List'),
          rowsPerPage: _rowsPerPage,
          onRowsPerPageChanged: (value) {
            if (value != null) {
              setState(() => _rowsPerPage = value);
            }
          },
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          columns: [
            DataColumn(label: const Text('Select')),
            DataColumn(
              label: const Text('Name'),
              onSort: (i, asc) => _sort((p) => p.name.toLowerCase(), i, asc),
            ),
            DataColumn(label: const Text('Category')),
            DataColumn(label: const Text('Brand')),
            DataColumn(label: const Text('Price')),
            DataColumn(label: const Text('Stock')),
            DataColumn(
              label: const Text('Created'),
              onSort: (i, asc) => _sort((p) => p.createdAt, i, asc),
            ),
            DataColumn(label: const Text('Featured')),
          ],

          source: productDataSource,
        ),
      ),
    );
  }
}

class ProductDataSource extends DataTableSource {
  final List<Product> products;
  final void Function(int index, bool? value) onSelectChanged;

  ProductDataSource(this.products, {required this.onSelectChanged});

  @override
  DataRow getRow(int index) {
    final product = products[index];
    return DataRow.byIndex(
      index: index,
      selected: product.isSelected,
      onSelectChanged: (value) => onSelectChanged(index, value),
      cells: [
        DataCell(
          Checkbox(
            value: product.isSelected,
            onChanged: (value) => onSelectChanged(index, value),
          ),
        ),
        DataCell(Text(product.name)),
        DataCell(Text(product.category)),
        DataCell(Text(product.brand)),
        DataCell(Text('\$${product.price.toStringAsFixed(2)}')),
        DataCell(Text('${product.stock}')),
        DataCell(Text(DateFormat.yMd().add_jm().format(product.createdAt))),
        DataCell(
          Icon(
            product.featured ? Icons.star : Icons.star_border,
            color: product.featured ? Colors.amber : Colors.grey,
          ),
        ),
      ],

    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => products.length;

  @override
  int get selectedRowCount => products.where((p) => p.isSelected).length;
}
