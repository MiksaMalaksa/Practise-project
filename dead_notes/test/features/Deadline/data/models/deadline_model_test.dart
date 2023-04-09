import 'package:flutter_test/flutter_test.dart';
import 'package:dead_notes/features/Deadline/data/models/deadline_model.dart';
import 'package:dead_notes/features/Deadline/domain/entities/deadline.dart';

import '../../testing_helpers.dart';

void main() {
  group('DeadlineModel group', () {
    test(
      'should be subclass of Deadline',
      () async {
        // arrange
        expect(tDeadlineModel, isA<Deadline>());
      },
    );

    test(
      'should return valid DeadlineModel json representation when toJson is called',
      () async {
        // act
        final result = tDeadlineModel.toJson();
        // assert
        expect(result, tDeadlineModelJson);
      },
    );

    test(
      'should return valid DeadlineModel when fromJson is called',
      () async {
        // act
        final result = DeadlineModel.fromJson(tDeadlineModelJson);
        // assert
        expect(result, tDeadlineModel);
      },
    );

    test(
      'should return valid DeadlineModel when fromDeadline is called',
      () async {
        // act
        final result = DeadlineModel.fromDeadline(tDeadline);
        // assert
        expect(result, tDeadlineModel);
      },
    );
  });
}