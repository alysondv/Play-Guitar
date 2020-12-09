/*  PROJETO PLAY GUITAR - Desenvolvida em conjunto das matérias teorica e prática
*   ALYSON HENRIQUE GONÇALO  2019004779
*   NONATO DA SILVA NERI JUNIOR 2019008160 - primeira parte da disciplina em 2020.1
*/

/* NA EXECUÇÃO DO PROJETO O CLOCK ESTAVA EM 8MHz*/
#include "config.h"
#include "pic18f4520.h"
#include "delay.h"
#include "lcd.h"
#include "teclado.h"
#include "itoa.h"

 unsigned int atrasoMin = 20;
 unsigned int atrasoMed = 150;
 unsigned int atrasoMax = 1000;
 long int unsigned cont = 0;

 //MOSTRA A PONTUAÇÃO NO DISPLAY DE 7 SEGMENTOS
 void pontua(void){ 
    BitClr(INTCON2, 7); //Liga o pull up
    ADCON1 = 0x0E; // config AD
    TRISA = 0x00;
    TRISD = 0x00;
    PORTD = 0x00;
    
    int k;
    int decimal[10] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};
    int unsigned delay  = 100;
    int i;
    
    for(i = 0;i < 100;i++){
        
        PORTD = decimal[(cont/10)%10];
        BitSet(PORTA, 5); //Liga o 1º Display
        BitClr(PORTA, 4); //Desliga o 2º Display
        BitClr(PORTA, 3); //Desliga o 3º Display
        for(k = 0; k < delay; k++);
        
        PORTD = decimal[(cont/100)%10];
        BitClr(PORTA, 5); //Desliga o 1º Display
        BitSet(PORTA, 4); //Liga o 2º Display
        BitClr(PORTA, 3); //Desliga o 3º Display
        for(k = 0; k < delay; k++);
        
        PORTD = decimal[(cont/1000)%10];
        BitClr(PORTA, 5); //desliga o 1º Display
        BitClr(PORTA, 4); //Desliga o 2º Display
        BitSet(PORTA, 3); //Liga o 3º Display
        for(k = 0; k < delay; k++);
        
        PORTD = decimal[(cont/10000)%10];
        BitClr(PORTA, 5); //desliga o 1º Display
        BitClr(PORTA, 4); //Desliga o 2º Display
        BitClr(PORTA, 3); //Desliga o 3º Display
        for(k = 0; k < delay; k++);
        
    }
}
 
 void ledinit(){//INICIA AS CONFIG DO LCD
    BitClr(INTCON2, 7);
    ADCON1 = 0x0E; //config AD 
    TRISA = 0x00; //config da porta A 
    TRISD = 0x00; //config. a porta D 
    PORTD = 0x00;
    
    TRISB = 0x00; //config. a porta D 

    BitClr(PORTB, 0); 
    BitClr(PORTB, 1); 
    BitClr(PORTB, 2); 
    BitClr(PORTB, 3); 
    BitClr(PORTB, 4); 
    BitClr(PORTB, 5); 
    BitClr(PORTB, 6); 
    BitClr(PORTB, 7);

 }
 
 void msgDisplay(int op){ 
    PORTE = 0;
    unsigned char i;
    lcd_cmd(L_CLR);
    lcd_cmd(L_L1);
    if(op == 1){
        lcd_str("    JULIETA");
    }else{
        lcd_str("     MOZART");
    }
    atraso_ms(atrasoMax);
    lcd_cmd(L_L4);
    lcd_str("----------------");
    
    //FAZ O NOME DA MUSICA SE DESLOCAR
    for (i = 0; i < 4; i++) {
        atraso_ms(atrasoMed);
        lcd_cmd(0x18);
    }

    for (i = 0; i < 4; i++) {
        atraso_ms(atrasoMed);
        lcd_cmd(0x1C);
    }

    for (i = 0; i < 4; i++) {
        atraso_ms(atrasoMed);
        lcd_cmd(0x18); //display shift left
    }
    atraso_ms(atrasoMax);
}
 
 //PRINTA BUZZER NO LCD
 void buzzer(int op){
    lcd_cmd(L_CLR);
    lcd_cmd(L_L3);
    lcd_str("   BUZZER");
     
    atraso_ms(1000);
    lcd_cmd(L_CLR);
    lcd_cmd(L_L2);
    lcd_str("TOCANDO: ");
    lcd_cmd(L_L3);
    if(op == 1){
        lcd_str("  JULIETA");
        
    }else{
        lcd_str("  MOZART");
    } 
 }
 
 //MENSAGEM DE ATENÇÃO PARA O JOGADOR
 void msgInicio(){
    lcd_cmd(L_CLR);
    lcd_cmd(L_L3);
    lcd_str("  PRONTO");
    lcd_cmd(L_L4);
    atraso_ms(500);
    lcd_cmd(L_CLR);
    lcd_str("   VAlENDO!!!");
    atraso_ms(750);
    lcd_cmd(L_CLR);
    
}
 
 //EXIBE A PONTUAÇÃO FINAL DO JOGADOR NO LCD APÓS A MÚSICA ACABAR
 void pontFinal(){
    cont /= 10;
    char valor[6];
    itoa(cont, &valor);
    lcd_cmd(L_CLR);
    if(cont == 500){
        lcd_cmd(L_L3);
        lcd_str("-  PERFECT  -");
    }else{
        
        lcd_cmd(L_L1);
        lcd_str("VOCE FEZ:");
        lcd_cmd(L_L2);
        lcd_str(valor);
        lcd_cmd(L_L3);
        lcd_str("PONT MAX:");
        lcd_cmd(L_L4);
        lcd_str("500");
    }
    atraso_ms(3000);
}
 
//FUNÇÃO QUE EXECUTA A MÚSICA ESCOLHIDA
void musica(unsigned char msc[20], unsigned char mscC[20], int op){
    unsigned char i;
    unsigned char tmp;
    
    PORTB = 0x00;
    PORTD = 0x00;
    
    cont = 0;
    
    msgDisplay(op);
    
    msgInicio();
    
    lcd_cmd(L_CLR);
    lcd_cmd(L_L2);
    lcd_str("TOCANDO: ");
    lcd_cmd(L_L3);
    if(op == 1){
        lcd_str("  JULIETA");
        
    }else{
        lcd_str("  MOZART");
    } 
    
    PORTB = 0x00;
    for(i = 0; i < 20; i++){
        PORTB = 0x00;
        BitSet(PORTB, msc[i]);
        atraso_ms(atrasoMax);
        BitClr(PORTB, msc[i]);
        atraso_ms(atrasoMax);
        PORTB = 0x00;
        
        TRISD=0x0F;
        tmp=tc_tecla(1000)+0x30;
        TRISD=0x00;   

        if(tmp == mscC[i]){
            //pontua
            cont += 250;
            pontua();
            buzzer(op);
        }
        PORTB = 0x3F;
        PORTD = 0x3F;
    }
    
    
}

//UM MENU COM AS MÚSICAS DEFINIDAS, A PARTE INICIAL DO JOGO
void menu() {

    unsigned char i;
    unsigned char tmp;
    ADCON1 = 0x06;
    TRISB = 0x00;
    TRISD = 0x00;
    TRISE = 0x00;
    
    unsigned char mozart[] = {2, 4, 3, 5, 1, 2, 3, 4, 1, 1, 2, 4, 3, 1, 2,  1, 2 , 3, 2, 4 };
    unsigned char mozartC[] =  {'2', '4', '3', '5', '1', '2', '3', '4', '1', '1', '2', '4', '3', '1', '2', '1', '2' , '3', '2', '4'};

    unsigned char julieta[] =  {1, 1, 3, 5, 4, 2, 2, 2, 3, 4, 5, 5, 2, 1, 3, 3, 4 , 1, 1, 5};
    unsigned char julietaC[] =  {'1', '1', '3', '5', '4', '2', '2', '2', '3', '4', '5', '5', '2', '1', '3', '3', '4' , '1', '1', '5'};
    
    lcd_init();
    
    lcd_cmd(L_CLR);
    lcd_cmd(L_L1);
    lcd_str("   WELCOME");
    lcd_cmd(L_L2);
    lcd_str("----------------");
    lcd_cmd(L_L3);
    lcd_str("  PLAY GUITAR");
    atraso_ms(atrasoMax);
    
    while(1){
        lcd_cmd(L_CLR);
        lcd_cmd(L_L1);
        lcd_str("Escolha a musica");
        lcd_cmd(L_L2);
        lcd_str("(1) - JULIETA");
        lcd_cmd(L_L3);
        lcd_str("(2) - MOZART");
        lcd_cmd(L_L4);
        lcd_str("****************");
        TRISD = 0x0F;
        tmp = tc_tecla(0) + 0x30; // 0x30 é pra ajustar para inteiros
        //leitura da tecla
        TRISD = 0x00;

        if(tmp == '1' || tmp == '2'){
            if(tmp == '1'){
                musica(julieta, julietaC, 1);
                pontFinal();
            }else{
                musica(mozart, mozartC, 2);
                pontFinal();
            }
        }else{
            lcd_cmd(L_CLR);
            lcd_cmd(L_L4);
            lcd_dat(tmp);
            lcd_cmd(L_L3);
            lcd_str("Op <1> ou <2> ");
        }
        atraso_ms(atrasoMax);
    }
    
}

int main(){
    menu();
    return 0;
}
