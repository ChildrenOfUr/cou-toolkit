import 'dart:io';
import 'package:prompt/prompt.dart' as prompt;

main() async {
  String purge = await prompt.ask('Should we clear out the "source" directory? (y/N)');
  purge = purge.trim().toLowerCase();
  if (purge == 'y' || purge == 'yes') {
    print('purging project files..');
    for (FileSystemEntity dir in new Directory('source').listSync()) {
      await dir.delete(recursive: true);
      print('${dir.path} purged.');
    }
    print('..done');
  }
  prompt.close();
}
