import 'package:dotenv/dotenv.dart';
import 'package:huggingface_dart/huggingface_dart.dart';
import 'package:test/test.dart';

void main() async {
  var env = DotEnv(includePlatformEnvironment: true)..load();

  group("NLPTasks", () {
    late HfInference hfInference;

    setUp(() {
      String? accessToken = '${env['HF_API_TOKEN']}';
      hfInference = HfInference(accessToken);
    });

    test('Translate list of inputs', () async {
      final result = await hfInference.translate(
          inputs: [
            "Меня зовут Вольфганг и я живу в Берлине",
            "Меня зовут Вольфганг и я живу в Берлине"
          ],
          model: "Helsinki-NLP/opus-mt-ru-en",
          options: {
            'use_cache': true,
            'wait_for_model': true,
          });

      expect(result, [
        {'translation_text': 'My name is Wolfgang and I live in Berlin.'},
        {'translation_text': 'My name is Wolfgang and I live in Berlin.'}
      ]);
    });

    test("Summarize a string", () async {
      final result = await hfInference.summarize(inputs: [
        'The tower is 324 metres (1,063 ft) tall, about the same height as an 81-storey building, and the tallest structure in Paris. Its base is square, measuring 125 metres (410 ft) on each side. During its construction, the Eiffel Tower surpassed the Washington Monument to become the tallest man-made structure in the world, a title it held for 41 years until the Chrysler Building in New York City was finished in 1930. It was the first structure to reach a height of 300 metres. Due to the addition of a broadcasting aerial at the top of the tower in 1957, it is now taller than the Chrysler Building by 5.2 metres (17 ft). Excluding transmitters, the Eiffel Tower is the second tallest free-standing structure in France after the Millau Viaduct.'
      ], parameters: {
        "do_sample": false
      }, model: 'facebook/bart-large-cnn');

      expect(result, [
        {
          'summary_text':
              'The tower is 324 metres (1,063 ft) tall, about the same height as an 81-storey building. Its base is square, measuring 125 metres (410 ft) on each side. During its construction, the Eiffel Tower surpassed the Washington Monument to become the tallest man-made structure in the world.'
        }
      ]);
    });

    test("Question Answering", () async {
      final result = await hfInference.questionAnswering(inputs: {
        'question': 'What is the capital of France?',
        'context': 'The capital of France is Paris.'
      }, model: 'deepset/roberta-base-squad2');

      expect(result['answer'], 'Paris');
    });

    test("Fill Mask", () async {
      final List<dynamic> result = await hfInference.fillMask(
          inputs: ['[MASK] world!', '[MASK] world!'],
          model: 'bert-base-uncased',
          options: {
            'use_cache': true,
            'wait_for_model': true,
          });

      expect(result[0][0], {
        'sequence': 'the world!',
        'score': 0.29108965396881104,
        'token': 1996,
        'token_str': 'the'
      });
    });

    test("Token Classification", () async {
      final List<dynamic> result = await hfInference.tokenClassification(
          inputs: [
            "My name is Sarah Jessica Parker but you can call me Jessica"
          ],
          model: "dbmdz/bert-large-cased-finetuned-conll03-english",
          options: {
            'use_cache': true,
            'wait_for_model': true,
          });

      expect(result.runtimeType, List);
      expect(result[0].length, 2);
      expect(result[0], [
        {
          'entity_group': 'PER',
          'score': 0.9991335868835449,
          'word': 'Sarah Jessica Parker',
          'start': 11,
          'end': 31
        },
        {
          'entity_group': 'PER',
          'score': 0.9979913234710693,
          'word': 'Jessica',
          'start': 52,
          'end': 59
        }
      ]);
    });

    test("Text Generation", () async {
      final List<dynamic> result = await hfInference.textGeneration(
          inputs: ["The answer to the universe is"],
          model: "gpt2",
          options: {
            'use_cache': true,
            'wait_for_model': true,
          });

      expect(result[0].length, 1);
    });

    test("Test Zero Shot", () async {
      final List<dynamic> result = await hfInference.zeroShotClassification(
          inputs: [
            "Hi, I recently bought a device from your company but it is not working as advertised and I would like to get reimbursed!"
          ],
          parameters: {
            "candidate_labels": ["refund", "legal", "faq"]
          },
          model: "facebook/bart-large-mnli",
          options: {
            'use_cache': true,
            'wait_for_model': true,
          });

      expect(result[0]['scores'].length, 3);
    });

    test("Table QA", () async {
      final result = await hfInference.tableQuestionAnswering(inputs: [
        {
          "query": "How many stars does the transformers repository have?",
          "table": {
            "Repository": ["Transformers", "Datasets", "Tokenizers"],
            "Stars": ["36542", "4512", "3934"],
            "Contributors": ["651", "77", "34"],
            "Programming language": [
              "Python",
              "Python",
              "Rust, Python and NodeJS",
            ],
          }
        },
      ], model: "google/tapas-base-finetuned-wtq");

      expect(result, {
        'answer': 'AVERAGE > 36542',
        'coordinates': [
          [0, 1]
        ],
        'cells': ['36542'],
        'aggregator': 'AVERAGE'
      });
    });

    test("Sentence Similarity", () async {
      final result = await hfInference.sentenceSimilarity(inputs: {
        "source_sentence": "That is a happy person",
        "sentences": [
          "That is a happy dog",
          "That is a very happy person",
          "Today is a sunny day"
        ],
      }, model: "sentence-transformers/all-MiniLM-L6-v2");

      expect(
          result, [0.6945773363113403, 0.9429150223731995, 0.256876140832901]);
    });

    test("Text Classification", () async {
      final result = await hfInference.textClassification(
          inputs: 'I like you. I love you.',
          model: 'distilbert-base-uncased-finetuned-sst-2-english');

      expect(result, [
        [
          {'label': 'POSITIVE', 'score': 0.9998763799667358},
          {'label': 'NEGATIVE', 'score': 0.00012365418660920113}
        ]
      ]);
    });

    test('Conversational', () async {
      final result = await hfInference.conversational(inputs: {
        "past_user_inputs": ["Which movie is the best ?"],
        "generated_responses": ["It's Die Hard for sure."],
        "text": "Can you explain why ?",
      }, model: "microsoft/DialoGPT-large");

      expect(result['generated_text'], "It's the best movie ever.");
    });
  });
}
