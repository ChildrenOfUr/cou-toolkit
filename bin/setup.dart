import 'dart:io';
import 'package:git/git.dart' as git;

String clientGitURL = 'https://github.com/ChildrenOfUr/coUclient.git';
String serverGitURL = 'https://github.com/ChildrenOfUr/coUserver.git';
String authGitURL = 'https://github.com/ChildrenOfUr/authServer.git';

main() async {
  Directory source = new Directory('source');
  bool exists = await source.exists();
  if (!exists) {
    await source.create();
  }

  if (source.listSync().isNotEmpty) {
    print('please run "cou:purge" first.');
    return;
  } else {
    print('cloning $clientGitURL...');
    await git.runGit(['clone', clientGitURL, 'source/client']);
    print('cloning $serverGitURL...');
    await git.runGit(['clone', serverGitURL, 'source/server']);
    print('cloning $authGitURL...');
    await git.runGit(['clone', authGitURL, 'source/auth']);
    print('..done');
  }

  print('injecting api keys..');
  await new File('keys/server/API_KEYS.dart').copy('source/server/lib/API_KEYS.dart');
  await new File('keys/auth/API_KEYS.dart').copy('source/auth/API_KEYS.dart');
  print('..done');

  print('running pub get on subprojects..');
  await Process.run('pub', ['get'], workingDirectory: 'source/client');
  await Process.run('pub', ['get'], workingDirectory: 'source/server');
  await Process.run('pub', ['get'], workingDirectory: 'source/auth');
  print('..done');
}
