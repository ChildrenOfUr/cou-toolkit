import 'dart:io';

main() async {

  print('starting AuthServer..');
  Process auth = await Process.start('dart',
    ['bin/authserver.dart', '--no-load-cert'],
    workingDirectory: 'source/auth');

  auth.stdout.listen((data) {
    print('A:' + new String.fromCharCodes(data));
  });
  auth.stderr.listen((data) {
    print('A:' + new String.fromCharCodes(data));
  });

  print('starting GameServer..');
  Process server = await Process.start('dart',
    ['declarations.dart', '--no-load-cert'],
    workingDirectory: 'source/server');

  server.stderr.listen((data) {
    print('G:' +new String.fromCharCodes(data));
  });
  server.stdout.listen((data) {
    print('G:' +new String.fromCharCodes(data));
  });

  print('serving client..');
  Process client = await Process.start('pub',
    ['serve'],
    workingDirectory: 'source/client');
  client.stderr.listen((data) {
    print('C:' +new String.fromCharCodes(data));
  });
  client.stdout.listen((data) {
    print('C:' +new String.fromCharCodes(data));
  });
}
