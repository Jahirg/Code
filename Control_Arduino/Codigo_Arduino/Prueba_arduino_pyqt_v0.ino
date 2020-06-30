// ################################################################################
// Programa de ejemplo para tablero de control usando PYQT QML como interfaz grafica.
// Cualquier aporte, mejora, a mi correo JAHIRG@YAHOO.COM
// No soy experto en programacion, quiero aprender.
// Este codigo es desean hace proyectos usando interfaz grafica en pc
// ###############################################################################

// #### Registros de prueba 
int au16data[16] = {
  300, 102, 1003, 104, 10000, 20000, 30000, 32000, 0, 0, 0, 0, 0, 0, 1, 1 };
const size_t dataLength = 16;

void setup() {
  
  // #### slider para PMW
  pinMode(3,OUTPUT);
  pinMode(4,OUTPUT); // Es PMW en Mega2560. NO EN NANO,ni UNO  
  pinMode(5,OUTPUT);

  // ### Senales de pulsadores 
  pinMode(6,INPUT);
  pinMode(7,INPUT);
  pinMode(8,INPUT);
  pinMode(9,INPUT);
  
  // ### Senales para indicadores
  pinMode(10,OUTPUT);
  pinMode(11,OUTPUT);
  pinMode(12,OUTPUT);
  pinMode(13,OUTPUT);
  
  Serial.begin( 9600 ); // baud-rate at 9600
}

//###### FUNCION ENVIO PAQUETE DATOS
void sendBytes(uint16_t value)
{
  Serial.write(highByte(value));
  Serial.write(lowByte(value));
}
//###################################


//###### FUNCION ACTIVACION LEDS#####
void vProcessaUart(String s){
  
  if(s == "10H")
    digitalWrite(10,HIGH);
  if(s == "10L")
    digitalWrite(10,LOW);

  if(s == "11H")
    digitalWrite(11,HIGH);
  if(s == "11L")
    digitalWrite(11,LOW);

  if(s == "12H")
    digitalWrite(12,HIGH);
  if(s == "12L")
    digitalWrite(12,LOW);

  if(s == "13H")
    digitalWrite(13,HIGH);
  if(s == "13L")
    digitalWrite(13,LOW);

// ##### SECCION PWM #######
    String pwm =s;
    int datapwm=0;
    pwm.remove(0, 3);
    datapwm=pwm.toInt();
    s.remove(3);

 if(s == "P03")
    analogWrite(3, datapwm);
 if(s == "P04")
    analogWrite(4, datapwm);
 if(s == "P05")
    analogWrite(5, datapwm); 
}
//###########################


void loop() {
// #### Registro 0 al 3 son entradas analogos
  au16data[0]=analogRead(A1);
  au16data[1]=analogRead(A2);
  au16data[2]=analogRead(A3);
  au16data[3]=analogRead(A4);

// #### Registro 4 al 7 son entradas digitales
  if(digitalRead(6))
    au16data[8]=611;
  else
    au16data[8]=600;
  if(digitalRead(7))
    au16data[9]=711;
  else
    au16data[9]=700;
  if(digitalRead(8))
    au16data[10]=811;
  else
    au16data[10]=800;
  if(digitalRead(9))
    au16data[11]=911;
  else
    au16data[11]=900;
    
//#### Envio de datos al PC

    for(int n = 0; n < 16; n++){
      sendBytes(au16data[n]);
    }
    
//#### Captura de datos del PC
  String sz = "";
  char ch;
  int nCmpt = 0;
  while (Serial.available() > 0) {
    sz += (char)Serial.read();
    nCmpt++;
    delay(2);
  }
  if(nCmpt)
    vProcessaUart(sz);

 delay(100);
}
