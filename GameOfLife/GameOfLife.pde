/* https://processing.org/reference/ ...Se uso la página de referencias de Proccessing para todos las funciones en el código.
https://en.wikipedia.org/wiki/Conway's_Game_of_Life#Examples_of_patterns ...De está página estan basadas las reglas del juego.
https://processing.org/examples/gameoflife.html ...Me inspiré de este código para hacer los controles por teclado.
*/
//Tamaño de la celula representada por un cuadrado.
int tCelula = 10; 
// Probabilidad de que aparezca una celula inicial de 0-100
float probabilidad = 15;
//Cuadricula On-Off - Presiona 'C' para poner o quitar la cuadricula
boolean switchCuadricula = false;
//Variable controladora de tiempo, para controlarlo presiona las teclas '+' o '-'.
int tiempo = 110;
//Variable para pausar el programa. presiona la tecla 'P'.
boolean pausa = false;
//Arreglos
boolean[][] celulas;
boolean[][] ancestros;

void setup(){
  
  size(800,800); //Tamaño de la pantalla, se recomienda que sean multiplos del tamaño de la célula
  background(255,255,255);
  fill(0,0,255); //Color rojo
  int x = width/tCelula;
  int y = height/tCelula;
  celulas = new boolean[y][x];
  ancestros = new boolean[y][x];
  
  if(switchCuadricula)cuadricula(width,height);
  
  for(int i = 0; i < y; i += 1){
    for(int j = 0; j < x; j += 1){
      celulas[i][j] = false;
      float r = random(0,1);    //Probabilidad de estar viva
      if(r < probabilidad/100){
        square(j * tCelula, i * tCelula, tCelula);
        ancestros[i][j] = true;
      }else{
        ancestros[i][j] = false;
      }
      
    }
  }
}

void draw(){
  int x = width/tCelula;
  int y = height/tCelula;
  int limSupX = x - 1;
  int limSupY = y - 1;
  int contador;
  background(255,255,255);
  if(switchCuadricula)cuadricula(width,height);
  if(pausa){
    for(int i = 0; i < y; i += 1){
      for(int j = 0; j < x; j += 1){
        if(celulas[i][j])square(j * tCelula, i * tCelula, tCelula);
        }
      }
  }else{
  for(int i = 0; i < y; i += 1){
    for(int j = 0; j < x; j += 1){
         contador = 0;
        
        if(j < limSupX){                                  //Ver a la derecha
          if(ancestros[i][j+1]){
            contador += 1;
          }
        }
        if(j > 0){                                       //Ver a la izquierda
          if(ancestros[i][j-1]){
            contador += 1;
          }
        }
        if(i < limSupY){                                //Ver arriba
          if(ancestros[i+1][j]){
            contador += 1;
          }
        }
        if(i > 0){                                      //Ver abajo
          if(ancestros[i-1][j]){
            contador += 1;
          }
        }
        if((j < limSupX) && (i < limSupY)){                //Ver abajo derecha
          if(ancestros[i+1][j+1]){
            contador += 1;
          }
        }
        if((j > 0) && (i > 0)){                           //Ver arriba izquierda
          if(ancestros[i-1][j-1]){
            contador += 1;
          }
        }
        if((i < limSupY) && (j > 0)){                    //Ver abajo izquierda
          if(ancestros[i+1][j-1]){
            contador += 1;
          }
        }
        if((i > 0) && (j < limSupX)){                    //Ver arriba derecha
          if(ancestros[i-1][j+1]){
            contador += 1;
          }
        }
        
        if(contador == 3){
          celulas[i][j] = true; 
        }else if((contador == 2) && (ancestros[i][j]==true)){
          celulas[i][j] = true;
        }else{
          celulas[i][j] = false;
        }
        
      }
    }
    
    for(int i = 0; i < y; i += 1){
      for(int j = 0; j < x; j += 1){
        if(celulas[i][j])square(j * tCelula, i * tCelula, tCelula);
        ancestros[i][j] = celulas[i][j];
        }
      }
    delay(tiempo);
  }
}

void cuadricula(int ancho, int altura){              //Función para hacer la cuadricula
  for(int i = tCelula; i < ancho; i += tCelula){            //Lineas verticales
    line(i,0,i,altura);
  }
  for(int i = tCelula; i < altura; i += tCelula){           //Lineas horizontales
    line(0,i,ancho,i);
  }
}

void keyPressed(){
  if(key == 'p' || key == 'P'){if(pausa){pausa = false;}else{pausa = true;}}
  if(key == 'c' || key == 'C'){if(switchCuadricula){switchCuadricula = false;}else{switchCuadricula = true;}}
  if(key == '-'){tiempo += 20;}
  if(key == '+'){if(tiempo != 10){tiempo -= 20;}}
}
