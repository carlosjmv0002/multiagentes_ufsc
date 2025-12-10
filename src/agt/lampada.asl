// Light agent - Lighting control system

!inicializar_lampada.

+!inicializar_lampada
  <- 	.print("Lampada inicializada.");
  	   	.print("Modo: Teste automatico (sem GUI)");
  	   	+ligada(false).
  	   	
+interuptor 
  <-  !!verificar_lampada.
      
+closed  <-  .print("Close event from GUIInterface").
   
+!verificar_lampada: ligada(false)  
 	<-  .print("Alguem DESLIGOU a Lampada").
 	
+!verificar_lampada: ligada(true)  
 	<-  .print("Alguem LIGOU a Lampada").

// Scenario 1: Owner arrives - turn on lights
+ajustar_iluminacao(P, ligada)
	<-  .print("Ligando luzes para ", P);
		!ligar_lampada.

+ajustar_iluminacao(P, desligada)
	<-  .print("Mantendo luzes desligadas conforme preferencia de ", P).

+!ligar_lampada: ligada(false)
 	<-  -ligada(false);
 		+ligada(true);
 		.print("Liguei a Lampada!").

+!ligar_lampada: ligada(true)
 	<-  .print("Lampada ja estava ligada.").

// Scenario 2: Owner leaves - turn off lights
+desligar_sistema
	<-  .print("Desligando lampadas...");
		!desligar_lampada.

+!desligar_lampada: ligada(true)
	<-  -ligada(true);
		+ligada(false);
		.print("Lampada desligada.").

+!desligar_lampada: ligada(false)
	<-  .print("Lampada ja estava desligada.").

// Scenario 3: Intruder detected - turn off lights to disorient
+modo_defesa
	<-  .print("MODO DE DEFESA: Apagando todas as luzes!");
		!apagar_luzes_defesa.

+!apagar_luzes_defesa: ligada(true)
	<-  -ligada(true);
		+ligada(false);
		.print("Luzes apagadas para desorientar intruso!").

+!apagar_luzes_defesa: ligada(false)
	<-  .print("Luzes ja estavam apagadas.").
