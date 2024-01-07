name: Dart Test

on:
push:
branches:
- main

jobs:
test:
runs-on: ubuntu-latest

env:
HF_API_TOKEN: ${{ secrets.HF_API_TOKEN }}

steps:
- name: Checkout code
uses: actions/checkout@v2

- name: Set up Dart
uses: actions/setup-dart@v2
with:
dart-sdk: 2.14.0  # Specify the Dart SDK version you want to use

- name: Get dependencies
run: dart pub get

- name: Run tests
run: dart test
env:
HF_API_TOKEN: ${{ secrets.HF_API_TOKEN }}
