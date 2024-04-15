import 'package:flutter_application_1/calculations/scoreveri.dart';

import 'package:test/test.dart';

void main(){
  group('Score Calculation Checking',(){
    test('zeroed calculation',(){

    final score = ScoreVeri(0);

    expect(score, 0);
    }
  );
    test('Stage 1 normal calculation',(){

    final score = ScoreVeri(100);

    expect(score, 100);
    }
  );
  test('Stage 1 edge calculation',(){

    final score = ScoreVeri(200);

    expect(score, 200);
    }
  );

  test('Stage 2 normal calculation',(){

    final score = ScoreVeri(1000);

    expect(score, 500);
    }
  );
  test('Stage 2 edge calculation',(){

    final score = ScoreVeri(1800);

    expect(score, 800);
    }
  );
  test('Stage 3 normal calculation',(){

    final score = ScoreVeri(1900);

    expect(score, 900);
    }
  );

  test('Stage 3 edge calculation',(){

    final score = ScoreVeri(2000);

    expect(score, 1000);
    }
  );
    
  test('Stage 4 normal calculation',(){

    final score = ScoreVeri(3000);

    expect(score, 1500);
    }
  );

    test('Stage 4 edge calculation',(){

    final score = ScoreVeri(4000);

    expect(score, 2000);
    }
  );

      test('over the cap calculation',(){

    final score = ScoreVeri(10000);

    expect(score, 2000);
    }
  );
  });
 
}