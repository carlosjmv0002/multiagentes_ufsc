// Door lock agent - Security system
// Controls door lock and opening/closing

!inicializar_fechadura.

+!inicializar_fechadura
  <- 	.print("Fechadura inicializada.");
  	   	.print("Modo: Teste automatico (sem GUI)");
  	   	+fechada(true);
  	   	+trancada(false).
  	   	
+movimento_macaneta <- !verificar_fechada.

+!verificar_fechada: trancada(true) 
  <-  .print("Alguem mexeu na MACANETA, porem a porta esta trancada!").
+!verificar_fechada: fechada(true)
  <-  .print("Alguem mexeu na MACANETA e FECHOU a porta!").
+!verificar_fechada: fechada(false)
  <-  .print("Alguem mexeu na MACANETA e ABRIU a porta!").
  
+movimento_fechadura <- !verificar_trancada.

+!verificar_trancada: trancada(true)
  <-  .print("Alguem mexeu na FECHADURA e TRANCOU a porta!").
+!verificar_trancada: trancada(false)
  <-  .print("Alguem mexeu na FECHADURA e DESTRANCOU a porta!").
      
+closed  <-  .print("Close event from GUIInterface").

// Scenario 1: Owner arrives - unlock and open door
+proprietario_chegou(P)
	<-  .print("Recebido aviso de chegada do proprietario ", P);
		!destrancar_e_abrir_porta;
		.print("Porta aberta para ", P, ".").

+!destrancar_e_abrir_porta: trancada(true)
	<-  -trancada(true);
		+trancada(false);
		.print("Porta destrancada.");
		.wait(500);
		!destrancar_e_abrir_porta.

+!destrancar_e_abrir_porta: fechada(true) & trancada(false)
	<-  -fechada(true);
		+fechada(false);
		.print("Porta aberta.");
		.wait(500);
		!destrancar_e_abrir_porta.

+!destrancar_e_abrir_porta: fechada(false) & trancada(false)
	<-  .print("Porta completamente aberta!").

// Scenario 2: Owner leaves - close and lock door
+fechar_e_trancar
	<-  .print("Recebido comando para fechar e trancar.");
		!fechar_porta.

+!fechar_porta: fechada(true)
 	<-  .print("Porta Fechada!");
 		!trancar_porta.
 	
+!fechar_porta: fechada(false)
 	<-  -fechada(false);
 		+fechada(true);
 		.print("FECHEI a porta");
 		.wait(500);
 		!fechar_porta.
 		
+!trancar_porta: trancada(true)
 	<- .print("Porta Trancada!").
 	
+!trancar_porta: trancada(false)
 	<- 	-trancada(false);
 		+trancada(true);
 		.print("TRANQUEI a porta!");
 		.wait(500);
 		!trancar_porta.

// Scenario 3: Intruder detected - ensure door is locked
+modo_defesa
	<-  .print("MODO DE DEFESA: Garantindo porta trancada!");
		!garantir_trancada.

+!garantir_trancada: trancada(true)
	<-  .print("Porta ja esta trancada.").

+!garantir_trancada: trancada(false)
	<-  .print("Trancando porta imediatamente!");
		!fechar_porta.
