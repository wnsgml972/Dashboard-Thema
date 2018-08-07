#include <pcap.h>
#include <stdio.h>
#include <stdlib.h> // for exit()
#include <net/ethernet.h>
#include <netinet/tcp.h>   //Provides declarations for tcp header
#include <netinet/ip.h>    //Provides declarations for ip header
 
char IPsec_Flag= 0;

void print_data (const u_char * data , int Size)
{

    FILE* fp = NULL;
    fp = fopen("packet.txt","w+");    
    if(fp==NULL)
	printf("FILE open error");
    int i , j;
    for(i=0 ; i < Size ; i++) {
        if( i!=0 && i%16==0) {  //if one line of hex printing is complete...
            printf("         ");
            for(j=i-16 ; j<i ; j++) {
                if(data[j]>=32 && data[j]<=128)
                  printf("%c", (unsigned char)data[j]);
		else if(IPsec_Flag ==1)
		  printf(".");
		else if(data[j]>=234 && data[j] <=237){
		printf("%c%c%c",(unsigned char)data[j],(unsigned char)data[j+1],(unsigned char)data[j+2]);
	j+=2;	}
		else if(data[j]==10)
			printf(" \b");
		else if(data[j]<=32)
			printf(" \b");
                else
                  printf(" \b");
            }
            printf("\n");
        }
 
        if(i%16==0)
          printf("   ");
            printf(" %02X",(unsigned int)data[i]);
 
        if( i==Size-1) {  //print the last spaces
            for(j=0;j<15-i%16;j++)
              printf("   "); //extra spaces
            printf("         ");
            for(j=i-i%16 ; j<=i ; j++) {
                if(data[j] >=32 && data[j]<=128)	//English Ascii
               printf("%c",(unsigned char)data[j]);
		else if(data[j]>=234 && data[j] <=237){	//Korean Ascii
               printf("%c%c%c",(unsigned char)data[j],(unsigned char)data[j+1],(unsigned char)data[j+2]);
        j+=2;   }
		else if(data[j]==10)
			printf(" \b");
                else if(data[j]<32)
                  printf(" \b");
		else
			printf(" \b");
            }
            printf("\n" );
        }
    }


// ----------------- fprint ICMP / ESP Header ----------------------

 if(IPsec_Flag==0)
     fprintf(fp,"TCP");
  else
      printf("ESP");
fprintf(fp," $$$$$");

 // ------------------- fprint hex binary -------------------------
     
   for(i=0;i<Size;i++){
            fprintf(fp," %02X",(unsigned int)data[i]);

        if( i==Size-1) {  //print the last spaces
           ; 
            for(j=i-i%16 ; j<=i ; j++) {
                if(data[j] >=32 && data[j]<=128)        //English Ascii
             fprintf(fp,"%c",(unsigned char)data[j]);
                else if(data[j]>=234 && data[j] <=237){ //Korean Ascii
              //  printf("%c%c%c",(unsigned char)data[j],(unsigned char)data[j+1],(unsigned char)data[j+2]);
                j+=2;  
               }
                else if(data[j]==10)
                        ;
                else if(data[j]<32)
                        ;
                else
                        ;
            }
           fprintf(fp," $$$$$ " );
        }
    }

     
 // -------------------  fprint UTF-16 Data ------------------------

    for(i=0 ; i < Size ; i++) {
	
 
        if( i!=0 && i%16==0) {  //if one line of hex printing is complete...
                ;
            for(j=i-16 ; j<i ; j++) {
                if(data[j]>=32 && data[j]<=128)
                  fprintf(fp,"%c", (unsigned char)data[j]);
		else if(IPsec_Flag ==1)
                  fprintf(fp,".");
                else if(data[j]>=234 && data[j] <=237){
                  fprintf(fp,"%c%c%c",(unsigned char)data[j],(unsigned char)data[j+1],(unsigned char)data[j+2]);
                  j+=2;   }
                else if(data[j]==10)
                        ;
                else if(data[j]<=32)
                        ;
                else
                  ;
            }
        }
	if( i==Size -1)  //last data print
		for(j=i-i%16; j<=i; j++)
		{
		  if(data[j] >=32 && data[j]<=128)        //English Ascii
               fprintf(fp,"%c",(unsigned char)data[j]);
                else if(data[j]>=234 && data[j] <=237){ //Korean Ascii
               fprintf(fp,"%c%c%c",(unsigned char)data[j],(unsigned char)data[j+1],(unsigned char)data[j+2]);
        j+=2;   }
                else if(data[j]==10)
                        ;
                else if(data[j]<32)
                  	;
                else
                        ;

		}
    }
   fprintf(fp," $$$$$\n\n");	

fclose(fp);

}
 
void print_esp_packet(const u_char * Buffer, int Size)
{
    if (Size > 363) {
      print_data(Buffer + 363, Size - 363 );
    }
}

void print_tcp_packet(const u_char * Buffer, int Size)
{
    unsigned short iphdrlen;

    struct iphdr *iph = (struct iphdr *)( Buffer  + sizeof(struct ethhdr) );
    iphdrlen = iph->ihl*4;

    struct tcphdr *tcph=(struct tcphdr*)(Buffer + iphdrlen + sizeof(struct ethhdr));

    int header_size =  sizeof(struct ethhdr) + iphdrlen + tcph->doff*4;

    if (Size > 322) {
      print_data(Buffer + 322, Size - 322 );
    }
}

void process_packet(u_char *args, const struct pcap_pkthdr *header, const u_char *buffer)
{
    int size = header->len;

    //Get the IP Header part of this packet , excluding the ethernet header
    struct iphdr *iph = (struct iphdr*)(buffer + sizeof(struct ethhdr));
    switch (iph->protocol) //Check the Protocol and do accordingly...
    {
        case 6:  //TCP Protocol
            IPsec_Flag = 0;
	    print_tcp_packet(buffer , size);
            break;
        case 50:  //ESP Protocol
	    IPsec_Flag =1;
            print_esp_packet(buffer , size);
            break;
    }
}
 
int main(int argc, char* argv[])
{
 
   char errbuf[100] , *devname;
   pcap_t *handle; //Handle of the device that shall be sniffed
   
   printf("argc : %d\n\n\n\n\n",argc);//command count print
   printf("str0: %s\n",argv[0]);
   printf("str1: %s\n",argv[1]);
   if (argc == 1) {
     fputs("\nUsage ./snif devname(ex. eth0)\n\n", stderr);
     exit(1);
   }
 
    devname = argv[1];
 
    //Open the device for sniffing
    printf("Opening device %s for sniffing ... " , devname);
    handle = pcap_open_live(devname , 65536 , 1 , 0 , errbuf);
 
    if (handle == NULL)
    {
        printf("Couldn't open device %s\n" , devname);
        exit(1);
    }
    printf("Done\n");
 
    //Put the device in sniff loop
    pcap_loop(handle , -1 , process_packet , NULL);
    printf("loop end"); 
    return 0;
}
