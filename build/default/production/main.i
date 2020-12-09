# 1 "main.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 288 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "C:/Program Files (x86)/Microchip/MPLABX/v5.35/packs/Microchip/PIC18Fxxxx_DFP/1.2.26/xc8\\pic\\include\\language_support.h" 1 3
# 2 "<built-in>" 2
# 1 "main.c" 2






# 1 "./config.h" 1
# 38 "./config.h"
#pragma config OSC=HS
#pragma config WDT=OFF
#pragma config LVP=OFF
#pragma config DEBUG = OFF
#pragma config WDTPS = 1
# 7 "main.c" 2

# 1 "./pic18f4520.h" 1
# 8 "main.c" 2

# 1 "./delay.h" 1



void atraso_ms(int t);
# 9 "main.c" 2

# 1 "./lcd.h" 1
# 16 "./lcd.h"
void lcd_init(void);
void lcd_cmd(unsigned char val);
void lcd_dat(unsigned char val);
void lcd_str(const char* str);
# 10 "main.c" 2

# 1 "./teclado.h" 1







    unsigned char tc_tecla(unsigned int timeout);
# 11 "main.c" 2

# 1 "./itoa.h" 1
# 26 "./itoa.h"
void itoa(unsigned int val, char* str );
# 12 "main.c" 2


 unsigned int atrasoMin = 20;
 unsigned int atrasoMed = 150;
 unsigned int atrasoMax = 1000;
 long int unsigned cont = 0;


 void pontua(void){
    (((*(volatile __near unsigned char*)0xFF1)) &= ~(1<<7));
    (*(volatile __near unsigned char*)0xFC1) = 0x0E;
    (*(volatile __near unsigned char*)0xF92) = 0x00;
    (*(volatile __near unsigned char*)0xF95) = 0x00;
    (*(volatile __near unsigned char*)0xF83) = 0x00;

    int k;
    int decimal[10] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};
    int unsigned delay = 100;
    int i;

    for(i = 0;i < 100;i++){

        (*(volatile __near unsigned char*)0xF83) = decimal[(cont/10)%10];
        (((*(volatile __near unsigned char*)0xF80)) |= (1<<5));
        (((*(volatile __near unsigned char*)0xF80)) &= ~(1<<4));
        (((*(volatile __near unsigned char*)0xF80)) &= ~(1<<3));
        for(k = 0; k < delay; k++);

        (*(volatile __near unsigned char*)0xF83) = decimal[(cont/100)%10];
        (((*(volatile __near unsigned char*)0xF80)) &= ~(1<<5));
        (((*(volatile __near unsigned char*)0xF80)) |= (1<<4));
        (((*(volatile __near unsigned char*)0xF80)) &= ~(1<<3));
        for(k = 0; k < delay; k++);

        (*(volatile __near unsigned char*)0xF83) = decimal[(cont/1000)%10];
        (((*(volatile __near unsigned char*)0xF80)) &= ~(1<<5));
        (((*(volatile __near unsigned char*)0xF80)) &= ~(1<<4));
        (((*(volatile __near unsigned char*)0xF80)) |= (1<<3));
        for(k = 0; k < delay; k++);

        (*(volatile __near unsigned char*)0xF83) = decimal[(cont/10000)%10];
        (((*(volatile __near unsigned char*)0xF80)) &= ~(1<<5));
        (((*(volatile __near unsigned char*)0xF80)) &= ~(1<<4));
        (((*(volatile __near unsigned char*)0xF80)) &= ~(1<<3));
        for(k = 0; k < delay; k++);

    }
}

 void ledinit(){
    (((*(volatile __near unsigned char*)0xFF1)) &= ~(1<<7));
    (*(volatile __near unsigned char*)0xFC1) = 0x0E;
    (*(volatile __near unsigned char*)0xF92) = 0x00;
    (*(volatile __near unsigned char*)0xF95) = 0x00;
    (*(volatile __near unsigned char*)0xF83) = 0x00;

    (*(volatile __near unsigned char*)0xF93) = 0x00;

    (((*(volatile __near unsigned char*)0xF81)) &= ~(1<<0));
    (((*(volatile __near unsigned char*)0xF81)) &= ~(1<<1));
    (((*(volatile __near unsigned char*)0xF81)) &= ~(1<<2));
    (((*(volatile __near unsigned char*)0xF81)) &= ~(1<<3));
    (((*(volatile __near unsigned char*)0xF81)) &= ~(1<<4));
    (((*(volatile __near unsigned char*)0xF81)) &= ~(1<<5));
    (((*(volatile __near unsigned char*)0xF81)) &= ~(1<<6));
    (((*(volatile __near unsigned char*)0xF81)) &= ~(1<<7));

 }

 void msgDisplay(int op){
    (*(volatile __near unsigned char*)0xF84) = 0;
    unsigned char i;
    lcd_cmd(0x01);
    lcd_cmd(0x80);
    if(op == 1){
        lcd_str("    JULIETA");
    }else{
        lcd_str("     MOZART");
    }
    atraso_ms(atrasoMax);
    lcd_cmd(0xD0);
    lcd_str("----------------");


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
        lcd_cmd(0x18);
    }
    atraso_ms(atrasoMax);
}


 void buzzer(int op){
    lcd_cmd(0x01);
    lcd_cmd(0x90);
    lcd_str("   BUZZER");

    atraso_ms(1000);
    lcd_cmd(0x01);
    lcd_cmd(0xC0);
    lcd_str("TOCANDO: ");
    lcd_cmd(0x90);
    if(op == 1){
        lcd_str("  JULIETA");

    }else{
        lcd_str("  MOZART");
    }
 }


 void msgInicio(){
    lcd_cmd(0x01);
    lcd_cmd(0x90);
    lcd_str("  PRONTO");
    lcd_cmd(0xD0);
    atraso_ms(500);
    lcd_cmd(0x01);
    lcd_str("   VAlENDO!!!");
    atraso_ms(750);
    lcd_cmd(0x01);

}


 void pontFinal(){
    cont /= 10;
    char valor[6];
    itoa(cont, &valor);
    lcd_cmd(0x01);
    if(cont == 500){
        lcd_cmd(0x90);
        lcd_str("-  PERFECT  -");
    }else{

        lcd_cmd(0x80);
        lcd_str("VOCE FEZ:");
        lcd_cmd(0xC0);
        lcd_str(valor);
        lcd_cmd(0x90);
        lcd_str("PONT MAX:");
        lcd_cmd(0xD0);
        lcd_str("500");
    }
    atraso_ms(3000);
}


void musica(unsigned char msc[20], unsigned char mscC[20], int op){
    unsigned char i;
    unsigned char tmp;

    (*(volatile __near unsigned char*)0xF81) = 0x00;
    (*(volatile __near unsigned char*)0xF83) = 0x00;

    cont = 0;

    msgDisplay(op);

    msgInicio();

    lcd_cmd(0x01);
    lcd_cmd(0xC0);
    lcd_str("TOCANDO: ");
    lcd_cmd(0x90);
    if(op == 1){
        lcd_str("  JULIETA");

    }else{
        lcd_str("  MOZART");
    }

    (*(volatile __near unsigned char*)0xF81) = 0x00;
    for(i = 0; i < 20; i++){
        (*(volatile __near unsigned char*)0xF81) = 0x00;
        (((*(volatile __near unsigned char*)0xF81)) |= (1<<msc[i]));
        atraso_ms(atrasoMax);
        (((*(volatile __near unsigned char*)0xF81)) &= ~(1<<msc[i]));
        atraso_ms(atrasoMax);
        (*(volatile __near unsigned char*)0xF81) = 0x00;

        (*(volatile __near unsigned char*)0xF95)=0x0F;
        tmp=tc_tecla(1000)+0x30;
        (*(volatile __near unsigned char*)0xF95)=0x00;

        if(tmp == mscC[i]){

            cont += 250;
            pontua();
            buzzer(op);
        }
        (*(volatile __near unsigned char*)0xF81) = 0x3F;
        (*(volatile __near unsigned char*)0xF83) = 0x3F;
    }


}


void menu() {

    unsigned char i;
    unsigned char tmp;
    (*(volatile __near unsigned char*)0xFC1) = 0x06;
    (*(volatile __near unsigned char*)0xF93) = 0x00;
    (*(volatile __near unsigned char*)0xF95) = 0x00;
    (*(volatile __near unsigned char*)0xF96) = 0x00;

    unsigned char mozart[] = {2, 4, 3, 5, 1, 2, 3, 4, 1, 1, 2, 4, 3, 1, 2, 1, 2 , 3, 2, 4 };
    unsigned char mozartC[] = {'2', '4', '3', '5', '1', '2', '3', '4', '1', '1', '2', '4', '3', '1', '2', '1', '2' , '3', '2', '4'};

    unsigned char julieta[] = {1, 1, 3, 5, 4, 2, 2, 2, 3, 4, 5, 5, 2, 1, 3, 3, 4 , 1, 1, 5};
    unsigned char julietaC[] = {'1', '1', '3', '5', '4', '2', '2', '2', '3', '4', '5', '5', '2', '1', '3', '3', '4' , '1', '1', '5'};

    lcd_init();

    lcd_cmd(0x01);
    lcd_cmd(0x80);
    lcd_str("   WELCOME");
    lcd_cmd(0xC0);
    lcd_str("----------------");
    lcd_cmd(0x90);
    lcd_str("  PLAY GUITAR");
    atraso_ms(atrasoMax);

    while(1){
        lcd_cmd(0x01);
        lcd_cmd(0x80);
        lcd_str("Escolha a musica");
        lcd_cmd(0xC0);
        lcd_str("(1) - JULIETA");
        lcd_cmd(0x90);
        lcd_str("(2) - MOZART");
        lcd_cmd(0xD0);
        lcd_str("****************");
        (*(volatile __near unsigned char*)0xF95) = 0x0F;
        tmp = tc_tecla(0) + 0x30;

        (*(volatile __near unsigned char*)0xF95) = 0x00;

        if(tmp == '1' || tmp == '2'){
            if(tmp == '1'){
                musica(julieta, julietaC, 1);
                pontFinal();
            }else{
                musica(mozart, mozartC, 2);
                pontFinal();
            }
        }else{
            lcd_cmd(0x01);
            lcd_cmd(0xD0);
            lcd_dat(tmp);
            lcd_cmd(0x90);
            lcd_str("Op <1> ou <2> ");
        }
        atraso_ms(atrasoMax);
    }

}

int main(){
    menu();
    return 0;
}
