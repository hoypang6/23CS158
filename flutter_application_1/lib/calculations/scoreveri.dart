int ScoreVeri(int tempSteps){
  int fScore = tempSteps; //finalscore
  int p1 = 0; //part 1 (0-2 miuntes) Double Points
  int p2 = 0; //part 2 (2-18 minutes) In between
  int p3 = 0; //part 3 (18-20 minutes) Double Points
  int p4 = 0; //part 4 (20-40 minutes) 1:1
  if(tempSteps - 2000 > 0){
    p1 = 200;
    p2 = 600;
    p3 = 200; //if it's above 2k then you already have 1k points in the bank
    p4 = ((tempSteps-2000)/2).round();
  }else{
  if(tempSteps - 1800 >0 ){
    p1 = 200;
    p2 = 600;
    p3 = ((tempSteps-1800)).round(); //double points
  }else{
  if(tempSteps - 200 >0 ){
    p1 = 200;
    p2 = (((tempSteps-200) * 37.5)/100).round(); //small drop
  }else{
    if(tempSteps <= 200){
    p1 = ((tempSteps)).round(); // /100 because 1 min steps = 100 steps
    } 
  }
  }
  }

  fScore = p1 + p2 + p3 + p4;
  if(fScore > 2000){
    fScore = 2000; //2000 points ceiling
  }
  return fScore;
}