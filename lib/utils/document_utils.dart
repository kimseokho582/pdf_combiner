import 'package:file_magic_number/file_magic_number.dart';
import 'package:file_magic_number/file_magic_number_type.dart';

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
  static Future<bool> isPDF(String filePath) async {
    try {
      return await FileMagicNumber.detectFileTypeFromPathOrBlob(filePath) ==
          FileMagicNumberType.pdf;
    } catch (e) {
      return false;
    }
  }

  /// Determines whether the given file path corresponds to an image file.
  ///
  /// The method checks for common image file extensions (`.jpg`, `.jpeg`, `.png`,
  /// `.gif`, `.bmp`). If the file has no extension, it is assumed to be an image.
  static Future<bool> isImage(String filePath) async {
    try {
      final fileType =
          await FileMagicNumber.detectFileTypeFromPathOrBlob(filePath);
      return fileType == FileMagicNumberType.png ||
          fileType == FileMagicNumberType.jpg;
    } catch (e) {
      return false;
    }
  }
}
