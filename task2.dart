import 'dart:io';

int i = 0;
String s = '';

void S() {
  if (s[i] == 'a') {
    i++;
    B();
    if (s[i] == 'b') {
      i++;
    } else {
      error();
    }
  } else if (s[i] == 'c') {
    i++;
    if (s[i] == 'c') {
      i++;
      A();
    } else {
      error();
    }
  }
}

void A() {
  if (s[i] == 'b' || s[i] == 'c') {
    i++;
  } else {
    error();
  }
}

void B() {
  if (s[i] == 'a' || s[i] == 'b') {
    i++;
  } else {
    error();
  }
}

void error() {
  print('String is invalid');
  exit(0);
}

void main() {
  stdout.write('Given grammar is\n');
  stdout.write('S -> aBb/ccA\n');
  stdout.write('A -> b/c\n');
  stdout.write('B -> a/b\n');
  stdout.write('Enter the string:\n');
  s = stdin.readLineSync()!;
  S();
  if (i == s.length) {
    print('String is valid');
  } else {
    print('String is invalid');
  }
}
