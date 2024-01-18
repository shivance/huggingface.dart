# HuggingFace.Dart

A Dart/Flutter powered wrapper for the [Hugging Face Inference API](https://huggingface.co/docs/api-inference/index).

## Installation


With Dart:

```
 $ dart pub add huggingface_dart
```

With Flutter:

```
 $ flutter pub add huggingface_dart
```

This will add a line like this to your package's pubspec.yaml (and run an implicit dart pub get):

```
dependencies:
  huggingface_dart: ^<version>
```

## Initialize

```
import 'package:huggingface_dart/huggingface_dart.dart';

HfInference hfInference = HFInference('your_access_token);
```

Your access token should be kept private. If you need to protect it in front-end applications, we suggest setting up a proxy server that stores the access token.

## Natural Language Processing

### Fill Mask

Tries to fill in a hole with a missing word (token to be precise).

```
await hf.fillMask(
  model: 'bert-base-uncased',
  inputs: ['[MASK] world!']
);
```

### Summarization

Summarizes longer text into shorter text. Be careful, some models have a maximum length of input.

```
await hfInference.summarize(
    inputs: [
        'The tower is 324 metres (1,063 ft) tall, about the same height as an 81-storey building, and the tallest structure in Paris. Its base is square, measuring 125 metres (410 ft) on each side. During its construction, the Eiffel Tower surpassed the Washington Monument to become the tallest man-made structure in the world, a title it held for 41 years until the Chrysler Building in New York City was finished in 1930. It was the first structure to reach a height of 300 metres. Due to the addition of a broadcasting aerial at the top of the tower in 1957, it is now taller than the Chrysler Building by 5.2 metres (17 ft). Excluding transmitters, the Eiffel Tower is the second tallest free-standing structure in France after the Millau Viaduct.'], 
    parameters: {
        "do_sample": false
      }, 
    model: 'facebook/bart-large-cnn'
);
```

### Question Answering

Answers questions based on the context you provide.

```
await hfInference.questionAnswering(
    inputs: {
        'question': 'What is the capital of France?',
        'context': 'The capital of France is Paris.'
      }, 
    model: 'deepset/roberta-base-squad2'
);
```

### Table Question Answering

```
await hfInference.tableQuestionAnswering(
    inputs: [
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
      ], 
    model: "google/tapas-base-finetuned-wtq"
);
```

### Text Classification

Often used for sentiment analysis, this method will assign labels to the given text along with a probability score of that label.

```
await hfInference.textClassification(
    inputs: 'I like you. I love you.',
    model: 'distilbert-base-uncased-finetuned-sst-2-english'
);
```

### Text Generation

Generates text from an input prompt.

```
await hfInference.textGeneration(
    inputs: ["The answer to the universe is"],
    model: "gpt2"
);
```

### Token Classification

Used for sentence parsing, either grammatical, or Named Entity Recognition (NER) to understand keywords contained within text.

```
await hfInference.tokenClassification(
    inputs: ["My name is Sarah Jessica Parker but you can call me Jessica"],
    model: "dbmdz/bert-large-cased-finetuned-conll03-english",
);
```

### Translation

Converts text from one language to another.

```
 await hfInference.translate(
    inputs: ["Меня зовут Вольфганг и я живу в Берлине"],
    model: "Helsinki-NLP/opus-mt-ru-en",
);
```

### Zero-Shot Classification

Checks how well an input text fits into a set of labels you provide.

```
await hfInference.zeroShotClassification(
    inputs: ["Hi, I recently bought a device from your company but it is not working as advertised and I would like to get reimbursed!"],
    parameters: {"candidate_labels": ["refund", "legal", "faq"]},
    model: "facebook/bart-large-mnli",
);
```

### Conversational

This task corresponds to any chatbot-like structure. Models tend to have shorter max_length, so please check with caution when using a given model if you need long-range dependency or not.

```
await hfInference.conversational(
    inputs: {
        "past_user_inputs": ["Which movie is the best ?"],
        "generated_responses": ["It's Die Hard for sure."],
        "text": "Can you explain why ?",
    }, 
    model: "microsoft/DialoGPT-large"
);
```

### Sentence Similarity

Calculate the semantic similarity between one text and a list of other sentences.

```
await hfInference.sentenceSimilarity(
    inputs: {
        "source_sentence": "That is a happy person",
        "sentences": [
          "That is a happy dog",
          "That is a very happy person",
          "Today is a sunny day"
        ],
      }, 
    model: "sentence-transformers/all-MiniLM-L6-v2"
);
```


