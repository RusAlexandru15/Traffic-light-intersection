library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity INTERSECTIE is
port(
START: in std_logic;		   --switchul de start/reset

clk :in std_logic;     --intrare de clock/tact specific automatelor sincrone
mode: in std_logic;		--regim test sau regim normal

senz3 : in  std_logic;	  --senzorii de pe benzile 3,4,5,6,7
senz4 : in  std_logic;  
senz5 : in  std_logic;				   
senz6 : in  std_logic;  
senz7 : in  std_logic;

input1  : in std_logic;	  	 --input-uri pentru : regimul de test 
input2  : in std_logic; 

pet1  : out std_logic_vector(1 downto 0);	--semafoare pietoni (verde/rosu)
pet2  : out std_logic_vector(1 downto 0);
pet3  : out std_logic_vector(1 downto 0);

sem1 :  out std_logic_vector(1 downto 0);  --semafoare masini (verde/galben/rosu)
sem2 :  out std_logic_vector(1 downto 0);
sem3 :  out std_logic_vector(1 downto 0);
sem4 :  out std_logic_vector(1 downto 0);
sem5 :  out std_logic_vector(1 downto 0);
sem6 :  out std_logic_vector(1 downto 0);
sem7 :  out std_logic_vector(1 downto 0);
sem8 :  out std_logic_vector(1 downto 0);
sem9 :  out std_logic_vector(1 downto 0);
sem10:  out std_logic_vector(1 downto 0)
);	 
end INTERSECTIE;

architecture arhitectura of INTERSECTIE is 

  type stari is (st1,st2,st3,st4,st5,st6); --declar tipul de stari
  signal stare,nstare :stari ;--declar 2 semnale de tipul stari:starea curenta si urmatoare
   signal senzgen1,senzgen2 : std_logic;
  begin	 	 
	        
	   	
	 modint:process (Mode,input1,input2,senz3,senz4,senz5,senz6,senz7)	--modul intersectiei
	  begin 
			if Mode = '1' then		
				 Senzgen1<=input1;	--mode=1 este pentru regimul de test
				 Senzgen2<=input2;
			else   
				 senzgen1 <=(senz4 and senz6) or (senz4 and senz7) or (senz6 and  senz7) ;   --mode=0 pentru regimul automat	
	   senzgen2<= (senz3 and senz4) or (senz3 and senz5)or(senz3 and senz6)or(senz4 and  senz5)or(senz4 and senz6)or(senz5 and senz6);
			end if;	
	end process ;	
	
	tranzitie : process(clk,start)	--resetarea circuitului + trecerea la starea urmatoare
	begin	   
		if start='1' then 
			stare<=st1;	
		elsif clk'event and clk='1' then 
			stare <=nstare;	 
		end if;	
		end process; 	

	semafoare: process(stare,senzgen1,senzgen2)
	begin 
		           pet1 <= "00";  		             --"00" verde
				   pet2<="10";				  		 --"10" rosu 
				   pet3<="10" ;						 --"01" galben
					Sem1 <= "10";
					Sem2 <= "10";
					Sem3 <= "10";
					Sem4 <= "00";
					Sem5 <= "10";
					Sem6 <= "00";
					Sem7 <= "00";
					Sem8 <= "10";
					Sem9 <= "10";
					Sem10<= "00";
		case stare is
		when st1 =>	 
			 pet1 <= "00";  --p1 verde			 
				   pet2<="10";				  
				   pet3<="10" ;
					Sem1 <= "10";
					Sem2 <= "10";
					Sem3 <= "10";
					Sem4 <= "00";
					Sem5 <= "10";
					Sem6 <= "00";
					Sem7 <= "00";
					Sem8 <= "10";
					Sem9 <= "10";
					Sem10<= "00";
			if senzgen1='1' then nstare<=st1;
			else nstare <=st2;
			end if;
		 when st2 =>	        --p1 rosu
		           pet1 <= "10";
				   pet2<="10";
				   pet3<="10" ;
					Sem1 <= "10";
					Sem2 <= "10";
					Sem3 <= "10";
					Sem4 <= "01";
					Sem5 <= "10";
					Sem6 <= "01";
					Sem7 <= "01";
					Sem8 <= "01";
					Sem9 <= "10";
					Sem10<= "01";
			nstare<=st3;
		when st3 =>				  --p2 verde
			       pet1 <= "10";
				   pet2<="00";
				   pet3<="10" ;
					Sem1 <= "10";
					Sem2 <= "00";
					Sem3 <= "00";
					Sem4 <= "10";
					Sem5 <= "10";
					Sem6 <= "10";
					Sem7 <= "10";
					Sem8 <= "00";
					Sem9 <= "00";
					Sem10<= "10";
			nstare<=st4;
		when st4 =>				 --p2 rosu
		           pet1 <= "10";
				   pet2<="10";
				   pet3<="10"; 
					Sem1 <= "10";
					Sem2 <= "01";
					Sem3 <= "01";
					Sem4 <= "10";
					Sem5 <= "10";
					Sem6 <= "10";
					Sem7 <= "10";
					Sem8 <= "01";
					Sem9 <= "01";
					Sem10<= "10";
		    nstare <=st5;	
			
		when st5 =>				 --p3 verde
		           pet1 <= "10";
				   pet2<="10";
				   pet3<="00"; 
					Sem1 <= "00";
					Sem2 <= "10";
					Sem3 <= "00";
					Sem4 <= "10";
					Sem5 <= "00";
					Sem6 <= "00";
					Sem7 <= "10";
					Sem8 <= "10";
					Sem9 <= "10";
					Sem10<= "10";  
			if senzgen2= '1' then nstare <=st5 ;
		     	else nstare<=st6 ;
			end if;
		when st6 =>	          --p3 rosu
			  pet1 <= "10" ;
				   pet2<="10" ;
				   pet3<="10"  ;
					Sem1 <= "01";
					Sem2 <= "10";
					Sem3 <= "01";
					Sem4 <= "10";
					Sem5 <= "01";
					Sem6 <= "01";
					Sem7 <= "10";
					Sem8 <= "10";				
					Sem9 <= "10";
					Sem10<= "10"; 
			nstare <= st1;		
				when others => null;
			end case; 
		end process;	
end arhitectura;