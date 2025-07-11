import 'package:file_magic_number/file_magic_number.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'dart:typed_data';

/// Utility class for handling document-related checks in a file system environment.
///
/// This implementation is designed for platforms with direct file system access,
/// such as Windows, macOS, and Linux. The `filePath` parameter should be a valid
/// local file path.
class DocumentUtils {
  /// Determines whether the given file path corresponds to a PDF file.
  ///
  /// This method checks if the file path ends with the `.pdf` extension
  /// (case insensitive).
  // static Future<bool> isPDF(String filePath) async {
  //   try {
  //     return await FileMagicNumber.detectFileTypeFromPathOrBlob(filePath) ==
  //         FileMagicNumberType.pdf;
  //   } catch (e) {
  //     return false;
  //   }
  // }
  static Future<bool> isPDF(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) return false;

      // 파일 핸들 열고
      final raf = await file.open();
      // 처음 4바이트만 읽기
      final header = await raf.read(4);
      await raf.close();

      if (header.length < 4) return false;
      return header[0] ==
              0x25 // '%'
              &&
          header[1] ==
              0x50 // 'P'
              &&
          header[2] ==
              0x44 // 'D'
              &&
          header[3] == 0x46; // 'F'
    } catch (e) {
      return false;
    }
  }

  /// Checks if the given file path has a PDF extension.
  /// Returns `true` if the file has a `.pdf` extension, otherwise `false`.
  static bool hasPDFExtension(String filePath) => p.extension(filePath) == ".pdf";

  /// Determines whether the given file path corresponds to an image file.
  ///
  /// The method checks for common image file extensions (`.jpg`, `.jpeg`, `.png`,
  /// `.gif`, `.bmp`). If the file has no extension, it is assumed to be an image.
  static Future<bool> isImage(String filePath) async {
    try {
      final fileType = await FileMagicNumber.detectFileTypeFromPathOrBlob(filePath);
      return fileType == FileMagicNumberType.png || fileType == FileMagicNumberType.jpg;
    } catch (e) {
      return false;
    }
  }
}
