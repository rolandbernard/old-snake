public boolean keyz[] = new boolean[18];
public boolean keyt[] = new boolean[52];
public boolean keytr[] = new boolean[55];

void keyPressed() {
  
  if (keyCode == UP)  {keyz[12] = true; keyz[13] = false;}
  if (keyCode == DOWN)  {keyz[12] = false; keyz[13] = true;}
  if (keyCode == LEFT)  {keyz[14] = true; keyz[15] = false;}
  if (keyCode == RIGHT)  {keyz[14] = false; keyz[15] = true;}
  if (key == 'W' || key == 'w')  {keyz[0] = true; keyz[1] = false;}
  if (key == 'S' || key == 's')  {keyz[0] = false; keyz[1] = true;}
  if (key == 'A' || key == 'a')  {keyz[2] = true; keyz[3] = false;}
  if (key == 'D' || key == 'd')  {keyz[2] = false; keyz[3] = true;}
  if (key == '8')  {keyz[4] = true; keyz[5] = false;}
  if (key == '5')  {keyz[4] = false; keyz[5] = true;}
  if (key == '4')  {keyz[6] = true; keyz[7] = false;}
  if (key == '6')  {keyz[6] = false; keyz[7] = true;}
  if (key == 'u' || key == 'U')  {keyz[8] = true; keyz[9] = false;}
  if (key == 'j' || key == 'J')  {keyz[8] = false; keyz[9] = true;}
  if (key == 'h' || key == 'H')  {keyz[10] = true; keyz[11] = false;}
  if (key == 'k' || key == 'K')  {keyz[10] = false; keyz[11] = true;}
  
  if (key == 'a') { keyt[0] = true; }
  if (key == 'b') { keyt[1] = true; }
  if (key == 'c') { keyt[2] = true; }
  if (key == 'd') { keyt[3] = true; }
  if (key == 'e') { keyt[4] = true; }
  if (key == 'f') { keyt[5] = true; }
  if (key == 'g') { keyt[6] = true; }
  if (key == 'h') { keyt[7] = true; }
  if (key == 'i') { keyt[8] = true; }
  if (key == 'j') { keyt[9] = true; }
  if (key == 'k') { keyt[10] = true; }
  if (key == 'l') { keyt[11] = true; }
  if (key == 'm') { keyt[12] = true; }
  if (key == 'n') { keyt[13] = true; }
  if (key == 'o') { keyt[14] = true; }
  if (key == 'p') { keyt[15] = true; }
  if (key == 'q') { keyt[16] = true; }
  if (key == 'r') { keyt[17] = true; }
  if (key == 's') { keyt[18] = true; }
  if (key == 't') { keyt[19] = true; }
  if (key == 'u') { keyt[20] = true; }
  if (key == 'v') { keyt[21] = true; }
  if (key == 'w') { keyt[22] = true; }
  if (key == 'x') { keyt[23] = true; }
  if (key == 'y') { keyt[24] = true; }
  if (key == 'z') { keyt[25] = true; }
  
  if (key == 'A') { keyt[26] = true; }
  if (key == 'B') { keyt[27] = true; }
  if (key == 'C') { keyt[28] = true; }
  if (key == 'D') { keyt[29] = true; }
  if (key == 'E') { keyt[30] = true; }
  if (key == 'F') { keyt[31] = true; }
  if (key == 'G') { keyt[32] = true; }
  if (key == 'H') { keyt[33] = true; }
  if (key == 'I') { keyt[34] = true; }
  if (key == 'J') { keyt[35] = true; }
  if (key == 'K') { keyt[36] = true; }
  if (key == 'L') { keyt[37] = true; }
  if (key == 'M') { keyt[38] = true; }
  if (key == 'N') { keyt[39] = true; }
  if (key == 'O') { keyt[40] = true; }
  if (key == 'P') { keyt[41] = true; }
  if (key == 'Q') { keyt[42] = true; }
  if (key == 'R') { keyt[43] = true; }
  if (key == 'S') { keyt[44] = true; }
  if (key == 'T') { keyt[45] = true; }
  if (key == 'U') { keyt[46] = true; }
  if (key == 'V') { keyt[47] = true; }
  if (key == 'W') { keyt[48] = true; }
  if (key == 'X') { keyt[49] = true; }
  if (key == 'Y') { keyt[50] = true; }
  if (key == 'Z') { keyt[51] = true; }
  if (key == ' ') { keyt[52] = true; }
  if (key == '.') { keyt[53] = true; }
  if (key == '_') { keyt[54] = true; }
  
  if (key == ENTER || key == RETURN) {keyz[16] = true;}
  if (key == '#') {keyz[17] = true;}
}

void keyReleased() {
  
  if (key == 'a' && keyt[0]) {  keytr[0] = true;  keyt[0] = false;}
  if (key == 'b' && keyt[1]) {  keytr[1] = true; keyt[1] = false;}
  if (key == 'c' && keyt[2]) {  keytr[2] = true; keyt[2] = false;}
  if (key == 'd' && keyt[3]) {  keytr[3] = true; keyt[3] = false;}
  if (key == 'e' && keyt[4]) {  keytr[4] = true; keyt[4] = false;}
  if (key == 'f' && keyt[5]) {  keytr[5] = true; keyt[5] = false;}
  if (key == 'g' && keyt[6]) {  keytr[6] = true; keyt[6] = false;}
  if (key == 'h' && keyt[7]) {  keytr[7] = true; keyt[7] = false;}
  if (key == 'i' && keyt[8]) {  keytr[8] = true; keyt[8] = false;}
  if (key == 'j' && keyt[9]) {  keytr[9] = true; keyt[9] = false;}
  if (key == 'k' && keyt[10]) { keytr[10] = true; keyt[10] = false;}
  if (key == 'l' && keyt[11]) { keytr[11] = true; keyt[11] = false;}
  if (key == 'm' && keyt[12]) { keytr[12] = true; keyt[12] = false;}
  if (key == 'n' && keyt[13]) { keytr[13] = true; keyt[13] = false;}
  if (key == 'o' && keyt[14]) { keytr[14] = true; keyt[14] = false;}
  if (key == 'p' && keyt[15]) { keytr[15] = true; keyt[15] = false;}
  if (key == 'q' && keyt[16]) { keytr[16] = true; keyt[16] = false;}
  if (key == 'r' && keyt[17]) { keytr[17] = true; keyt[17] = false;}
  if (key == 's' && keyt[18]) { keytr[18] = true; keyt[18] = false;}
  if (key == 't' && keyt[19]) { keytr[19] = true; keyt[19] = false;}
  if (key == 'u' && keyt[20]) { keytr[20] = true; keyt[20] = false;}
  if (key == 'v' && keyt[21]) { keytr[21] = true; keyt[21] = false;}
  if (key == 'w' && keyt[22]) { keytr[22] = true; keyt[22] = false;}
  if (key == 'x' && keyt[23]) { keytr[23] = true; keyt[23] = false;}
  if (key == 'y' && keyt[24]) { keytr[24] = true; keyt[24] = false;}
  if (key == 'z' && keyt[25]) { keytr[25] = true; keyt[25] = false;}
  
  if (key == 'A' && keyt[26]) { keytr[26] = true; keyt[26] = false;}
  if (key == 'B' && keyt[27]) { keytr[27] = true; keyt[27] = false;}
  if (key == 'C' && keyt[28]) { keytr[28] = true; keyt[28] = false;}
  if (key == 'D' && keyt[29]) { keytr[29] = true; keyt[29] = false;}
  if (key == 'E' && keyt[30]) { keytr[30] = true; keyt[30] = false;}
  if (key == 'F' && keyt[31]) { keytr[31] = true; keyt[31] = false;}
  if (key == 'G' && keyt[32]) { keytr[32] = true; keyt[32] = false;}
  if (key == 'H' && keyt[33]) { keytr[33] = true; keyt[33] = false;}
  if (key == 'I' && keyt[34]) { keytr[34] = true; keyt[34] = false;}
  if (key == 'J' && keyt[35]) { keytr[35] = true; keyt[35] = false;}
  if (key == 'K' && keyt[36]) { keytr[36] = true; keyt[36] = false;}
  if (key == 'L' && keyt[37]) { keytr[37] = true; keyt[37] = false;}
  if (key == 'M' && keyt[38]) { keytr[38] = true; keyt[38] = false;}
  if (key == 'N' && keyt[39]) { keytr[39] = true; keyt[39] = false;}
  if (key == 'O' && keyt[40]) { keytr[40] = true; keyt[40] = false;}
  if (key == 'P' && keyt[41]) { keytr[41] = true; keyt[41] = false;}
  if (key == 'Q' && keyt[42]) { keytr[42] = true; keyt[42] = false;}
  if (key == 'R' && keyt[43]) { keytr[43] = true; keyt[43] = false;}
  if (key == 'S' && keyt[44]) { keytr[44] = true; keyt[44] = false;}
  if (key == 'T' && keyt[45]) { keytr[45] = true; keyt[45] = false;}
  if (key == 'U' && keyt[46]) { keytr[46] = true; keyt[46] = false;}
  if (key == 'V' && keyt[47]) { keytr[47] = true; keyt[47] = false;}
  if (key == 'W' && keyt[48]) { keytr[48] = true; keyt[48] = false;}
  if (key == 'X' && keyt[49]) { keytr[49] = true; keyt[49] = false;}
  if (key == 'Y' && keyt[50]) { keytr[50] = true; keyt[50] = false;}
  if (key == 'Z' && keyt[51]) { keytr[51] = true; keyt[51] = false;}
  if (key == ' ' && keyt[52]) { keytr[52] = true; keyt[52] = false;}
  if (key == '.' && keyt[53]) { keytr[53] = true; keyt[53] = false;}
  if (key == '_' && keyt[54]) { keytr[54] = true; keyt[54] = false;}
  
  if (key == 'W' || key == 'w')  {keyz[0] = false;}
  if (key == 'S' || key == 's')  {keyz[1] = false;}
  if (key == 'A' || key == 'a')  {keyz[2] = false;}
  if (key == 'D' || key == 'd')  {keyz[3] = false;}
  if (key == '8')  {keyz[4] = false; }
  if (key == '5')  {keyz[5] = false;}
  if (key == '4')  {keyz[6] = false;}
  if (key == '6')  {keyz[7] = false;}
  if (key == 'u' || key == 'U')  {keyz[8] = false;}
  if (key == 'j' || key == 'J')  {keyz[9] = false; }
  if (key == 'h' || key == 'H')  {keyz[10] = false;}
  if (key == 'k' || key == 'K')  {keyz[11] = false;}
  if (keyCode == UP)  {keyz[12] = false; }
  if (keyCode == DOWN)  {keyz[13] = false;}
  if (keyCode == LEFT)  {keyz[14] = false;}
  if (keyCode == RIGHT)  {keyz[15] = false;}
  
  if (key == ENTER || key == RETURN) {keyz[16] = false;}
  if (key == '#') {keyz[17] = false;}
}