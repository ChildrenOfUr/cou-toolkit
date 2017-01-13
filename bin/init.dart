import 'dart:io';
import 'dart:async';
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
    try {
      await Future.wait([
        () async {
          print('cloning $clientGitURL...');
          await git.runGit(['clone', clientGitURL, 'source/client']);
          print('finished cloning $clientGitURL');
        }(),
        () async {
          print('cloning $serverGitURL...');
          await git.runGit(['clone', serverGitURL, 'source/server']);
          await git.runGit(['checkout', 'toolkit-compat'], processWorkingDir: 'source/server');
          print('finished cloning $serverGitURL');
        }(),
        () async {
          print('cloning $authGitURL...');
          await git.runGit(['clone', authGitURL, 'source/auth']);
          await git.runGit(['checkout', 'toolkit-compat'], processWorkingDir: 'source/auth');
          print('finished cloning $authGitURL');
        }()
      ], eagerError: true);
    } catch (e) {
      print(e);
      return;
    }
  }

  print('running pub get on subprojects..');
  try {
    await Future.wait([
      () async {
        await Process.run('pub', ['get'], workingDirectory: 'source/client');
      }(),
      () async {
        await Process.run('pub', ['get'], workingDirectory: 'source/server');
      }(),
      () async {
        await Process.run('pub', ['get'], workingDirectory: 'source/auth');
      }()
    ], eagerError: true);
  } catch (e) {
    print(e);
    return;
  }
  print('..done');
}
