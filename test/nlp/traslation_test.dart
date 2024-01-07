import 'package:dotenv/dotenv.dart';
import 'package:huggingface_dart/huggingface_dart.dart';
import 'package:huggingface_dart/models/options.dart';
import 'package:huggingface_dart/models/translation.dart';
import 'package:test/test.dart';

void main() async{
  var env = DotEnv(includePlatformEnvironment: true)..load();

  group("NLPService", () {
    late HfInference hfInference;

    setUp(() {
      final String? accessToken = '${env['HF_API_TOKEN']}';
      hfInference = HfInference(accessToken);
    });

    test("Translate single string", () async {

      final TranslationArgs translationArgs = TranslationArgs(inputs: "Меня зовут Вольфганг и я живу в Берлине");
      final OptionalArgs optionalArgs = OptionalArgs(useCache: true, waitForModel: true);

      final TranslationOutput result = await hfInference.translate(
          args: translationArgs,
          model: "Helsinki-NLP/opus-mt-ru-en",
          optionalArgs: optionalArgs);

      expect(result.translationText, [
        {'translation_text': 'My name is Wolfgang and I live in Berlin.'}
      ]);
    });

    test('Translate list of inputs', () async {
      final TranslationArgs translationArgs = TranslationArgs(inputs: [
        "Меня зовут Вольфганг и я живу в Берлине",
        "Меня зовут Вольфганг и я живу в Берлине"
      ]);
      final OptionalArgs optionalArgs =
      OptionalArgs(useCache: true, waitForModel: true);

      final TranslationOutput result = await hfInference.translate(
          args: translationArgs,
          model: "Helsinki-NLP/opus-mt-ru-en",
          optionalArgs: optionalArgs);

      expect(result.translationText, [
        {'translation_text': 'My name is Wolfgang and I live in Berlin.'},
        {'translation_text': 'My name is Wolfgang and I live in Berlin.'}
      ]);
    });

  });
}