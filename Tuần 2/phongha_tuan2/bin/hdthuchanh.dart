import 'package:phongha_tuan2/SanPham.dart';
import 'package:file/src/io.dart';
import 'package:xml/xml.dart';

Future<List<SanPham>> readFile(String fileName) async {
  {
    List<SanPham> arrs = [];
    try {
      // Đọc file và lấy danh sách dòng
      List<String> lines = await File(fileName).readAsLines();
      for (String line in lines) {
        List<String> parts = line.split('#'); // Tách dữ liệu theo dấu #
        if (parts.length == 4) {
          String masp = parts[0].trim();
          String tensp = parts[1].trim();
          double giaban = double.parse(parts[2].trim());
          double giamgia = double.parse(parts[3].trim());
          arrs.add(SanPham.fullPara(masp, tensp, giaban, giamgia));
        }
      }
    } catch (e) {
      print('Lỗi khi đọc file: $e');
    }
    return arrs;
  }
}

Future<List<SanPham>> readFileXML(String filename) async {
  try {
    // Đọc nội dung file XML từ hệ thống
    final String xmlString = await File(filename).readAsString();
    // Phân tích dữ liệu XML
    final XmlDocument document = XmlDocument.parse(xmlString);
    // Lấy danh sách các phần tử <SANPHAM>
    final List<SanPham> arrs =
        document
            .findAllElements('SANPHAM')
            .map(
              (node) => SanPham.fullPara(
                node.findElements('MASP').single.text,
                node.findElements('TENSP').single.text,
                double.parse(node.findElements('GIABAN').single.text),
                double.parse(node.findElements('GIAMGIA').single.text),
              ),
            )
            .toList();
    print('Đọc file thành công');
    return arrs;
  } catch (e) {
    print('Lỗi khi đọc file XML: $e');
    return [];
  }
}

void main() async {
  List<SanPham> lstSanPham = [];
  SanPham sp1 = SanPham.fullPara('SP001', 'Bánh gạo Nhật', 25000, 0);
  SanPham sp2 = SanPham.fullPara('SP002', 'Trà ô long', 75000, 0);
  SanPham sp3 = SanPham.fullPara('SP003', 'Mứt xoài sấy', 45000, 0);
  lstSanPham.add(sp1);
  lstSanPham.add(sp2);
  lstSanPham.add(sp3);
  print("Danh sách sản phẩm là: ");
  for (SanPham a in lstSanPham) {
    a.showInfo();
    List<SanPham> ds = await readFile('lib/sanpham.txt');
    print("Đọc dữ liệu từ file: ");
    for (SanPham x in ds) {
      x.showInfo();
    }
  }
  List<SanPham> ds = await readFileXML('lib/sanpham.xml');
  print("Đọc dữ liệu từ file xml: ");
  for (SanPham x in ds) {
    x.showInfo();
  }
}
