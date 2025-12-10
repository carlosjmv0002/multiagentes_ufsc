// Air conditioning agent - Climate control system

temperatura_de_preferencia(jonas,25).

!inicializar_AC.

+!inicializar_AC
  <- 	.print("Ar condicionado inicializado.");
  	   	.print("Modo: Teste automatico (sem GUI)");
  	   	+ligado(false);
  	   	+temperatura_ambiente(25);
  	   	+temperatura_ac(25).

+alterado : temperatura_ambiente(TA) & temperatura_ac(TAC)
  <-  .drop_intention(climatizar);
  	  .print("Houve interacao com o ar condicionado!");
  	  .print("Temperatura Ambiente: ", TA);
 	  .print("Temperatura Desejada: ", TAC);
  	  !!climatizar.
      
+closed  <-  .print("Close event from GUIInterface").

// Scenario 1: Owner arrives - set to preferred temperature
+ajustar_para_proprietario(P, Temp)
	<-  .print("Ajustando AC para preferencia de ", P, ": ", Temp, "C");
		-temperatura_ac(_);
		+temperatura_ac(Temp);
		!!climatizar.

// Scenario 2: Owner leaves - turn off AC
+desligar_sistema
	<-  .print("Desligando ar condicionado...");
		!desligar_ac.

+!desligar_ac: ligado(true)
	<-  -ligado(true);
		+ligado(false);
		.print("AC desligado.").

+!desligar_ac: ligado(false)
	<-  .print("AC ja estava desligado.").

// Scenario 3: Intruder detected - set extreme temperature
+modo_defesa
	<-  .print("MODO DE DEFESA: Configurando temperatura extrema!");
		!temperatura_extrema.

+!temperatura_extrema
	<-  .random(R);
		if (R < 0.5) {
			.print("Configurando temperatura MUITO FRIA (10C)!");
			-temperatura_ac(_);
			+temperatura_ac(10);
		} else {
			.print("Configurando temperatura MUITO QUENTE (35C)!");
			-temperatura_ac(_);
			+temperatura_ac(35);
		};
		!!climatizar.

// Normal climate control logic
+!definir_temperatura: temperatura_ambiente(TA) & temperatura_ac(TAC) 
 			& temperatura_de_preferencia(User,TP) & TP \== TD & ligado(false)
 	<-  definir_temperatura(TP);
 		.print("Definindo temperatura baseado na preferencia do usuario ", User);
 		.print("Temperatura: ", TP).
 	
+!definir_temperatura: temperatura_ambiente(TA) & temperatura_ac(TAC) & ligado(false)
 	<-  .print("Usando ultima temperatura");
 		.print("Temperatura: ", TAC).
 		
+!climatizar: temperatura_ambiente(TA) & temperatura_ac(TAC) & TA \== TAC & ligado(false)
 	<-  -ligado(false);
 		+ligado(true);
 		.print("Ligando ar condicionado...");
 		.print("Temperatura Ambiente: ", TA);
 		.print("Temperatura Desejada: ", TAC);
 		.wait(1000);
 		// Simula ajuste de temperatura
 		-temperatura_ambiente(_);
 		+temperatura_ambiente(TAC);
 		!!climatizar.
 		
+!climatizar: temperatura_ambiente(TA) & temperatura_ac(TAC) & TA \== TAC & ligado(true) 
 	<-  .print("Regulando temperatura de ", TA, " para ", TAC, "...");
 		-temperatura_ambiente(_);
 		+temperatura_ambiente(TAC);
 		.wait(1000);
 		!!climatizar.
 		 	
+!climatizar: temperatura_ambiente(TA) & temperatura_ac(TAC) & TA == TAC & ligado(true) 
 	<-  -ligado(true);
 		+ligado(false);
 		.print("Temperatura regulada!");
 		.print("Temperatura Ambiente: ", TA);
 		.print("Temperatura Desejada: ", TAC).

+!climatizar 
 	<- 	.print("Nao foram implementadas outras opcoes.");
 		.print("Temperatura regulada.").
