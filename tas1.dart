import 'dart:io';

// Enum for token types
enum TokenType {
  KEYWORD,
  IDENTIFIER,
  NUMERIC,
  SPECIAL_CHARACTER,
  OPERATOR,
  OTHER,
}

// Function to check if a string is a keyword
bool isKeyword(String word) {
  // List of keywords
  List<String> keywords = [
    "auto",
    "break",
    "case",
    "char",
    "const",
    "continue",
    "default",
    "do",
    "double",
    "else",
    "enum",
    "extern",
    "float",
    "for",
    "goto",
    "if",
    "int",
    "long",
    "register",
    "return",
    "short",
    "signed",
    "sizeof",
    "static",
    "struct",
    "switch",
    "typedef",
    "union",
    "unsigned",
    "void",
    "volatile",
    "while"
  ];

  return keywords.contains(word);
}

// Function to perform lexical analysis
TokenType analyzeToken(String word, bool inMultiLineComment) {
  RegExp letterRegex = RegExp(r'[a-zA-Z]');
  RegExp digitRegex = RegExp(r'[0-9]');
  RegExp whitespaceRegex = RegExp(r'\s');

  if (letterRegex.hasMatch(word[0]) || word[0] == '_') {
    return isKeyword(word) ? TokenType.KEYWORD : TokenType.IDENTIFIER;
  } else if (digitRegex.hasMatch(word[0])) {
    return TokenType.NUMERIC;
  } else if (whitespaceRegex.hasMatch(word[0])) {
    return TokenType.OTHER;
  } else {
    if (word == "=" ||
        word == "+" ||
        word == "-" ||
        word == "<" ||
        word == ">" ||
        word == "!=" ||
        word == ">=" ||
        word == "<=") {
      return TokenType.OPERATOR;
    } else {
      return TokenType.SPECIAL_CHARACTER;
    }
  }
}

void main() {
  stdout.write('Enter text to analyze: ');
  String input = stdin.readLineSync() ?? '';

  List<String> separators = [
    " ",
    ",",
    ".",
    ";",
    "(",
    ")",
    "{",
    "}",
    "[",
    "]",
    "+",
    "-",
    "*",
    "/",
    "=",
    "<",
    ">",
    "!",
    "&",
    "|",
    "%",
    "^"
  ];

  List<String> tokens = [];
  String currentToken = '';

  for (int i = 0; i < input.length; i++) {
    String char = input[i];
    if (separators.contains(char)) {
      if (currentToken.isNotEmpty) {
        tokens.add(currentToken);
        currentToken = '';
      }
      tokens.add(char);
    } else {
      currentToken += char;
    }
  }
  if (currentToken.isNotEmpty) {
    tokens.add(currentToken);
  }

  List<String> identifiers = [],
      keywords = [],
      numerics = [],
      specialCharacters = [],
      operators = [];

  bool inMultiLineComment = false;
  for (String token in tokens) {
    TokenType tokenType = analyzeToken(token, inMultiLineComment);

    switch (tokenType) {
      case TokenType.KEYWORD:
        keywords.add(token);
        break;
      case TokenType.IDENTIFIER:
        identifiers.add(token);
        break;
      case TokenType.NUMERIC:
        numerics.add(token);
        break;
      case TokenType.SPECIAL_CHARACTER:
        specialCharacters.add(token);
        break;
      case TokenType.OPERATOR:
        operators.add(token);
        break;
      case TokenType.OTHER:
        break;
    }

    if (token == "//" || token == "/*") {
      inMultiLineComment = true;
    } else if (token == "*/") {
      inMultiLineComment = false;
    }
  }

  print('Keywords: ${keywords.join(" ")}');
  print('Identifiers: ${identifiers.join(" ")}');
  print('Numeric Values: ${numerics.join(" ")}');
  print('Special Characters: ${specialCharacters.join(" ")}');
  print('Operators: ${operators.join(" ")}');
}
