import 'dart:io';

main() async {
  Directory source = new Directory('source');
  bool exists = await source.exists();
  if (!exists) {
    print("Looks like `pub run cou:setup` wasn't run.");
    return;
  }

  print('starting AuthServer..');
  Process auth = await Process.start('dart',
    ['bin/authserver.dart', '--no-load-cert'],
    workingDirectory: 'source/auth');
  auth.stdout.listen((data) {
    print('Auth: ' + new String.fromCharCodes(data));
  });
  auth.stderr.listen((data) {
    print('Auth: ' + new String.fromCharCodes(data));
  });

  print('starting GameServer..');
  Process server = await Process.start('dart',
    ['declarations.dart', '--no-load-cert'],
    workingDirectory: 'source/server');
  server.stderr.listen((data) {
    print('Server: ' +new String.fromCharCodes(data));
  });
  server.stdout.listen((data) {
    print('Server: ' +new String.fromCharCodes(data));
  });

  print('serving client..');
  Process client = await Process.start('pub',
    ['serve'],
    workingDirectory: 'source/client');
  client.stderr.listen((data) {
    print('Client: ' +new String.fromCharCodes(data));
  });
  client.stdout.listen((data) {
    print('Client: ' +new String.fromCharCodes(data));
  });
}
