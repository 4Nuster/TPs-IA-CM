int tab[][] = new int[3][3];
int human, ai;
boolean choice = false;
int keyX, keyY, winner = 3;
Position best;

int miniMax(int[][] board, int depth, boolean nextPlayer){
  int current, maxHass;
  current = whoWon(board);
  if(current != 3) return current;
  
  if(nextPlayer){
    maxHass = -1000;
    for(int i=0;i<3;i++){
      for(int j=0;j<3;j++){
        if(board[i][j] == 0){
          board[i][j] = 1;
          current = miniMax(board, depth+1, false);
          board[i][j] = 0;
          maxHass = max(maxHass,current);
        }
      }
    }
    return maxHass;
  }
  else{
    maxHass = 1000;
    for(int i=0;i<3;i++){
      for(int j=0;j<3;j++){
        if(board[i][j] == 0){
          board[i][j] = 2;
          current = miniMax(board, depth+1, true);
          board[i][j] = 0;
          maxHass = min(maxHass,current);
        }
      }
    }
    return maxHass;
  }
}

Position bestMove(boolean currentPlayer){
  int score, bestScore = -1000;
  if(!currentPlayer) bestScore = -bestScore;
  Position move = new Position();
  for(int i=0;i<3;i++){
    for(int j=0;j<3;j++){
      if(tab[i][j] == 0){
        if(currentPlayer) tab[i][j] = 1;
        else tab[i][j] = 2;
        score = miniMax(tab, 0, !currentPlayer);
        tab[i][j] = 0;
        if(currentPlayer){
          if(score>bestScore){
            bestScore = score;
            move = new Position(i,j);
          }
        }
        else{
          if(score<bestScore){
            bestScore = score;
            move = new Position(i,j);
          }
        }
      }
    }
  }
  return move;
}

int whoWon(int[][] board){
  boolean draw = true;
  int score = 3;
  for(int i=0;i<3;i++){
    for(int j=0;j<3;j++){
      if(board[i][j] == 0) draw = false;
    }
  }
  if(draw) score = 0;
  for(int i=0; i<3; i++){
    if(board[i][0] == board[i][1] && board[i][1] == board[i][2] && (board[i][2] == 1 || board[i][2] == 2)) score = board[i][0];
  }
  for(int i=0; i<3; i++){
    if(board[0][i] == board[1][i] && board[1][i] == board[2][i] && (board[2][i] == 1 || board[2][i] == 2)) score = board[0][i];
  }
  if(((board[0][0] == board[1][1] && board[1][1] == board[2][2]) || (board[0][2] == board[1][1] && board[1][1] == board[2][0])) && (board[1][1] == 1 || board[1][1] == 2)) score = board[1][1];
  if(score == 2) score = -1;
  return score;
}

void mouseClicked(){
  if(!choice){
    if((mouseY/235) == 0){
      human = 1;
      ai = -1;
    }
    else{
      human = -1;
      ai = 1;
    }
    choice = true;
    if(ai == 1){
      best = bestMove(true);
      tab[best.x][best.y] = 1;
    }
  }
  else{
    if(tab[mouseX/160][mouseY/160]==0 && winner==3){
      if(human == 1) tab[mouseX/160][mouseY/160] = 1;
      else tab[mouseX/160][mouseY/160] = 2;
      winner = whoWon(tab);
      if(winner == 3){
        if(ai == 1){
          best = bestMove(true);
          tab[best.x][best.y] = 1;
        }
        else{
          best = bestMove(false);
          tab[best.x][best.y] = 2;
        }
        winner = whoWon(tab);
      }
    }
  }
}

void setup(){
  size(470, 470);
  for(int i=0;i<3;i++){
    for(int j=0;j<3;j++){
      tab[i][j] = 0;
    }
  }
}

void draw(){
  textSize(48);
  background(92, 181, 143);
  if(!choice){
    fill(255);
    stroke(255);
    rect(0, 0, 470, 235);
    fill(0);
    stroke(0);
    text("PLAY FIRST", 100, 130);
    rect(0, 235, 470, 235);
    fill(255);
    stroke(255);
    text("PLAY SECOND", 65, 365);
  }
  else{
    if(winner == 3){
      //miniMax(tab, 0, player);
      //if(human == 1) best = bestMove(true);
      //else best = bestMove(false);
      //fill(255, 255, 0);
      //stroke(255, 255, 0);
      //ellipse(75+160*best.x, 75+160*best.y, 100, 100);
      stroke(255);
      strokeWeight(10);
      line(155, 0, 155, 470); 
      line(315, 0, 315, 470);
      line(0, 155, 470, 155); 
      line(0, 315, 470, 315);
      for(int i=0; i<3; i++){
        for(int j=0; j<3; j++){
          if(tab[i][j]==1){
            fill(255);
            stroke(255);
            ellipse(75+160*i, 75+160*j, 100, 100);
          }
          else if(tab[i][j]==2){
            fill(0);
            stroke(0);
            ellipse(75+160*i, 75+160*j, 100, 100);
          }
        }
      }
      //delay(100);
    }
    else{
      if(winner == ai){
        fill(255);
        text("THE AI WON", 50, 235);
      }
      else if(winner == -1){
        fill(0);
        text("YOU WON \n(you will never see this message anyway)", 50, 235);
      }
      else{
        fill(255, 255, 0);
        text("DRAW", 150, 235);
      }
    }
  } 
}
